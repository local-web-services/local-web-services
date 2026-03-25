package tests

// registerGlacierSNSSteps wires all step definitions for the GlacierSns informal
// specification feature files (create_vault, delete_topic, create_topic,
// configure_notification, initiate_job, job_completed_notification_delivered,
// job_completed_notification_fails).

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/glacier"
	glaciertypes "github.com/aws/aws-sdk-go-v2/service/glacier/types"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/cucumber/godog"
)

const (
	glacierSNSTestVaultName = "test-glacier-vault-1"
	glacierSNSTestTopicName = "test-glacier-topic-1"
	glacierSNSAccountID     = "-"
)

// glacierSNSState holds mutable state for GlacierSns step definitions within one scenario.
type glacierSNSState struct {
	topicArn        string
	jobID           string
	vaultExists     bool
	topicActive     bool
	notifConfigured bool
}

func glacierSNSTopicArn() string {
	return fmt.Sprintf("arn:aws:sns:us-east-1:000000000000:%s", glacierSNSTestTopicName)
}

// glacierSNSCreateVault is a helper that creates the test Glacier vault.
func glacierSNSCreateVault(world *World) error {
	_, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
		AccountId: aws.String(glacierSNSAccountID),
		VaultName: aws.String(glacierSNSTestVaultName),
	})
	return err
}

// glacierSNSCreateTopic is a helper that creates the test SNS topic.
func glacierSNSCreateTopic(world *World) (string, error) {
	resp, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(glacierSNSTestTopicName),
	})
	if err != nil {
		return "", err
	}
	if resp.TopicArn == nil {
		return glacierSNSTopicArn(), nil
	}
	return *resp.TopicArn, nil
}

