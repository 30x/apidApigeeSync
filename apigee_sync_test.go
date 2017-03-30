package apidApigeeSync

import (
	"github.com/30x/apid-core"
	"github.com/apigee-labs/transicator/common"
	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

var _ = Describe("listener", func() {

	It("should bootstrap from local DB if present", func(done Done) {

		expectedTables := make(map[string]bool)
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

	It("should correctly identify non-proper subsets with respect to maps", func() {

		//test b proper subset of a
		Expect(mapIsSubset(map[string]bool{"a": true, "b": true}, map[string]bool{"b": true})).To(BeTrue())

		//test a == b
		Expect(mapIsSubset(map[string]bool{"a": true, "b": true}, map[string]bool{"a": true, "b": true})).To(BeTrue())

		//test b superset of a
		Expect(mapIsSubset(map[string]bool{"a": true, "b": true}, map[string]bool{"a": true, "b": true, "c": true})).To(BeFalse())

		//test b not subset of a
		Expect(mapIsSubset(map[string]bool{"a": true, "b": true}, map[string]bool{"c": true})).To(BeFalse())

		//test b empty
		Expect(mapIsSubset(map[string]bool{"a": true, "b": true}, map[string]bool{})).To(BeTrue())

		//test a empty
		Expect(mapIsSubset(map[string]bool{}, map[string]bool{"b": true})).To(BeFalse())
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

	It("Verify the Sequence Number Logic works as expected", func() {
		Expect(getChangeStatus("1.1.1", "1.1.2")).To(Equal(1))
		Expect(getChangeStatus("1.1.1", "1.2.1")).To(Equal(1))
		Expect(getChangeStatus("1.2.1", "1.2.1")).To(Equal(0))
		Expect(getChangeStatus("1.2.1", "1.2.2")).To(Equal(1))
		Expect(getChangeStatus("2.2.1", "1.2.2")).To(Equal(-1))
		Expect(getChangeStatus("2.2.1", "2.2.0")).To(Equal(-1))
	})

	/*
	 * XAPID-869, there should not be any panic if received duplicate snapshots during bootstrap
	 */
	It("Should be able to handle duplicate snapshot during bootstrap", func() {
		scopes := []string{apidInfo.ClusterID}
		snapshot := downloadSnapshot(scopes)
		storeBootSnapshot(snapshot)
		storeDataSnapshot(snapshot)
	})

})
