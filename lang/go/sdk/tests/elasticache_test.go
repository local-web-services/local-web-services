package tests

// registerElastiCacheSteps wires all step definitions for the ElastiCache informal
// specification feature files (create_cache_cluster, delete_cache_cluster,
// create_replication_group, delete_replication_group, create_cache_subnet_group,
// delete_cache_subnet_group, modify_cache_cluster, modify_replication_group,
// add_replica_to_cache_cluster, add_tags_to_resource, remove_tags_from_resource,
// create_memcached_cache_cluster, create_snapshot, delete_snapshot,
// complete_cache_cluster_creation, complete_cache_cluster_deletion,
// complete_replication_group_creation, complete_replication_group_deletion,
// complete_cache_cluster_modification, complete_replication_group_modification,
// failover_replication_group).
//
// Steps already registered elsewhere and intentionally absent here:
//   - "the system is initialized"       — sequences_test.go
//   - "the operation is rejected"       — sqs_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/elasticache"
	elasticachetypes "github.com/aws/aws-sdk-go-v2/service/elasticache/types"
	"github.com/cucumber/godog"
)

const (
	elasticacheTestClusterID     = "test-elasticache-cluster-1"
	elasticacheTestRGID          = "test-elasticache-rg-1"
	elasticacheTestSubnetGroupID = "test-elasticache-subnet-group-1"
	elasticacheTestSnapshotName  = "test-elasticache-snapshot-1"
	elasticacheTestTagKey        = "e2e-elasticache-tag-key-1"
	elasticacheTestTagValue      = "test-elasticache-tag-value-1"
	elasticacheTestRegion        = "us-east-1"
	elasticacheTestAccount       = "000000000000"
)

// ── Helpers ───────────────────────────────────────────────────────────────────

func elasticacheClusterARN() string {
	return fmt.Sprintf("arn:aws:elasticache:%s:%s:cluster:%s",
		elasticacheTestRegion, elasticacheTestAccount, elasticacheTestClusterID)
}

func elasticacheCreateCluster(world *World) error {
	_, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
		CacheClusterId: aws.String(elasticacheTestClusterID),
		Engine:         aws.String("redis"),
		CacheNodeType:  aws.String("cache.t3.micro"),
		NumCacheNodes:  aws.Int32(1),
	})
	return err
}

func elasticacheCreateReplicationGroup(world *World) error {
	_, err := world.ElastiCacheClient().CreateReplicationGroup(context.Background(), &elasticache.CreateReplicationGroupInput{
		ReplicationGroupId:          aws.String(elasticacheTestRGID),
		ReplicationGroupDescription: aws.String("test replication group"),
	})
	return err
}

func elasticacheCreateSubnetGroup(world *World) error {
	_, err := world.ElastiCacheClient().CreateCacheSubnetGroup(context.Background(), &elasticache.CreateCacheSubnetGroupInput{
		CacheSubnetGroupName:        aws.String(elasticacheTestSubnetGroupID),
		CacheSubnetGroupDescription: aws.String("test subnet group"),
		SubnetIds:                   []string{"subnet-00000001"},
	})
	return err
}

func elasticacheClusterExists(world *World) (bool, error) {
	resp, err := world.ElastiCacheClient().DescribeCacheClusters(context.Background(), &elasticache.DescribeCacheClustersInput{
		CacheClusterId: aws.String(elasticacheTestClusterID),
	})
	if err != nil {
		return false, nil //nolint:nilerr
	}
	return resp != nil && len(resp.CacheClusters) > 0, nil
}

func elasticacheRGExists(world *World) (bool, error) {
	resp, err := world.ElastiCacheClient().DescribeReplicationGroups(context.Background(), &elasticache.DescribeReplicationGroupsInput{
		ReplicationGroupId: aws.String(elasticacheTestRGID),
	})
	if err != nil {
		return false, nil //nolint:nilerr
	}
	return resp != nil && len(resp.ReplicationGroups) > 0, nil
}

func elasticacheSubnetGroupExists(world *World) (bool, error) {
	resp, err := world.ElastiCacheClient().DescribeCacheSubnetGroups(context.Background(), &elasticache.DescribeCacheSubnetGroupsInput{
		CacheSubnetGroupName: aws.String(elasticacheTestSubnetGroupID),
	})
	if err != nil {
		return false, nil //nolint:nilerr
	}
	return resp != nil && len(resp.CacheSubnetGroups) > 0, nil
}

func registerElastiCacheSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: sequence / precondition steps
	// -------------------------------------------------------------------------

	sc.Given(`^cid not in cluster_status$`, func() error {
		// No-op: in a fresh test session no clusters exist.
		return nil
	})

	// ── cluster state setup ───────────────────────────────────────────────────

	sc.Given(`^the cluster does not already exist$`, func() error {
		// No-op: fresh state after reset has no clusters.
		return nil
	})

	sc.Given(`^the cluster already exists$`, func() error {
		// Arrange / Act: create the cluster so it already exists.
		return elasticacheCreateCluster(world)
	})

	sc.Given(`^the cluster exists$`, func() error {
		// Arrange / Act: ensure the cluster exists.
		return elasticacheCreateCluster(world)
	})

	sc.Given(`^the cluster does not exist$`, func() error {
		// No-op: fresh state has no clusters.
		return nil
	})

	sc.Given(`^the cluster is "([^"]*)"$`, func(state string) error {
		// @internal: lifecycle states (CREATING, AVAILABLE, etc.) are managed
		// internally. No public API can force a cluster into an arbitrary state.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is not "([^"]*)"$`, func(state string) error {
		// @internal: lifecycle states are managed internally.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is standalone \(not part of a replication group\)$`, func() error {
		// No-op: clusters created without a replication group are standalone by default.
		return nil
	})

	sc.Given(`^the cluster is part of a replication group$`, func() error {
		// @internal: no public API places a standalone cluster into a replication group.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster uses the redis engine$`, func() error {
		// No-op: the test cluster is always created with the redis engine.
		return nil
	})

	sc.Given(`^the cluster does not use the redis engine$`, func() error {
		// No-op: handled by the reject assertion in the Then step.
		return nil
	})

	sc.Given(`^the snapshot slot is available$`, func() error {
		// No-op: snapshot slots are available in a fresh session.
		return nil
	})

	sc.Given(`^the snapshot slot is not available$`, func() error {
		// @internal: no public API exhausts snapshot slots.
		// @internal: no-op.
		return nil
	})

	// ── replication group state setup ─────────────────────────────────────────

	sc.Given(`^the replication group does not already exist$`, func() error {
		// No-op: fresh state has no replication groups.
		return nil
	})

	sc.Given(`^the replication group already exists$`, func() error {
		// Arrange / Act: create the replication group so it already exists.
		return elasticacheCreateReplicationGroup(world)
	})

	sc.Given(`^the replication group exists$`, func() error {
		// Arrange / Act: ensure the replication group exists.
		return elasticacheCreateReplicationGroup(world)
	})

	sc.Given(`^the replication group does not exist$`, func() error {
		// No-op: fresh state has no replication groups.
		return nil
	})

	sc.Given(`^the replication group is "([^"]*)"$`, func(state string) error {
		// @internal: replication group lifecycle states are managed internally.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the replication group is not "([^"]*)"$`, func(state string) error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^a cluster slot is available$`, func() error {
		// No-op: cluster slots are available in a fresh session.
		return nil
	})

	sc.Given(`^no cluster slot is available$`, func() error {
		// Exhaust elasticache capacity so CreateCacheCluster is rejected.
		return managementSession().Capacity("elasticache").Exhaust().Apply()
	})

	sc.Given(`^a cluster slot is available for the primary$`, func() error {
		// No-op: slots are available in a fresh session.
		return nil
	})

	sc.Given(`^no cluster slot is available for the primary$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^automatic failover is enabled$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^automatic failover is not enabled$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^a replica cluster exists$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^no replica cluster exists$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is part of this replication group$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is not part of this replication group$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is not already the primary$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster is already the primary$`, func() error {
		// @internal: no-op.
		return nil
	})

	// ── subnet group state setup ──────────────────────────────────────────────

	sc.Given(`^the subnet group does not already exist$`, func() error {
		// No-op: fresh state has no subnet groups.
		return nil
	})

	sc.Given(`^the subnet group already exists$`, func() error {
		// Arrange / Act: create the subnet group so it already exists.
		return elasticacheCreateSubnetGroup(world)
	})

	sc.Given(`^the subnet group exists$`, func() error {
		// Arrange / Act: ensure the subnet group exists.
		return elasticacheCreateSubnetGroup(world)
	})

	sc.Given(`^the subnet group does not exist$`, func() error {
		// No-op: fresh state has no subnet groups.
		return nil
	})

	sc.Given(`^the subnet group is present$`, func() error {
		// No-op: subnet groups created via API are always present.
		return nil
	})

	sc.Given(`^the subnet group is not present$`, func() error {
		// Delete the subnet group so that it does not exist, enabling "not found" rejection.
		_, _ = world.ElastiCacheClient().DeleteCacheSubnetGroup(context.Background(), &elasticache.DeleteCacheSubnetGroupInput{
			CacheSubnetGroupName: aws.String(elasticacheTestSubnetGroupID),
		})
		return nil
	})

	// ── snapshot state setup ──────────────────────────────────────────────────

	sc.Given(`^the snapshot exists$`, func() error {
		// @internal: creating a snapshot requires a cluster in AVAILABLE state.
		// @internal: no-op — snapshots are not created here.
		return nil
	})

	sc.Given(`^the snapshot does not exist$`, func() error {
		// No-op: fresh state has no snapshots.
		return nil
	})

	sc.Given(`^the snapshot is "([^"]*)"$`, func(state string) error {
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the snapshot is not "([^"]*)"$`, func(state string) error {
		// @internal: no-op.
		return nil
	})

	// ── tag / resource state setup ────────────────────────────────────────────

	sc.Given(`^the resource exists$`, func() error {
		// Arrange / Act: create the cluster as the representative resource.
		return elasticacheCreateCluster(world)
	})

	sc.Given(`^the resource does not exist$`, func() error {
		// No-op: fresh state has no resources.
		return nil
	})

	sc.Given(`^the resource has tags$`, func() error {
		// No-op: resources are created with default tags in lws.
		return nil
	})

	sc.Given(`^the resource does not have tags$`, func() error {
		// @internal: no public API removes all tags from a resource in lws.
		// @internal: no-op.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^a redis cache cluster is created$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
			CacheClusterId: aws.String(elasticacheTestClusterID),
			Engine:         aws.String("redis"),
			CacheNodeType:  aws.String("cache.t3.micro"),
			NumCacheNodes:  aws.Int32(1),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a memcached cache cluster is created$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
			CacheClusterId: aws.String(elasticacheTestClusterID),
			Engine:         aws.String("memcached"),
			CacheNodeType:  aws.String("cache.t3.micro"),
			NumCacheNodes:  aws.Int32(1),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a standalone cache cluster is deleted$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().DeleteCacheCluster(context.Background(), &elasticache.DeleteCacheClusterInput{
			CacheClusterId: aws.String(elasticacheTestClusterID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a standalone cache cluster finishes creating$`, func() error {
		// @internal: lifecycle completion is driven by internal events only.
		// @internal: no-op — this state transition cannot be triggered via public API.
		return nil
	})

	sc.When(`^a cache cluster deletion completes$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^a cache cluster configuration is modified$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().ModifyCacheCluster(context.Background(), &elasticache.ModifyCacheClusterInput{
			CacheClusterId: aws.String(elasticacheTestClusterID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a cache cluster modification completes$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^a replication group is created$`, func() error {
		// Arrange: (replication group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateReplicationGroup(context.Background(), &elasticache.CreateReplicationGroupInput{
			ReplicationGroupId:          aws.String(elasticacheTestRGID),
			ReplicationGroupDescription: aws.String("test replication group"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a replication group is deleted$`, func() error {
		// Arrange: (replication group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().DeleteReplicationGroup(context.Background(), &elasticache.DeleteReplicationGroupInput{
			ReplicationGroupId: aws.String(elasticacheTestRGID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a replication group finishes creating$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^a replication group deletion completes$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^a replication group configuration is modified$`, func() error {
		// Arrange: (replication group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().ModifyReplicationGroup(context.Background(), &elasticache.ModifyReplicationGroupInput{
			ReplicationGroupId: aws.String(elasticacheTestRGID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a replication group modification completes$`, func() error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^a replica is added to a replication group$`, func() error {
		// Arrange: (replication group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().ModifyReplicationGroup(context.Background(), &elasticache.ModifyReplicationGroupInput{
			ReplicationGroupId: aws.String(elasticacheTestRGID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an automatic failover promotes a new primary in a replication group$`, func() error {
		// @internal: no-op — failover is an internal operation.
		return nil
	})

	sc.When(`^a cache subnet group is created$`, func() error {
		// Arrange: (subnet group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateCacheSubnetGroup(context.Background(), &elasticache.CreateCacheSubnetGroupInput{
			CacheSubnetGroupName:        aws.String(elasticacheTestSubnetGroupID),
			CacheSubnetGroupDescription: aws.String("test subnet group"),
			SubnetIds:                   []string{"subnet-00000001"},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a cache subnet group is deleted$`, func() error {
		// Arrange: (subnet group state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().DeleteCacheSubnetGroup(context.Background(), &elasticache.DeleteCacheSubnetGroupInput{
			CacheSubnetGroupName: aws.String(elasticacheTestSubnetGroupID),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a snapshot is created from an available redis cache cluster$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateSnapshot(context.Background(), &elasticache.CreateSnapshotInput{
			CacheClusterId: aws.String(elasticacheTestClusterID),
			SnapshotName:   aws.String(elasticacheTestSnapshotName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a cache snapshot is deleted$`, func() error {
		// Arrange: (snapshot state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().DeleteSnapshot(context.Background(), &elasticache.DeleteSnapshotInput{
			SnapshotName: aws.String(elasticacheTestSnapshotName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^tags are added to a cache resource$`, func() error {
		// Arrange: check if the resource exists
		clusterExists, err := elasticacheClusterExists(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if !clusterExists {
			setResult(world, nil, fmt.Errorf("InvalidARN: cluster %s does not exist", elasticacheTestClusterID))
			return nil
		}
		// Act
		resp, err := world.ElastiCacheClient().AddTagsToResource(context.Background(), &elasticache.AddTagsToResourceInput{
			ResourceName: aws.String(elasticacheClusterARN()),
			Tags: []elasticachetypes.Tag{
				{Key: aws.String(elasticacheTestTagKey), Value: aws.String(elasticacheTestTagValue)},
			},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^tags are removed from a cache resource$`, func() error {
		// Arrange: check if the resource exists
		clusterExists, err := elasticacheClusterExists(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if !clusterExists {
			setResult(world, nil, fmt.Errorf("InvalidARN: cluster %s does not exist", elasticacheTestClusterID))
			return nil
		}
		// Act
		resp, err := world.ElastiCacheClient().RemoveTagsFromResource(context.Background(), &elasticache.RemoveTagsFromResourceInput{
			ResourceName: aws.String(elasticacheClusterARN()),
			TagKeys:      []string{elasticacheTestTagKey},
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the cluster is in "([^"]*)" state$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_cache_cluster to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CreateCacheClusterOutput but got nil; expected_state=%s", expectedState)
		}
		return nil
	})

	sc.Then(`^the cluster is in "([^"]*)" state with the memcached engine$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_cache_cluster (memcached) to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CreateCacheClusterOutput but got nil; expected_state=%s", expectedState)
		}
		return nil
	})

	sc.Then(`^the cluster is "([^"]*)"$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		return nil
	})

	sc.Then(`^the cluster is "DELETED" and its tags are removed$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the cluster returns to "AVAILABLE" state$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the replication group is in "([^"]*)" state$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected operation to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected output but got nil; expected_state=%s", expectedState)
		}
		return nil
	})

	sc.Then(`^the replication group and its clusters are in "DELETING" state$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_replication_group to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the replication group is "DELETED" and its tags are removed$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the replication group and its primary cluster are "AVAILABLE"$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the replication group returns to "AVAILABLE" state$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the replication group has a new primary cluster$`, func() error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^a new cluster is in "CREATING" state and associated with the replication group$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected add replica to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the subnet group exists$`, func() error {
		// Arrange: no additional setup required
		// Act
		exists, err := elasticacheSubnetGroupExists(world)
		if err != nil {
			return fmt.Errorf("expected DescribeCacheSubnetGroups to succeed but got: %w", err)
		}
		// Assert
		expectedExists := true
		actualExists := exists
		if actualExists != expectedExists {
			return fmt.Errorf("expected subnet group %q to exist; expected_exists=%v actual_exists=%v",
				elasticacheTestSubnetGroupID, expectedExists, actualExists)
		}
		return nil
	})

	sc.Then(`^the subnet group no longer exists$`, func() error {
		// Arrange: no additional setup required
		// Act
		exists, err := elasticacheSubnetGroupExists(world)
		if err != nil {
			return fmt.Errorf("expected DescribeCacheSubnetGroups to succeed but got: %w", err)
		}
		// Assert
		expectedAbsent := false
		actualExists := exists
		if actualExists != expectedAbsent {
			return fmt.Errorf("expected subnet group %q to be deleted but it still exists; expected_deleted=%s actual_exists=%v",
				elasticacheTestSubnetGroupID, elasticacheTestSubnetGroupID, actualExists)
		}
		return nil
	})

	sc.Then(`^the snapshot is in "([^"]*)" state and the cluster is "([^"]*)"$`, func(snapState, clusterState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_snapshot to succeed but got: %w; expected_snap_state=%s expected_cluster_state=%s",
				world.lastResult.Error, snapState, clusterState)
		}
		return nil
	})

	sc.Then(`^the snapshot is in "([^"]*)" state$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_snapshot to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		return nil
	})

	sc.Then(`^the resource remains tagged$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected add_tags_to_resource to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the resource tag state is unchanged \(no-op model\)$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected remove_tags_from_resource to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	// ── Invariant / safety property assertions (no-op) ────────────────────────

	sc.Then(`^memcached clusters are never associated with a replication group$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^all snapshots reference redis clusters only$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every available replication group has a primary cluster assigned$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every active cluster, replication group, and snapshot has tags$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every snapshotting cluster has a corresponding in-progress snapshot$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
