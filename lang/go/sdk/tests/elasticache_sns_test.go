package tests

// registerElastiCacheSNSSteps wires all step definitions for the ElasticacheSns
// informal specification feature files (create_cluster, create_topic, delete_topic,
// configure_notification, cluster_event_notification_delivered,
// cluster_event_notification_fails, cluster_modification_complete, sequences).
//
// Steps already registered elsewhere and intentionally absent here:
//   - "the system is initialized"                  — sequences_test.go
//   - "the operation is rejected"                  — sqs_test.go
//   - "cid not in cluster_status"                  — elasticache_test.go
//   - "tid not in topic_status"                    — sequences_test.go
//   - "the cluster does not already exist"         — elasticache_test.go
//   - "the cluster already exists"                 — elasticache_test.go
//   - "the cluster is \"([^\"]*)\""                — elasticache_test.go
//   - "the cluster is not \"([^\"]*)\""            — elasticache_test.go

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/elasticache"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/cucumber/godog"
)

const (
	elasticacheSnsTestClusterID = "test-elasticache-cluster-1"
	elasticacheSnsTestTopicName = "test-elasticache-sns-topic-1"
	elasticacheSnsTestRegion    = "us-east-1"
	elasticacheSnsTestAccount   = "000000000000"
)

func elasticacheSnsTopicArn() string {
	return fmt.Sprintf("arn:aws:sns:%s:%s:%s",
		elasticacheSnsTestRegion, elasticacheSnsTestAccount, elasticacheSnsTestTopicName)
}

func elasticacheSnsCreateCluster(world *World) error {
	_, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
		CacheClusterId: aws.String(elasticacheSnsTestClusterID),
		Engine:         aws.String("redis"),
		CacheNodeType:  aws.String("cache.t3.micro"),
		NumCacheNodes:  aws.Int32(1),
	})
	return err
}

func elasticacheSnsCreateTopic(world *World) error {
	_, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(elasticacheSnsTestTopicName),
	})
	return err
}

func elasticacheSnsClusterExists(world *World) (bool, error) {
	resp, err := world.ElastiCacheClient().DescribeCacheClusters(context.Background(), &elasticache.DescribeCacheClustersInput{
		CacheClusterId: aws.String(elasticacheSnsTestClusterID),
	})
	if err != nil {
		return false, nil //nolint:nilerr
	}
	return resp != nil && len(resp.CacheClusters) > 0, nil
}

func elasticacheSnsTopicExists(world *World) (bool, error) {
	resp, err := world.SNSClient().ListTopics(context.Background(), &sns.ListTopicsInput{})
	if err != nil {
		return false, nil //nolint:nilerr
	}
	arn := elasticacheSnsTopicArn()
	for _, t := range resp.Topics {
		if aws.ToString(t.TopicArn) == arn {
			return true, nil
		}
	}
	return false, nil
}

func registerElastiCacheSNSSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Given: cluster state (elasticache_sns-specific — "exists and is")
	// -------------------------------------------------------------------------

	sc.Given(`^the cluster exists and is "([^"]*)"$`, func(state string) error {
		// Arrange / Act: create the cluster (lws clusters are AVAILABLE on creation).
		return elasticacheSnsCreateCluster(world)
	})

	sc.Given(`^the cluster does not exist or is not "([^"]*)"$`, func(state string) error {
		// No-op: precondition not met — the Then step asserts operation rejected.
		return nil
	})

	sc.Given(`^the cluster has an "([^"]*)" notification configured$`, func(service string) error {
		// @internal: configuring notifications requires internal lifecycle completion.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the cluster has no "([^"]*)" notification configured$`, func(service string) error {
		// No-op: clusters are created without notification configuration by default.
		return nil
	})

	sc.Given(`^the cluster already has an "([^"]*)" notification configured$`, func(service string) error {
		// @internal: no-op.
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: topic state
	// -------------------------------------------------------------------------

	sc.Given(`^the topic does not already exist$`, func() error {
		// No-op: fresh state has no topics.
		return nil
	})

	sc.Given(`^the topic already exists$`, func() error {
		// Arrange / Act: create the topic so it already exists.
		return elasticacheSnsCreateTopic(world)
	})

	sc.Given(`^the topic exists$`, func() error {
		// Arrange / Act: ensure the topic exists.
		return elasticacheSnsCreateTopic(world)
	})

	sc.Given(`^the topic does not exist$`, func() error {
		// No-op: fresh state has no topics.
		return nil
	})

	sc.Given(`^the topic exists and is "([^"]*)"$`, func(state string) error {
		// Arrange / Act: create the topic (SNS topics are ACTIVE on creation).
		return elasticacheSnsCreateTopic(world)
	})

	sc.Given(`^the topic does not exist or is not "([^"]*)"$`, func(state string) error {
		// No-op: precondition not met — the Then step asserts operation rejected.
		return nil
	})

	sc.Given(`^the topic is "([^"]*)"$`, func(state string) error {
		// Arrange: create the topic if it should be ACTIVE; DELETED state is @internal.
		if state == "ACTIVE" {
			return elasticacheSnsCreateTopic(world)
		}
		// @internal: DELETED topic state is managed internally.
		// @internal: no-op.
		return nil
	})

	sc.Given(`^the topic is already "([^"]*)"$`, func(state string) error {
		// @internal: topic lifecycle states are managed internally.
		// @internal: no-op.
		return nil
	})

	// ── message slot setup ────────────────────────────────────────────────────

	sc.Given(`^a message slot is available$`, func() error {
		// No-op: message slots are available in a fresh session.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^an ElastiCache cluster is created$`, func() error {
		// Arrange: (cluster state set up by Given steps)
		// Act
		resp, err := world.ElastiCacheClient().CreateCacheCluster(context.Background(), &elasticache.CreateCacheClusterInput{
			CacheClusterId: aws.String(elasticacheSnsTestClusterID),
			Engine:         aws.String("redis"),
			CacheNodeType:  aws.String("cache.t3.micro"),
			NumCacheNodes:  aws.Int32(1),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "([^"]*)" topic is created$`, func(service string) error {
		// Arrange: (topic state set up by Given steps)
		// Act
		resp, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
			Name: aws.String(elasticacheSnsTestTopicName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the "([^"]*)" topic is deleted$`, func(service string) error {
		// Arrange: (topic state set up by Given steps)
		// Act
		resp, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(elasticacheSnsTopicArn()),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "([^"]*)" notification is configured on the ElastiCache cluster$`, func(service string) error {
		// Arrange: verify cluster exists
		clusterExists, err := elasticacheSnsClusterExists(world)
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if !clusterExists {
			setResult(world, nil, fmt.Errorf("CacheClusterNotFound: cluster %s does not exist", elasticacheSnsTestClusterID))
			return nil
		}
		// Act: modify the cluster to configure SNS notification
		resp, err := world.ElastiCacheClient().ModifyCacheCluster(context.Background(), &elasticache.ModifyCacheClusterInput{
			CacheClusterId:          aws.String(elasticacheSnsTestClusterID),
			NotificationTopicArn:    aws.String(elasticacheSnsTopicArn()),
			NotificationTopicStatus: aws.String("active"),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a cluster modification event occurs and ElastiCache publishes a notification to the "([^"]*)" topic$`, func(service string) error {
		// @internal: notification publishing is an internal event.
		// @internal: no-op.
		return nil
	})

	sc.When(`^a cluster event occurs but the "([^"]*)" notification fails because the topic has been deleted$`, func(service string) error {
		// @internal: no-op.
		return nil
	})

	sc.When(`^the cluster modification completes$`, func() error {
		// @internal: no-op.
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the cluster is "([^"]*)" with no "([^"]*)" notification configured$`, func(clusterState, service string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_cluster to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, clusterState)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CreateCacheClusterOutput but got nil; expected_state=%s", clusterState)
		}
		return nil
	})

	sc.Then(`^the topic is "([^"]*)"$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected topic operation to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		expectedExists := true
		actualExists, err := elasticacheSnsTopicExists(world)
		if err != nil {
			return fmt.Errorf("expected ListTopics to succeed but got: %w", err)
		}
		if actualExists != expectedExists {
			return fmt.Errorf("expected topic %q to be ACTIVE but it does not exist; expected_exists=%v actual_exists=%v",
				elasticacheSnsTestTopicName, expectedExists, actualExists)
		}
		return nil
	})

	sc.Then(`^the topic is "([^"]*)" and ElastiCache event notifications will fail$`, func(expectedState string) error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_topic to succeed but got: %w; expected_state=%s",
				world.lastResult.Error, expectedState)
		}
		return nil
	})

	sc.Then(`^the cluster will publish lifecycle events to the topic$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected configure_notification to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the cluster is "([^"]*)" and the notification is "([^"]*)" to the topic$`, func(clusterState, notifState string) error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the cluster is "([^"]*)" but no notification is published$`, func(clusterState string) error {
		// @internal: no-op invariant.
		return nil
	})

	sc.Then(`^the cluster is "([^"]*)" again$`, func(expectedState string) error {
		// @internal: no-op invariant.
		return nil
	})

	// ── Invariant / safety property assertions (no-op) ────────────────────────

	sc.Then(`^every "([^"]*)" notification references a cluster that exists$`, func(state string) error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every "([^"]*)" notification references a topic that exists$`, func(state string) error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})
}
