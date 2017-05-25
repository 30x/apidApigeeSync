package apidApigeeSync

import (
	"github.com/30x/apid-core"
	"github.com/apigee-labs/transicator/common"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
	"net/http"
	"net/http/httptest"
)

var _ = Describe("Sync", func() {

	Context("Sync", func() {

		const expectedDataScopeId1 = "dataScope1"
		const expectedDataScopeId2 = "dataScope2"

		var initializeContext = func() {
			testRouter = apid.API().Router()
			testServer = httptest.NewServer(testRouter)

			// set up mock server
			mockParms := MockParms{
				ReliableAPI:  false,
				ClusterID:    config.GetString(configApidClusterId),
				TokenKey:     config.GetString(configConsumerKey),
				TokenSecret:  config.GetString(configConsumerSecret),
				Scope:        "ert452",
				Organization: "att",
				Environment:  "prod",
			}
			testMock = Mock(mockParms, testRouter)

			config.Set(configProxyServerBaseURI, testServer.URL)
			config.Set(configSnapServerBaseURI, testServer.URL)
			config.Set(configChangeServerBaseURI, testServer.URL)
		}

		var restoreContext = func() {

			testServer.Close()

			config.Set(configProxyServerBaseURI, dummyConfigValue)
			config.Set(configSnapServerBaseURI, dummyConfigValue)
			config.Set(configChangeServerBaseURI, dummyConfigValue)

		}

		It("should succesfully bootstrap from clean slate", func(done Done) {
			log.Info("Starting sync tests...")
			var closeDone <-chan bool
			initializeContext()
			// do not wipe DB after.  Lets use it
			wipeDBAferTest = false
			var lastSnapshot *common.Snapshot

			expectedSnapshotTables := common.ChangeList{
				Changes: []common.Change{common.Change{Table: "kms_company"},
					common.Change{Table: "edgex_apid_cluster"},
					common.Change{Table: "edgex_data_scope"},
					common.Change{Table: "kms_app_credential"},
					common.Change{Table: "kms_app_credential_apiproduct_mapper"},
					common.Change{Table: "kms_developer"},
					common.Change{Table: "kms_company_developer"},
					common.Change{Table: "kms_api_product"},
					common.Change{Table: "kms_app"}},
			}

			apid.Events().ListenFunc(ApigeeSyncEventSelector, func(event apid.Event) {
				if s, ok := event.(*common.Snapshot); ok {

					Expect(16).To(Equal(len(knownTables)))
					Expect(changesRequireDDLSync(expectedSnapshotTables)).To(BeFalse())

					lastSnapshot = s

					db, _ := dataService.DBVersion(s.SnapshotInfo)
					var rowCount int
					var id string

					err := db.Ping()
					Expect(err).NotTo(HaveOccurred())
					numApidClusters, err := db.Query("select distinct count(*) from edgex_apid_cluster;")
					if err != nil {
						Fail("Failed to get correct DB")
					}
					Expect(true).To(Equal(numApidClusters.Next()))
					numApidClusters.Scan(&rowCount)
					Expect(1).To(Equal(rowCount))
					apidClusters, _ := db.Query("select id from edgex_apid_cluster;")
					apidClusters.Next()
					apidClusters.Scan(&id)
					Expect(id).To(Equal(expectedClusterId))

					numDataScopes, _ := db.Query("select distinct count(*) from edgex_data_scope;")
					Expect(true).To(Equal(numDataScopes.Next()))
					numDataScopes.Scan(&rowCount)
					Expect(2).To(Equal(rowCount))
					dataScopes, _ := db.Query("select id from edgex_data_scope;")
					dataScopes.Next()
					dataScopes.Scan(&id)
					dataScopes.Next()

					if id == expectedDataScopeId1 {
						dataScopes.Scan(&id)
						Expect(id).To(Equal(expectedDataScopeId2))
					} else {
						dataScopes.Scan(&id)
						Expect(id).To(Equal(expectedDataScopeId1))
					}

				} else if cl, ok := event.(*common.ChangeList); ok {
					closeDone = apidChangeManager.close()
					// ensure that snapshot switched DB versions
					Expect(apidInfo.LastSnapshot).To(Equal(lastSnapshot.SnapshotInfo))
					expectedDB, err := dataService.DBVersion(lastSnapshot.SnapshotInfo)
					Expect(err).NotTo(HaveOccurred())
					Expect(getDB() == expectedDB).Should(BeTrue())

					Expect(cl.Changes).To(HaveLen(6))

					var tables []string
					for _, c := range cl.Changes {
						tables = append(tables, c.Table)
						Expect(c.NewRow).ToNot(BeNil())

						var tenantID string
						c.NewRow.Get("tenant_id", &tenantID)
						Expect(tenantID).To(Equal("ert452"))
					}

					Expect(tables).To(ContainElement("kms_app_credential"))
					Expect(tables).To(ContainElement("kms_app_credential_apiproduct_mapper"))
					Expect(tables).To(ContainElement("kms_developer"))
					Expect(tables).To(ContainElement("kms_company_developer"))
					Expect(tables).To(ContainElement("kms_api_product"))
					Expect(tables).To(ContainElement("kms_app"))

					go func() {
						// when close done, all handlers for the first changeList have been executed
						<-closeDone
						defer GinkgoRecover()
						// allow other handler to execute to insert last_sequence
						var seq string
						err = getDB().
							QueryRow("SELECT last_sequence FROM EDGEX_APID_CLUSTER LIMIT 1;").
							Scan(&seq)
						Expect(err).NotTo(HaveOccurred())
						//}
						Expect(seq).To(Equal(cl.LastSequence))

						restoreContext()
						close(done)
					}()

				}
			})
			pie := apid.PluginsInitializedEvent{
				Description: "plugins initialized",
			}
			pie.Plugins = append(pie.Plugins, pluginData)
			postInitPlugins(pie)
		}, 5)

		It("should bootstrap from local DB if present", func(done Done) {

			var closeDone <-chan bool

			initializeContext()
			expectedTables := common.ChangeList{
				Changes: []common.Change{common.Change{Table: "kms_company"},
					common.Change{Table: "edgex_apid_cluster"},
					common.Change{Table: "edgex_data_scope"}},
			}
			Expect(apidInfo.LastSnapshot).NotTo(BeEmpty())

			apid.Events().ListenFunc(ApigeeSyncEventSelector, func(event apid.Event) {

				if s, ok := event.(*common.Snapshot); ok {
					// In this test, the changeManager.pollChangeWithBackoff() has not been launched when changeManager closed
					// This is because the changeManager.pollChangeWithBackoff() in bootstrap() happened after this handler
					closeDone = apidChangeManager.close()
					go func() {
						// when close done, all handlers for the first snapshot have been executed
						<-closeDone
						//verify that the knownTables array has been properly populated from existing DB
						Expect(changesRequireDDLSync(expectedTables)).To(BeFalse())

						Expect(s.SnapshotInfo).Should(Equal(apidInfo.LastSnapshot))
						Expect(s.Tables).To(BeNil())

						restoreContext()
						close(done)
					}()

				}
			})
			pie := apid.PluginsInitializedEvent{
				Description: "plugins initialized",
			}
			pie.Plugins = append(pie.Plugins, pluginData)
			postInitPlugins(pie)

		}, 3)

		It("should detect apid_cluster_id change in config yaml", func() {
			Expect(apidInfo).ToNot(BeNil())
			Expect(apidInfo.ClusterID).To(Equal("bootstrap"))
			Expect(apidInfo.InstanceID).ToNot(BeEmpty())
			previousInstanceId := apidInfo.InstanceID

			config.Set(configApidClusterId, "new value")
			apidInfo, err := getApidInstanceInfo()
			Expect(err).NotTo(HaveOccurred())
			Expect(apidInfo.LastSnapshot).To(BeEmpty())
			Expect(apidInfo.InstanceID).ToNot(BeEmpty())
			Expect(apidInfo.InstanceID).ToNot(Equal(previousInstanceId))
			Expect(apidInfo.ClusterID).To(Equal("new value"))
		})

		It("should correctly identify non-proper subsets with respect to maps", func() {

			//test b proper subset of a
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true},
				[]common.Change{common.Change{Table: "b"}},
			)).To(BeFalse())

			//test a == b
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true},
				[]common.Change{common.Change{Table: "a"}, common.Change{Table: "b"}},
			)).To(BeFalse())

			//test b superset of a
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true},
				[]common.Change{common.Change{Table: "a"}, common.Change{Table: "b"}, common.Change{Table: "c"}},
			)).To(BeTrue())

			//test b not subset of a
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true},
				[]common.Change{common.Change{Table: "c"}},
			)).To(BeTrue())

			//test a empty
			Expect(changesHaveNewTables(map[string]bool{},
				[]common.Change{common.Change{Table: "a"}},
			)).To(BeTrue())

			//test b empty
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true},
				[]common.Change{},
			)).To(BeFalse())

			//test b nil
			Expect(changesHaveNewTables(map[string]bool{"a": true, "b": true}, nil)).To(BeFalse())

			//test a nil
			Expect(changesHaveNewTables(nil,
				[]common.Change{common.Change{Table: "a"}},
			)).To(BeTrue())
		}, 3)

		// todo: disabled for now -
		// there is precondition I haven't been able to track down that breaks this test on occasion
		XIt("should process a new snapshot when change server requires it", func(done Done) {
			oldSnap := apidInfo.LastSnapshot
			apid.Events().ListenFunc(ApigeeSyncEventSelector, func(event apid.Event) {
				defer GinkgoRecover()

				if s, ok := event.(*common.Snapshot); ok {
					Expect(s.SnapshotInfo).NotTo(Equal(oldSnap))
					close(done)
				}
			})
			testMock.forceNewSnapshot()
		})

		It("Verify the Sequence Number Logic works as expected", func() {
			Expect(getChangeStatus("1.1.1", "1.1.2")).To(Equal(1))
			Expect(getChangeStatus("1.1.1", "1.2.1")).To(Equal(1))
			Expect(getChangeStatus("1.2.1", "1.2.1")).To(Equal(0))
			Expect(getChangeStatus("1.2.1", "1.2.2")).To(Equal(1))
			Expect(getChangeStatus("2.2.1", "1.2.2")).To(Equal(-1))
			Expect(getChangeStatus("2.2.1", "2.2.0")).To(Equal(-1))
		}, 3)

		/*
		 * XAPID-869, there should not be any panic if received duplicate snapshots during bootstrap
		 */
		It("Should be able to handle duplicate snapshot during bootstrap", func() {
			initializeContext()
			apidTokenManager = createSimpleTokenManager()
			apidTokenManager.start()
			apidSnapshotManager = createSnapShotManager()
			events.Listen(ApigeeSyncEventSelector, &handler{})

			scopes := []string{apidInfo.ClusterID}
			snapshot := &common.Snapshot{}
			apidSnapshotManager.downloadSnapshot(scopes, snapshot)
			apidSnapshotManager.storeBootSnapshot(snapshot)
			apidSnapshotManager.storeDataSnapshot(snapshot)
			restoreContext()
			<-apidSnapshotManager.close()
			apidTokenManager.close()
		}, 3)

		It("Reuse http.Client connection for multiple concurrent requests", func() {
			server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			}))
			tr := &http.Transport{
				MaxIdleConnsPerHost: maxIdleConnsPerHost,
			}
			var rspcnt int = 0
			ch := make(chan *http.Response)
			client := &http.Client{Transport: tr}
			for i := 0; i < 2*maxIdleConnsPerHost; i++ {
				go func(client *http.Client) {
					req, err := http.NewRequest("GET", server.URL, nil)
					resp, err := client.Do(req)
					if err != nil {
						Fail("Unable to process Client request")
					}
					ch <- resp
					resp.Body.Close()

				}(client)
			}
			for {
				select {
				case resp := <-ch:
					Expect(resp.StatusCode).To(Equal(http.StatusOK))
					if rspcnt >= 2*maxIdleConnsPerHost-1 {
						return
					}
					rspcnt++
				default:
				}
			}

		}, 3)

	})
})
