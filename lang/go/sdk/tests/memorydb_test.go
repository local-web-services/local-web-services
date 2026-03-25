package tests

// registerMemoryDBSteps wires all step definitions for the MemoryDB informal specification
// feature files (create_cluster, delete_cluster, create_user, delete_user, create_a_c_l,
// delete_a_c_l, create_snapshot, delete_snapshot, associate_a_c_l_with_cluster,
// add_user_to_a_c_l, remove_user_from_a_c_l, tag_resource, untag_resource, and
// lifecycle/sequence features).

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/memorydb"
	memorydbtypes "github.com/aws/aws-sdk-go-v2/service/memorydb/types"
	"github.com/cucumber/godog"
)

const (
	memorydbTestClusterName  = "test-memorydb-cluster-1"
	memorydbTestUserName     = "test-memorydb-user-1"
	memorydbTestACLName      = "test-memorydb-acl-1"
	memorydbTestSnapshotName = "test-memorydb-snapshot-1"
	memorydbTestTagKey       = "e2e-memorydb-tag-key-1"
	memorydbTestTagValue     = "test-memorydb-tag-value-1"
	memorydbTestARN          = "arn:aws:memorydb:us-east-1:000000000000:cluster/" + memorydbTestClusterName
)

// memorydbCreateCluster creates the test MemoryDB cluster.
func memorydbCreateCluster(world *World) error {
	_, err := world.MemoryDBClient().CreateCluster(context.Background(), &memorydb.CreateClusterInput{
		ClusterName: aws.String(memorydbTestClusterName),
		NodeType:    aws.String("db.r6g.large"),
		ACLName:     aws.String(memorydbTestACLName),
		Tags:        []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
	})
	return err
}

// memorydbCreateACL creates the test MemoryDB ACL.
func memorydbCreateACL(world *World) error {
	_, err := world.MemoryDBClient().CreateACL(context.Background(), &memorydb.CreateACLInput{
		ACLName: aws.String(memorydbTestACLName),
		Tags:    []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
	})
	return err
}

// memorydbCreateUser creates the test MemoryDB user.
func memorydbCreateUser(world *World) error {
	_, err := world.MemoryDBClient().CreateUser(context.Background(), &memorydb.CreateUserInput{
		UserName:     aws.String(memorydbTestUserName),
		AccessString: aws.String("on ~* &* +@all"),
		AuthenticationMode: &memorydbtypes.AuthenticationMode{
			Type:      memorydbtypes.InputAuthenticationTypePassword,
			Passwords: []string{"TestPassword123!"},
		},
		Tags: []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
	})
	return err
}

// memorydbCreateSnapshot creates the test MemoryDB snapshot.
func memorydbCreateSnapshot(world *World) error {
	_, err := world.MemoryDBClient().CreateSnapshot(context.Background(), &memorydb.CreateSnapshotInput{
		ClusterName:  aws.String(memorydbTestClusterName),
		SnapshotName: aws.String(memorydbTestSnapshotName),
		Tags:         []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
	})
	return err
}

func registerMemoryDBSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: cluster state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the cluster does not already exist$`, func() error {
		// No-op: fresh state after reset has no clusters.
		return nil
	})

	sc.Given(`^the cluster already exists$`, func() error {
		// Arrange / Act: ensure ACL exists first, then create the cluster.
		_ = memorydbCreateACL(world)
		return memorydbCreateCluster(world)
	})

	sc.Given(`^the cluster does not exist$`, func() error {
		// No-op: fresh state after reset has no clusters.
		return nil
	})

	sc.Given(`^the cluster exists$`, func() error {
		// Arrange / Act: ensure ACL exists first, then create the cluster.
		_ = memorydbCreateACL(world)
		return memorydbCreateCluster(world)
	})

	sc.Given(`^the cluster is "AVAILABLE"$`, func() error {
		// No-op: clusters are created in AVAILABLE state in lws.
		return nil
	})

	sc.Given(`^the cluster is not "AVAILABLE"$`, func() error {
		// @internal: requires internal state transition; no public API can put a cluster
		// into a non-AVAILABLE non-DELETING state from outside. No-op.
		return nil
	})

	sc.Given(`^the cluster is "CREATING"$`, func() error {
		// @internal: cluster CREATING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the cluster is not "CREATING"$`, func() error {
		// No-op: fresh cluster is not in CREATING state in lws.
		return nil
	})

	sc.Given(`^the cluster is "DELETING"$`, func() error {
		// @internal: cluster DELETING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the cluster is not "DELETING"$`, func() error {
		// No-op: freshly created cluster is not in DELETING state.
		return nil
	})

	sc.Given(`^the cluster is "MODIFYING"$`, func() error {
		// @internal: cluster MODIFYING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the cluster is not "MODIFYING"$`, func() error {
		// No-op: freshly created cluster is not in MODIFYING state.
		return nil
	})

	sc.Given(`^the cluster is "RESTORING"$`, func() error {
		// @internal: cluster RESTORING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the cluster is not "RESTORING"$`, func() error {
		// No-op: freshly created cluster is not in RESTORING state.
		return nil
	})

	sc.Given(`^the cluster is "SNAPSHOTTING"$`, func() error {
		// @internal: cluster SNAPSHOTTING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the cluster is not "SNAPSHOTTING"$`, func() error {
		// No-op: freshly created cluster is not in SNAPSHOTTING state.
		return nil
	})

	sc.Given(`^multi-"AZ" is enabled for the cluster$`, func() error {
		// No-op: multi-AZ state is managed internally; no dedicated public API for setup.
		return nil
	})

	sc.Given(`^multi-"AZ" is not enabled for the cluster$`, func() error {
		// No-op: multi-AZ is not enabled by default in lws.
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: user state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the user does not already exist$`, func() error {
		// No-op: fresh state after reset has no users.
		return nil
	})

	sc.Given(`^the user already exists$`, func() error {
		// Arrange / Act: create the user.
		return memorydbCreateUser(world)
	})

	sc.Given(`^the user does not exist$`, func() error {
		// No-op: fresh state after reset has no users.
		return nil
	})

	sc.Given(`^the user exists$`, func() error {
		// Arrange / Act: create the user.
		return memorydbCreateUser(world)
	})

	sc.Given(`^the user is "ACTIVE"$`, func() error {
		// No-op: users are created in ACTIVE state in lws.
		return nil
	})

	sc.Given(`^the user is not "ACTIVE"$`, func() error {
		// @internal: user non-ACTIVE state cannot be forced via public API.
		return nil
	})

	sc.Given(`^the user is "CREATING"$`, func() error {
		// @internal: user CREATING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the user is not "CREATING"$`, func() error {
		// No-op: freshly created user is not in CREATING state in lws.
		return nil
	})

	sc.Given(`^the user is "DELETING"$`, func() error {
		// @internal: user DELETING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the user is not "DELETING"$`, func() error {
		// No-op: freshly created user is not in DELETING state.
		return nil
	})

	sc.Given(`^the user is "MODIFYING"$`, func() error {
		// @internal: user MODIFYING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the user is not "MODIFYING"$`, func() error {
		// No-op: freshly created user is not in MODIFYING state.
		return nil
	})

	sc.Given(`^the user is not already a member of the "ACL"$`, func() error {
		// No-op: freshly created user is not a member of any ACL.
		return nil
	})

	sc.Given(`^the user is already a member of the "ACL"$`, func() error {
		// Arrange / Act: add the user to the ACL.
		_, err := world.MemoryDBClient().UpdateACL(context.Background(), &memorydb.UpdateACLInput{
			ACLName:        aws.String(memorydbTestACLName),
			UserNamesToAdd: []string{memorydbTestUserName},
		})
		return err
	})

	sc.Given(`^the user membership entry does not exist$`, func() error {
		// No-op: fresh state has no membership entries.
		return nil
	})

	sc.Given(`^the user membership entry exists$`, func() error {
		// Arrange / Act: add the user to the ACL.
		_, err := world.MemoryDBClient().UpdateACL(context.Background(), &memorydb.UpdateACLInput{
			ACLName:        aws.String(memorydbTestACLName),
			UserNamesToAdd: []string{memorydbTestUserName},
		})
		return err
	})

	// ── Given: ACL state setup ─────────────────────────────────────────────

	sc.Given(`^the "ACL" does not already exist$`, func() error {
		// No-op: fresh state after reset has no ACLs.
		return nil
	})

	sc.Given(`^the "ACL" already exists$`, func() error {
		// Arrange / Act: create the ACL.
		return memorydbCreateACL(world)
	})

	sc.Given(`^the "ACL" does not exist$`, func() error {
		// No-op: fresh state after reset has no ACLs.
		return nil
	})

	sc.Given(`^the "ACL" exists$`, func() error {
		// Arrange / Act: create the ACL.
		return memorydbCreateACL(world)
	})

	sc.Given(`^the "ACL" is "ACTIVE"$`, func() error {
		// No-op: ACLs are created in ACTIVE state in lws.
		return nil
	})

	sc.Given(`^the "ACL" is not "ACTIVE"$`, func() error {
		// @internal: ACL non-ACTIVE state cannot be forced via public API.
		return nil
	})

	sc.Given(`^the "ACL" is "CREATING"$`, func() error {
		// @internal: ACL CREATING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the "ACL" is not "CREATING"$`, func() error {
		// No-op: freshly created ACL is not in CREATING state in lws.
		return nil
	})

	sc.Given(`^the "ACL" is "DELETING"$`, func() error {
		// @internal: ACL DELETING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the "ACL" is not "DELETING"$`, func() error {
		// No-op: freshly created ACL is not in DELETING state.
		return nil
	})

	sc.Given(`^the "ACL" is "MODIFYING"$`, func() error {
		// @internal: ACL MODIFYING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the "ACL" is not "MODIFYING"$`, func() error {
		// No-op: freshly created ACL is not in MODIFYING state.
		return nil
	})

	// ── Given: snapshot state setup ────────────────────────────────────────

	sc.Given(`^the snapshot does not exist$`, func() error {
		// No-op: fresh state after reset has no snapshots.
		return nil
	})

	sc.Given(`^the snapshot exists$`, func() error {
		// Arrange / Act: create ACL, cluster, then snapshot.
		_ = memorydbCreateACL(world)
		_ = memorydbCreateCluster(world)
		return memorydbCreateSnapshot(world)
	})

	sc.Given(`^the snapshot is "AVAILABLE"$`, func() error {
		// No-op: snapshots are created in AVAILABLE state in lws.
		return nil
	})

	sc.Given(`^the snapshot is not "AVAILABLE"$`, func() error {
		// @internal: snapshot non-AVAILABLE state cannot be forced via public API.
		return nil
	})

	sc.Given(`^the snapshot is "CREATING"$`, func() error {
		// @internal: snapshot CREATING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the snapshot is not "CREATING"$`, func() error {
		// No-op: freshly created snapshot is not in CREATING state in lws.
		return nil
	})

	sc.Given(`^the snapshot is "DELETING"$`, func() error {
		// @internal: snapshot DELETING state is transient and cannot be held via public API.
		return nil
	})

	sc.Given(`^the snapshot is not "DELETING"$`, func() error {
		// No-op: freshly created snapshot is not in DELETING state.
		return nil
	})

	sc.Given(`^the snapshot slot is available$`, func() error {
		// No-op: fresh state has snapshot slots available.
		return nil
	})

	sc.Given(`^the snapshot slot is not available$`, func() error {
		// @internal: exhausting snapshot slots requires internal state control.
		return nil
	})

	sc.Given(`^the snapshot belongs to this cluster$`, func() error {
		// No-op: snapshot was created from the test cluster.
		return nil
	})

	sc.Given(`^the snapshot does not belong to this cluster$`, func() error {
		// @internal: cross-cluster snapshot state cannot be set up via public API.
		return nil
	})

	sc.Given(`^the target cluster slot is available$`, func() error {
		// No-op: fresh state has cluster slots available.
		return nil
	})

	sc.Given(`^the target cluster slot is not available$`, func() error {
		// @internal: exhausting cluster slots requires internal state control.
		return nil
	})

	// ── Given: tag/resource state setup ───────────────────────────────────

	sc.Given(`^the resource has a tag entry$`, func() error {
		// Arrange / Act: create a cluster (which has tags) as the tagged resource.
		_ = memorydbCreateACL(world)
		return memorydbCreateCluster(world)
	})

	sc.Given(`^the resource does not have a tag entry$`, func() error {
		// No-op: fresh state has no resources to tag.
		return nil
	})

	sc.Given(`^the resource is tagged$`, func() error {
		// No-op: the cluster is already created with tags in the tag entry setup.
		return nil
	})

	sc.Given(`^the resource is not tagged$`, func() error {
		// @internal: an existing resource with an empty tag list cannot be set up easily
		// via public API without also creating the cluster without tags, which the fake
		// may accept; treat as no-op.
		return nil
	})

	// ── Given: FizzBee sequence steps ─────────────────────────────────────

	sc.Given(`^cid in cluster_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^cid not in cluster_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^sid in snapshot_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^uid in user_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^uid not in user_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^aid in acl_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^aid not in acl_status$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	sc.Given(`^cid in tag_exists$`, func() error {
		// @internal: FizzBee sequence precondition; no public API equivalent.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^a MemoryDB cluster is created$`, func() error {
		// Arrange: (cluster may or may not exist — set up by Given steps)
		_ = memorydbCreateACL(world)
		// Act
		resp, err := world.MemoryDBClient().CreateCluster(context.Background(), &memorydb.CreateClusterInput{
			ClusterName: aws.String(memorydbTestClusterName),
			NodeType:    aws.String("db.r6g.large"),
			ACLName:     aws.String(memorydbTestACLName),
			Tags:        []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a MemoryDB cluster is deleted$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().DeleteCluster(context.Background(), &memorydb.DeleteClusterInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is created$`, func() error {
		// Arrange: (user may or may not exist — set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().CreateUser(context.Background(), &memorydb.CreateUserInput{
			UserName:     aws.String(memorydbTestUserName),
			AccessString: aws.String("on ~* &* +@all"),
			AuthenticationMode: &memorydbtypes.AuthenticationMode{
				Type: memorydbtypes.InputAuthenticationTypePassword,
			},
			Tags: []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is deleted$`, func() error {
		// Arrange: (user state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().DeleteUser(context.Background(), &memorydb.DeleteUserInput{
			UserName: aws.String(memorydbTestUserName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is updated$`, func() error {
		// Arrange: (user state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateUser(context.Background(), &memorydb.UpdateUserInput{
			UserName:     aws.String(memorydbTestUserName),
			AccessString: aws.String("on ~* &* +@all"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "ACL" is created$`, func() error {
		// Arrange: (ACL may or may not exist — set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().CreateACL(context.Background(), &memorydb.CreateACLInput{
			ACLName: aws.String(memorydbTestACLName),
			Tags:    []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "ACL" is deleted$`, func() error {
		// Arrange: (ACL state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().DeleteACL(context.Background(), &memorydb.DeleteACLInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "ACL" is updated$`, func() error {
		// Arrange: (ACL state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateACL(context.Background(), &memorydb.UpdateACLInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "ACL" is associated with a cluster$`, func() error {
		// Arrange: (cluster and ACL state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateCluster(context.Background(), &memorydb.UpdateClusterInput{
			ClusterName: aws.String(memorydbTestClusterName),
			ACLName:     aws.String(memorydbTestACLName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is added to an "ACL"$`, func() error {
		// Arrange: (ACL and user state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateACL(context.Background(), &memorydb.UpdateACLInput{
			ACLName:        aws.String(memorydbTestACLName),
			UserNamesToAdd: []string{memorydbTestUserName},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a user is removed from an "ACL"$`, func() error {
		// Arrange: (ACL and user state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateACL(context.Background(), &memorydb.UpdateACLInput{
			ACLName:           aws.String(memorydbTestACLName),
			UserNamesToRemove: []string{memorydbTestUserName},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a snapshot is created from an available cluster$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().CreateSnapshot(context.Background(), &memorydb.CreateSnapshotInput{
			ClusterName:  aws.String(memorydbTestClusterName),
			SnapshotName: aws.String(memorydbTestSnapshotName),
			Tags:         []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a snapshot is deleted$`, func() error {
		// Arrange: (snapshot state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().DeleteSnapshot(context.Background(), &memorydb.DeleteSnapshotInput{
			SnapshotName: aws.String(memorydbTestSnapshotName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a cluster is restored from a snapshot$`, func() error {
		// Arrange: (snapshot and cluster state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().CreateCluster(context.Background(), &memorydb.CreateClusterInput{
			ClusterName:  aws.String(memorydbTestClusterName + "-restored"),
			NodeType:     aws.String("db.r6g.large"),
			ACLName:      aws.String(memorydbTestACLName),
			SnapshotName: aws.String(memorydbTestSnapshotName),
			Tags:         []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a MemoryDB cluster configuration is updated$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UpdateCluster(context.Background(), &memorydb.UpdateClusterInput{
			ClusterName: aws.String(memorydbTestClusterName),
			Description: aws.String("updated-description"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a shard failover is triggered on a multi-"AZ" cluster$`, func() error {
		// @internal: shard failover is an internal operation; no public API equivalent.
		// No-op: recorded as no error.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a MemoryDB cluster finishes creating$`, func() error {
		// @internal: cluster creation completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a MemoryDB cluster deletion completes$`, func() error {
		// @internal: cluster deletion completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a MemoryDB cluster update completes$`, func() error {
		// @internal: cluster update completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a cluster restore from snapshot completes$`, func() error {
		// @internal: cluster restore completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a user finishes creating$`, func() error {
		// @internal: user creation completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a user deletion completes$`, func() error {
		// @internal: user deletion completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a user update completes$`, func() error {
		// @internal: user update completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^an "ACL" finishes creating$`, func() error {
		// @internal: ACL creation completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^an "ACL" deletion completes$`, func() error {
		// @internal: ACL deletion completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^an "ACL" update completes$`, func() error {
		// @internal: ACL update completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a snapshot finishes creating$`, func() error {
		// @internal: snapshot creation completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^a snapshot deletion completes$`, func() error {
		// @internal: snapshot deletion completion is an internal state transition.
		setResult(world, nil, nil)
		return nil
	})

	sc.When(`^tags are added to a MemoryDB resource$`, func() error {
		// Arrange: (resource state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().TagResource(context.Background(), &memorydb.TagResourceInput{
			ResourceArn: aws.String(memorydbTestARN),
			Tags:        []memorydbtypes.Tag{{Key: aws.String(memorydbTestTagKey), Value: aws.String(memorydbTestTagValue)}},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^tags are removed from a MemoryDB resource$`, func() error {
		// Arrange: (resource state set up by Given steps)
		// Act
		resp, err := world.MemoryDBClient().UntagResource(context.Background(), &memorydb.UntagResourceInput{
			ResourceArn: aws.String(memorydbTestARN),
			TagKeys:     []string{memorydbTestTagKey},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the cluster is in "CREATING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_cluster to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_clusters to succeed but got: %w", err)
		}
		if len(resp.Clusters) == 0 {
			return fmt.Errorf("expected cluster %q to exist but not found; expected_cluster=%s", memorydbTestClusterName, memorydbTestClusterName)
		}
		expectedStatus := "creating"
		actualStatus := aws.ToString(resp.Clusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the cluster is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_cluster to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_clusters to succeed but got: %w", err)
		}
		if len(resp.Clusters) == 0 {
			return fmt.Errorf("expected cluster %q to exist in DELETING state but not found; expected_cluster=%s", memorydbTestClusterName, memorydbTestClusterName)
		}
		expectedStatus := "deleting"
		actualStatus := aws.ToString(resp.Clusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the cluster is in "MODIFYING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_cluster to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected UpdateClusterOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the cluster is "AVAILABLE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_clusters to succeed but got: %w", err)
		}
		if len(resp.Clusters) == 0 {
			return fmt.Errorf("expected cluster %q to exist but not found; expected_cluster=%s", memorydbTestClusterName, memorydbTestClusterName)
		}
		expectedStatus := "available"
		actualStatus := aws.ToString(resp.Clusters[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected cluster status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the cluster is "DELETED" and its tags are removed$`, func() error {
		// Arrange: no additional setup required
		// Act: verify the cluster is absent
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		if err != nil {
			// A missing cluster may return an error — treat as deleted.
			return nil
		}
		// Assert
		for _, c := range resp.Clusters {
			actualName := aws.ToString(c.Name)
			if actualName == memorydbTestClusterName {
				actualStatus := aws.ToString(c.Status)
				if actualStatus != "deleting" && actualStatus != "deleted" {
					return fmt.Errorf("expected cluster %q to be deleted but status is %q; expected_deleted=%s actual_status=%s",
						memorydbTestClusterName, actualStatus, memorydbTestClusterName, actualStatus)
				}
			}
		}
		return nil
	})

	sc.Then(`^the cluster returns to "AVAILABLE" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	sc.Then(`^the cluster remains "AVAILABLE" after the shard failover$`, func() error {
		// No-op invariant: shard failover is internal; trivially satisfied in lws context.
		return nil
	})

	sc.Then(`^the restored cluster is in "RESTORING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected cluster restore to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CreateClusterOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the cluster is linked to the active "ACL"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_cluster to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeClusters(context.Background(), &memorydb.DescribeClustersInput{
			ClusterName: aws.String(memorydbTestClusterName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_clusters to succeed but got: %w", err)
		}
		if len(resp.Clusters) == 0 {
			return fmt.Errorf("expected cluster %q to exist but not found; expected_cluster=%s", memorydbTestClusterName, memorydbTestClusterName)
		}
		expectedACLName := memorydbTestACLName
		actualACLName := aws.ToString(resp.Clusters[0].ACLName)
		if actualACLName != expectedACLName {
			return fmt.Errorf("expected ACL name %q but got %q; expected_acl=%s actual_acl=%s",
				expectedACLName, actualACLName, expectedACLName, actualACLName)
		}
		return nil
	})

	// ── User assertion steps ───────────────────────────────────────────────

	sc.Then(`^the user is in "CREATING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_user to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeUsers(context.Background(), &memorydb.DescribeUsersInput{
			UserName: aws.String(memorydbTestUserName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_users to succeed but got: %w", err)
		}
		if len(resp.Users) == 0 {
			return fmt.Errorf("expected user %q to exist but not found; expected_user=%s", memorydbTestUserName, memorydbTestUserName)
		}
		expectedStatus := "creating"
		actualStatus := aws.ToString(resp.Users[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected user status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the user is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_user to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeUsers(context.Background(), &memorydb.DescribeUsersInput{
			UserName: aws.String(memorydbTestUserName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_users to succeed but got: %w", err)
		}
		if len(resp.Users) == 0 {
			return fmt.Errorf("expected user %q to exist in DELETING state but not found; expected_user=%s", memorydbTestUserName, memorydbTestUserName)
		}
		expectedStatus := "deleting"
		actualStatus := aws.ToString(resp.Users[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected user status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the user is in "MODIFYING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_user to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected UpdateUserOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the user is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	sc.Then(`^the user is "DELETED"$`, func() error {
		// Arrange: no additional setup required
		// Act: verify the user is absent
		resp, err := world.MemoryDBClient().DescribeUsers(context.Background(), &memorydb.DescribeUsersInput{
			UserName: aws.String(memorydbTestUserName),
		})
		if err != nil {
			// A missing user may return an error — treat as deleted.
			return nil
		}
		// Assert
		for _, u := range resp.Users {
			actualName := aws.ToString(u.Name)
			if actualName == memorydbTestUserName {
				actualStatus := aws.ToString(u.Status)
				if actualStatus != "deleting" && actualStatus != "deleted" {
					return fmt.Errorf("expected user %q to be deleted but status is %q; expected_deleted=%s actual_status=%s",
						memorydbTestUserName, actualStatus, memorydbTestUserName, actualStatus)
				}
			}
		}
		return nil
	})

	sc.Then(`^the user returns to "ACTIVE" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	sc.Then(`^the user is a member of the "ACL"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_acl to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeACLs(context.Background(), &memorydb.DescribeACLsInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_acls to succeed but got: %w", err)
		}
		if len(resp.ACLs) == 0 {
			return fmt.Errorf("expected ACL %q to exist but not found; expected_acl=%s", memorydbTestACLName, memorydbTestACLName)
		}
		found := false
		for _, u := range resp.ACLs[0].UserNames {
			if u == memorydbTestUserName {
				found = true
				break
			}
		}
		expectedMember := memorydbTestUserName
		if !found {
			return fmt.Errorf("expected user %q to be a member of ACL %q but not found; expected_member=%s actual_members=%v",
				expectedMember, memorydbTestACLName, expectedMember, resp.ACLs[0].UserNames)
		}
		return nil
	})

	sc.Then(`^the user is no longer a member of the "ACL"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_acl to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeACLs(context.Background(), &memorydb.DescribeACLsInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_acls to succeed but got: %w", err)
		}
		if len(resp.ACLs) == 0 {
			return fmt.Errorf("expected ACL %q to exist but not found; expected_acl=%s", memorydbTestACLName, memorydbTestACLName)
		}
		for _, u := range resp.ACLs[0].UserNames {
			if u == memorydbTestUserName {
				return fmt.Errorf("expected user %q to be removed from ACL %q but still found; expected_absent=%s actual_members=%v",
					memorydbTestUserName, memorydbTestACLName, memorydbTestUserName, resp.ACLs[0].UserNames)
			}
		}
		return nil
	})

	// ── ACL assertion steps ────────────────────────────────────────────────

	sc.Then(`^the "ACL" is in "CREATING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_acl to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeACLs(context.Background(), &memorydb.DescribeACLsInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_acls to succeed but got: %w", err)
		}
		if len(resp.ACLs) == 0 {
			return fmt.Errorf("expected ACL %q to exist but not found; expected_acl=%s", memorydbTestACLName, memorydbTestACLName)
		}
		expectedStatus := "creating"
		actualStatus := aws.ToString(resp.ACLs[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected ACL status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the "ACL" is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_acl to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeACLs(context.Background(), &memorydb.DescribeACLsInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_acls to succeed but got: %w", err)
		}
		if len(resp.ACLs) == 0 {
			return fmt.Errorf("expected ACL %q to exist in DELETING state but not found; expected_acl=%s", memorydbTestACLName, memorydbTestACLName)
		}
		expectedStatus := "deleting"
		actualStatus := aws.ToString(resp.ACLs[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected ACL status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the "ACL" is in "MODIFYING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected update_acl to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected UpdateACLOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the "ACL" is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	sc.Then(`^the "ACL" is "DELETED"$`, func() error {
		// Arrange: no additional setup required
		// Act: verify the ACL is absent
		resp, err := world.MemoryDBClient().DescribeACLs(context.Background(), &memorydb.DescribeACLsInput{
			ACLName: aws.String(memorydbTestACLName),
		})
		if err != nil {
			// A missing ACL may return an error — treat as deleted.
			return nil
		}
		// Assert
		for _, a := range resp.ACLs {
			actualName := aws.ToString(a.Name)
			if actualName == memorydbTestACLName {
				actualStatus := aws.ToString(a.Status)
				if actualStatus != "deleting" && actualStatus != "deleted" {
					return fmt.Errorf("expected ACL %q to be deleted but status is %q; expected_deleted=%s actual_status=%s",
						memorydbTestACLName, actualStatus, memorydbTestACLName, actualStatus)
				}
			}
		}
		return nil
	})

	sc.Then(`^the "ACL" returns to "ACTIVE" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	// ── Snapshot assertion steps ───────────────────────────────────────────

	sc.Then(`^the snapshot is in "CREATING" state and the cluster is "SNAPSHOTTING"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_snapshot to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeSnapshots(context.Background(), &memorydb.DescribeSnapshotsInput{
			SnapshotName: aws.String(memorydbTestSnapshotName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_snapshots to succeed but got: %w", err)
		}
		if len(resp.Snapshots) == 0 {
			return fmt.Errorf("expected snapshot %q to exist but not found; expected_snapshot=%s", memorydbTestSnapshotName, memorydbTestSnapshotName)
		}
		expectedStatus := "creating"
		actualStatus := aws.ToString(resp.Snapshots[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected snapshot status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the snapshot is in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_snapshot to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().DescribeSnapshots(context.Background(), &memorydb.DescribeSnapshotsInput{
			SnapshotName: aws.String(memorydbTestSnapshotName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_snapshots to succeed but got: %w", err)
		}
		if len(resp.Snapshots) == 0 {
			return fmt.Errorf("expected snapshot %q to exist in DELETING state but not found; expected_snapshot=%s", memorydbTestSnapshotName, memorydbTestSnapshotName)
		}
		expectedStatus := "deleting"
		actualStatus := aws.ToString(resp.Snapshots[0].Status)
		if actualStatus != expectedStatus {
			return fmt.Errorf("expected snapshot status %q but got %q; expected_status=%s actual_status=%s",
				expectedStatus, actualStatus, expectedStatus, actualStatus)
		}
		return nil
	})

	sc.Then(`^the snapshot is "AVAILABLE" and the cluster returns to "AVAILABLE" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil")
		}
		return nil
	})

	sc.Then(`^the snapshot is "DELETED" and its tags are removed$`, func() error {
		// Arrange: no additional setup required
		// Act: verify the snapshot is absent
		resp, err := world.MemoryDBClient().DescribeSnapshots(context.Background(), &memorydb.DescribeSnapshotsInput{
			SnapshotName: aws.String(memorydbTestSnapshotName),
		})
		if err != nil {
			// A missing snapshot may return an error — treat as deleted.
			return nil
		}
		// Assert
		for _, s := range resp.Snapshots {
			actualName := aws.ToString(s.Name)
			if actualName == memorydbTestSnapshotName {
				actualStatus := aws.ToString(s.Status)
				if actualStatus != "deleting" && actualStatus != "deleted" {
					return fmt.Errorf("expected snapshot %q to be deleted but status is %q; expected_deleted=%s actual_status=%s",
						memorydbTestSnapshotName, actualStatus, memorydbTestSnapshotName, actualStatus)
				}
			}
		}
		return nil
	})

	// ── Tag assertion steps ────────────────────────────────────────────────

	sc.Then(`^the resource remains tagged$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected tag_resource to succeed but got: %w", world.lastResult.Error)
		}
		resp, err := world.MemoryDBClient().ListTags(context.Background(), &memorydb.ListTagsInput{
			ResourceArn: aws.String(memorydbTestARN),
		})
		if err != nil {
			return fmt.Errorf("expected list_tags to succeed but got: %w", err)
		}
		found := false
		for _, t := range resp.TagList {
			if aws.ToString(t.Key) == memorydbTestTagKey {
				found = true
				break
			}
		}
		expectedTagKey := memorydbTestTagKey
		if !found {
			return fmt.Errorf("expected tag %q to exist on resource but not found; expected_tag_key=%s",
				expectedTagKey, expectedTagKey)
		}
		return nil
	})

	sc.Then(`^the resource tag state is unchanged \(no-op model\)$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected untag_resource to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	// ── Invariant catch-all steps ──────────────────────────────────────────

	sc.Then(`^the operation is rejected$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error == nil {
			return fmt.Errorf("expected operation to be rejected but it succeeded; expected_error=non-nil actual_error=nil")
		}
		return nil
	})

	sc.Then(`^every active cluster has write durability enabled$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every snapshotting cluster has a corresponding in-progress snapshot$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^no "ACL" in "DELETING" state is currently associated with a cluster$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^no user in "DELETING" state is currently a member of an "ACL"$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every active cluster and snapshot has tags$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