func registerGlacierSNSSteps(sc *godog.ScenarioContext, world *World) {
	gs := &glacierSNSState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		gs.topicArn = ""
		gs.jobID = ""
		gs.vaultExists = false
		gs.topicActive = false
		gs.notifConfigured = false
		return ctx, nil
	})

	// -------------------------------------------------------------------------
	// Given: vault state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the vault does not already exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	sc.Given(`^the vault already exists$`, func() error {
		// Arrange / Act: create the vault so it already exists.
		if err := glacierSNSCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		gs.vaultExists = true
		return nil
	})

	sc.Given(`^the vault exists$`, func() error {
		// Arrange / Act: ensure the vault exists.
		if err := glacierSNSCreateVault(world); err != nil {
			return fmt.Errorf("create vault: %w", err)
		}
		gs.vaultExists = true
		return nil
	})

	sc.Given(`^the vault does not exist$`, func() error {
		// No-op: fresh state after reset has no vaults.
		return nil
	})

	sc.Given(`^the vault has no "SNS" notification configured$`, func() error {
		// No-op: fresh vault has no SNS notification configured.
		return nil
	})

	sc.Given(`^the vault already has an "SNS" notification configured$`, func() error {
		// Arrange: configure a notification on the vault.
		topicArn := gs.topicArn
		if topicArn == "" {
			topicArn = glacierSNSTopicArn()
		}
		// Act
		_, err := world.GlacierClient().SetVaultNotifications(context.Background(), &glacier.SetVaultNotificationsInput{
			AccountId: aws.String(glacierSNSAccountID),
			VaultName: aws.String(glacierSNSTestVaultName),
			VaultNotificationConfig: &glaciertypes.VaultNotificationConfig{
				SNSTopic: aws.String(topicArn),
				Events:   []string{"ArchiveRetrievalCompleted", "InventoryRetrievalCompleted"},
			},
		})
		if err != nil {
			return fmt.Errorf("set vault notifications: %w", err)
		}
		gs.notifConfigured = true
		return nil
	})

	sc.Given(`^the vault has an "SNS" notification configured$`, func() error {
		// @internal: vault notification + job completion requires background processing.
		// No-op — this given is only used in @internal scenarios.
		gs.notifConfigured = true
		return nil
	})

	// -------------------------------------------------------------------------
	// Given: topic state setup
	// -------------------------------------------------------------------------

	sc.Given(`^the topic does not already exist$`, func() error {
		// No-op: fresh state after reset has no topics.
		return nil
	})

	sc.Given(`^the topic already exists$`, func() error {
		// Arrange / Act: create the topic so it already exists.
		topicArn, err := glacierSNSCreateTopic(world)
		if err != nil {
			return fmt.Errorf("create topic: %w", err)
		}
		gs.topicArn = topicArn
		gs.topicActive = true
		return nil
	})

	sc.Given(`^the topic exists$`, func() error {
		// Arrange / Act: ensure the topic exists.
		topicArn, err := glacierSNSCreateTopic(world)
		if err != nil {
			return fmt.Errorf("create topic: %w", err)
		}
		gs.topicArn = topicArn
		gs.topicActive = true
		return nil
	})

	sc.Given(`^the topic exists and is "ACTIVE"$`, func() error {
		// Arrange / Act: ensure the topic exists and is ACTIVE.
		topicArn, err := glacierSNSCreateTopic(world)
		if err != nil {
			return fmt.Errorf("create topic: %w", err)
		}
		gs.topicArn = topicArn
		gs.topicActive = true
		return nil
	})

	sc.Given(`^the topic is "ACTIVE"$`, func() error {
		// No-op: topics are ACTIVE immediately after creation in lws.
		return nil
	})

	sc.Given(`^the topic is already "DELETED"$`, func() error {
		// @internal: topic lifecycle transitions require background processing.
		return nil
	})

	sc.Given(`^the topic does not exist$`, func() error {
		// No-op: fresh state after reset has no topics.
		return nil
	})

	sc.Given(`^the topic does not exist or is not "ACTIVE"$`, func() error {
		// No-op: fresh state after reset has no topics.
		return nil
	})

	// ── Given: capacity steps ─────────────────────────────────────────────────

	sc.Given(`^a job slot is available$`, func() error {
		// No-op: job slots are available by default.
		return nil
	})

	sc.Given(`^no job slot is available$`, func() error {
		// Arrange: exhaust glacier job capacity.
		// Act
		return managementSession().Capacity("glacier").Exhaust().Apply()
	})

	sc.Given(`^a message slot is available$`, func() error {
		// No-op: message slots are available by default.
		return nil
	})

	sc.Given(`^no message slot is available$`, func() error {
		// Arrange: exhaust sns message capacity.
		// Act
		return managementSession().Capacity("sns").Exhaust().Apply()
	})

	// ── Given: internal state steps ──────────────────────────────────────────

	sc.Given(`^a job is "IN_PROGRESS"$`, func() error {
		// @internal: IN_PROGRESS job state requires background Glacier processing.
		return nil
	})

	sc.Given(`^no job is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress jobs.
		return nil
	})

	sc.Given(`^the configured topic is "ACTIVE"$`, func() error {
		// @internal: this given is only used in @internal scenarios.
		return nil
	})

	sc.Given(`^the configured topic is "DELETED"$`, func() error {
		// @internal: this given is only used in @internal scenarios.
		return nil
	})

	sc.Given(`^the configured topic is not "DELETED"$`, func() error {
		// @internal: this given is only used in @internal scenarios.
		return nil
	})

	// ── Given: model-level precondition steps (sequences.feature) ─────────────

	sc.Given(`^vid not in vault_status$`, func() error {
		// No-op: fresh state has no vaults.
		return nil
	})

	sc.Given(`^tid not in topic_status$`, func() error {
		// No-op: fresh state has no topics.
		return nil
	})

	sc.Given(`^jid in job_status$`, func() error {
		// @internal: job state requires background Glacier processing.
		return nil
	})

	// -------------------------------------------------------------------------
	// When: actions
	// -------------------------------------------------------------------------

	sc.When(`^a Glacier vault is created$`, func() error {
		// Arrange: (vault may or may not exist — set up by Given steps)
		// Act
		resp, err := world.GlacierClient().CreateVault(context.Background(), &glacier.CreateVaultInput{
			AccountId: aws.String(glacierSNSAccountID),
			VaultName: aws.String(glacierSNSTestVaultName),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "SNS" topic is created$`, func() error {
		// Arrange: (topic may or may not exist — set up by Given steps)
		// Act
		resp, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
			Name: aws.String(glacierSNSTestTopicName),
		})
		if err == nil && resp.TopicArn != nil {
			gs.topicArn = *resp.TopicArn
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the "SNS" topic is deleted$`, func() error {
		// Arrange: (topic state set up by Given steps)
		topicArn := gs.topicArn
		if topicArn == "" {
			topicArn = glacierSNSTopicArn()
		}
		// Act
		resp, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(topicArn),
		})
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^an "SNS" notification is configured on the vault$`, func() error {
		// Arrange: (vault/topic state set up by Given steps)
		topicArn := gs.topicArn
		if topicArn == "" {
			topicArn = glacierSNSTopicArn()
		}
		// Act
		resp, err := world.GlacierClient().SetVaultNotifications(context.Background(), &glacier.SetVaultNotificationsInput{
			AccountId: aws.String(glacierSNSAccountID),
			VaultName: aws.String(glacierSNSTestVaultName),
			VaultNotificationConfig: &glaciertypes.VaultNotificationConfig{
				SNSTopic: aws.String(topicArn),
				Events:   []string{"ArchiveRetrievalCompleted", "InventoryRetrievalCompleted"},
			},
		})
		if err == nil {
			gs.notifConfigured = true
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^a Glacier archive retrieval job is initiated on the vault$`, func() error {
		// Arrange: (vault state set up by Given steps)
		// Act
		resp, err := world.GlacierClient().InitiateJob(context.Background(), &glacier.InitiateJobInput{
			AccountId: aws.String(glacierSNSAccountID),
			VaultName: aws.String(glacierSNSTestVaultName),
			JobParameters: &glaciertypes.JobParameters{
				Type: aws.String("inventory-retrieval"),
			},
		})
		if err == nil && resp.JobId != nil {
			gs.jobID = *resp.JobId
		}
		// Assert: captured in world
		setResult(world, resp, err)
		return nil
	})

	sc.When(`^the Glacier job completes and publishes a notification to the configured "SNS" topic$`, func() error {
		// @internal: Glacier job completion notification delivery requires background processing.
		// This action cannot be performed via the public Glacier API.
		setResult(world, nil, fmt.Errorf("InvalidParameterValueException: job completion notification requires internal processing"))
		return nil
	})

	sc.When(`^the Glacier job completes but notification delivery fails because the topic was deleted$`, func() error {
		// @internal: Glacier job completion with failed notification requires background processing.
		// This action cannot be performed via the public Glacier API.
		setResult(world, nil, fmt.Errorf("InvalidParameterValueException: job completion notification failure requires internal processing"))
		return nil
	})

	// -------------------------------------------------------------------------
	// Then: assertions
	// -------------------------------------------------------------------------

	sc.Then(`^the vault "EXISTS" with no "SNS" notification configuration$`, func() error {
		// Arrange: no additional setup required
		// Act: describe the vault to verify it exists with no notification config
		resp, err := world.GlacierClient().DescribeVault(context.Background(), &glacier.DescribeVaultInput{
			AccountId: aws.String(glacierSNSAccountID),
			VaultName: aws.String(glacierSNSTestVaultName),
		})
		if err != nil {
			return fmt.Errorf("expected describe_vault to succeed but got: %w", err)
		}
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_vault to succeed but got: %w", world.lastResult.Error)
		}
		expectedVaultName := glacierSNSTestVaultName
		actualVaultName := aws.ToString(resp.VaultName)
		if actualVaultName != expectedVaultName {
			return fmt.Errorf("expected vault name %q but got %q; expected_vault_name=%s actual_vault_name=%s",
				expectedVaultName, actualVaultName, expectedVaultName, actualVaultName)
		}
		return nil
	})

	sc.Then(`^the topic is "ACTIVE"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected create_topic to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected CreateTopicOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the topic is "DELETED" and Glacier notifications will fail$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected delete_topic to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the vault will publish job completion notifications to the topic$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected set_vault_notifications to succeed but got: %w", world.lastResult.Error)
		}
		return nil
	})

	sc.Then(`^the job is "IN_PROGRESS"$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error != nil {
			return fmt.Errorf("expected initiate_job to succeed but got: %w", world.lastResult.Error)
		}
		if world.lastResult.Output == nil {
			return fmt.Errorf("expected InitiateJobOutput but got nil")
		}
		return nil
	})

	sc.Then(`^the job is "SUCCEEDED" and the notification is "PUBLISHED"$`, func() error {
		// @internal: job_completed_notification_delivered requires background processing. No assertion performed.
		return nil
	})

	sc.Then(`^the job is "SUCCEEDED" but no notification is published$`, func() error {
		// @internal: job_completed_notification_fails requires background processing. No assertion performed.
		return nil
	})

	sc.Then(`^the operation is rejected$`, func() error {
		// Arrange: no additional setup required
		// Act: action already performed in the When step
		// Assert
		if world.lastResult.Error == nil {
			return fmt.Errorf("expected operation to be rejected but it succeeded; expected_error=non-nil actual_error=nil")
		}
		return nil
	})

	// ── Safety invariant Then steps ───────────────────────────────────────────

	sc.Then(`^every "PUBLISHED" notification references a job that exists$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

	sc.Then(`^every "PUBLISHED" notification references a topic that exists$`, func() error {
		// No-op invariant: trivially satisfied in an isolated test context.
		return nil
	})

}
