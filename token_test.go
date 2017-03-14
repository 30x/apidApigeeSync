package apidApigeeSync

import (
	"time"

	"net/http"
	"net/http/httptest"

	"encoding/json"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("token", func() {

	Context("oauthToken", func() {

		It("should calculate valid token", func() {
			t := &oauthToken{
				AccessToken: "x",
				ExpiresIn:   120000,
				ExpiresAt:   time.Now().Add(2 * time.Minute),
			}
			Expect(t.refreshIn().Seconds()).To(BeNumerically(">", 0))
			Expect(t.needsRefresh()).To(BeFalse())
			Expect(t.isValid()).To(BeTrue())
		})

		It("should calculate expired token", func() {
			t := &oauthToken{
				AccessToken: "x",
				ExpiresIn:   0,
				ExpiresAt:   time.Now(),
			}
			Expect(t.refreshIn().Seconds()).To(BeNumerically("<", 0))
			Expect(t.needsRefresh()).To(BeTrue())
			Expect(t.isValid()).To(BeFalse())
		})

		It("should calculate token needing refresh", func() {
			t := &oauthToken{
				AccessToken: "x",
				ExpiresIn:   59000,
				ExpiresAt:   time.Now().Add(time.Minute - time.Second),
			}
			Expect(t.refreshIn().Seconds()).To(BeNumerically("<", 0))
			Expect(t.needsRefresh()).To(BeTrue())
			Expect(t.isValid()).To(BeTrue())
		})

		It("should calculate on empty token", func() {
			t := &oauthToken{}
			Expect(t.refreshIn().Seconds()).To(BeNumerically("<=", 0))
			Expect(t.needsRefresh()).To(BeTrue())
			Expect(t.isValid()).To(BeFalse())
		})
	})

	Context("tokenMan", func() {

		It("should get a valid token", func() {
			token := tokenManager.getToken()

			Expect(token.AccessToken).ToNot(BeEmpty())
			Expect(token.ExpiresIn > 0).To(BeTrue())
			Expect(token.ExpiresAt).To(BeTemporally(">", time.Now()))

			bToken := tokenManager.getBearerToken()
			Expect(bToken).To(Equal(token.AccessToken))
		})

		It("should refresh when forced to", func() {
			token := tokenManager.getToken()
			Expect(token.AccessToken).ToNot(BeEmpty())

			tokenManager.invalidateToken()

			token2 := tokenManager.getToken()
			Expect(token).ToNot(Equal(token2))
			Expect(token.AccessToken).ToNot(Equal(token2.AccessToken))
		})

		It("should refresh in refresh interval", func(done Done) {

			finished := make(chan bool)
			var tm *tokenMan
			start := time.Now()
			count := 0
			ts := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				defer GinkgoRecover()

				count++

				if count > 1 {
					if start.Add(500).After(time.Now()) {
						Fail("didn't refresh within expected interval")
					}
					finished <- true
				}

				res := oauthToken{
					AccessToken: string(count),
					ExpiresIn:   1000,
				}
				body, err := json.Marshal(res)
				Expect(err).NotTo(HaveOccurred())
				w.Write(body)
			}))
			defer ts.Close()

			tokenManager.close()
			oldBase := config.Get(configProxyServerBaseURI)
			config.Set(configProxyServerBaseURI, ts.URL)
			oldFloat := refreshFloatTime
			refreshFloatTime = 950 * time.Millisecond
			defer func() {
				tm.close()
				config.Set(configProxyServerBaseURI, oldBase)
				tokenManager = createTokenManager()
				refreshFloatTime = oldFloat
			}()

			tm = createTokenManager()
			<-finished
			close(done)
		})
	})
})
