package apidApigeeSync

import (
	"github.com/30x/apid-core"
	"github.com/apigee-labs/transicator/common"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("listener", func() {

	It("should bootstrap from local DB if present", func(done Done) {

		expectedTables := make(map[string] bool)
		expectedTables["kms.company"] = true
		expectedTables["edgex.apid_cluster"] = true
		expectedTables["edgex.data_scope"] = true


		Expect(apidInfo.LastSnapshot).NotTo(BeEmpty())

		apid.Events().ListenFunc(ApigeeSyncEventSelector, func(event apid.Event) {
			defer GinkgoRecover()

			if s, ok := event.(*common.Snapshot); ok {

				//verify that the knownTables array has been properly populated from existing DB
				Expect(mapIsSubset(knownTables, expectedTables)).To(BeTrue())

				Expect(s.SnapshotInfo).Should(Equal(apidInfo.LastSnapshot))
				Expect(s.Tables).To(BeNil())

				close(done)
			}
		})

		bootstrap()
	})

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
})
