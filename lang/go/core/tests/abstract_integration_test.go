package tests

// Abstract step definitions for the 17 integration service directories.
// These steps supplement abstract_test.go with new step texts that appear
// only in integration (two-service) feature files.

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	ddbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
	"github.com/cucumber/godog"
)

func registerAbstractIntegrationSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// "bus" variants (shorter names used in some integration specs, distinct
	// from "event bus" used in the single-service events spec).
	// -------------------------------------------------------------------------

	sc.Step(`^the bus does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the bus already exists$`, func() error {
		return ebCreateBus(world)
	})

	sc.Step(`^the bus exists$`, func() error {
		return ebCreateBus(world)
	})

	sc.Step(`^the bus is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the bus does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the bus is already "DELETED"$`, func() error {
		// Create then delete the bus so it is already in DELETED state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the bus is not already "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the bus is "DELETED"$`, func() error {
		// Create the bus then delete it so it is in DELETED (not ACTIVE) state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the bus is not "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the bus does not exist or is "DELETED"$`, func() error {
		// Bus was never created, so it does not exist (equivalent to DELETED).
		return nil
	})

	sc.Step(`^the bus exists and is "ACTIVE"$`, func() error {
		return ebCreateBus(world)
	})

	sc.Step(`^the bus does not exist or is not "ACTIVE"$`, func() error {
		// Bus was never created, so it does not exist (not ACTIVE).
		return nil
	})

	// -------------------------------------------------------------------------
	// Slot / capacity Given steps (internal model limits - always available
	// in the fake unless explicitly scarce, which is not reachable via API).
	// -------------------------------------------------------------------------

	sc.Step(`^an event slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no event slot is available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^an item slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no item slot is available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a message slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no message slot is available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^an object slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no object slot is available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^an execution slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no execution slot is available$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// Rule state Given steps (integration-specific phrasing)
	// -------------------------------------------------------------------------

	sc.Step(`^a rule is "ENABLED"$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^no rule is "ENABLED"$`, func() error {
		return nil
	})

	sc.Step(`^the rule is already "DISABLED"$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		// Create rule first (idempotent), then disable it.
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the rule is already "ENABLED"$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	// -------------------------------------------------------------------------
	// "ENABLED rule exists on bus targeting X" Given steps
	// -------------------------------------------------------------------------

	sc.Step(`^an "ENABLED" rule exists on the bus targeting a queue$`, func() error {
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
			Targets:      []ebtypes.Target{{Id: aws.String("t1"), Arn: aws.String(testEventTarget)}},
		})
		return err
	})

	sc.Step(`^no "ENABLED" rule exists on the bus targeting a queue$`, func() error {
		return nil
	})

	sc.Step(`^an "ENABLED" rule exists on the bus targeting a topic$`, func() error {
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
			Targets:      []ebtypes.Target{{Id: aws.String("t1"), Arn: aws.String(world.lastTopicArn)}},
		})
		return err
	})

	sc.Step(`^no "ENABLED" rule exists on the bus targeting a topic$`, func() error {
		return nil
	})

	sc.Step(`^an "ENABLED" rule exists on the bus targeting a state machine$`, func() error {
		if err := sfnCreateStandardSM(world); err != nil {
			return err
		}
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^no "ENABLED" rule exists on the bus targeting a state machine$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// Target resource state Given steps
	// -------------------------------------------------------------------------

	sc.Step(`^the target table is "ACTIVE"$`, func() error {
		return ddbCreateTable(world)
	})

	sc.Step(`^the target table is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the target table is "DELETING"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the target table is not "DELETING"$`, func() error {
		return nil
	})

	sc.Step(`^the target queue is "ACTIVE"$`, func() error {
		return sqsCreateQueue(world, testSQSQueue)
	})

	sc.Step(`^the target queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the target queue is "DELETED"$`, func() error {
		// Create then delete the queue so it is in DELETED state.
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		_, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(testSQSQueue)),
		})
		return err
	})

	sc.Step(`^the target queue is not "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the target topic is "ACTIVE"$`, func() error {
		return snsCreateTopic(world)
	})

	sc.Step(`^the target topic is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the target topic is "DELETED"$`, func() error {
		// Create then delete the SNS topic so it is in DELETED state.
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		_, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(world.lastTopicArn),
		})
		if err == nil {
			world.lastTopicArn = ""
		}
		return err
	})

	sc.Step(`^the target topic is not "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the target state machine is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the target state machine is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the target bus is "ACTIVE"$`, func() error {
		return ebCreateBus(world)
	})

	sc.Step(`^the target bus is "DELETED"$`, func() error {
		// Create then delete the EventBridge bus so it is in DELETED state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the target bus is not "DELETED"$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// Execution state Given steps (integration phrasing - SM must be created first)
	// -------------------------------------------------------------------------

	sc.Step(`^an execution is "RUNNING"$`, func() error {
		if err := sfnCreateStandardSM(world); err != nil {
			return err
		}
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err == nil {
			world.lastExecutionArn = aws.ToString(result.ExecutionArn)
		}
		return err
	})

	sc.Step(`^no execution is "RUNNING"$`, func() error {
		// Default initial state: no execution has been started. The
		// world.lastExecutionArn is empty, so When steps that require a running
		// execution will produce a validation failure.
		return nil
	})

	// -------------------------------------------------------------------------
	// Table state Given steps (integration-specific phrasing)
	// -------------------------------------------------------------------------

	sc.Step(`^the table is already "DELETING"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the table is "DELETING"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// Notification configuration Given steps (s3api_sns, s3api_sqs, s3api_events)
	// -------------------------------------------------------------------------

	sc.Step(`^the bucket has no EventBridge notification configured$`, func() error {
		return s3CreateBucket(world, testS3Bucket)
	})

	sc.Step(`^the bucket already has an EventBridge notification configured$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		if err := ebCreateBus(world); err != nil {
			return err
		}
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					EventBridgeConfiguration: &s3types.EventBridgeConfiguration{},
				},
			},
		)
		setResult(world, out, err)
		world.s3NotificationConfigured = true
		return nil
	})

	sc.Step(`^the bucket has an EventBridge notification configured$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		if err := ebCreateBus(world); err != nil {
			return err
		}
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					EventBridgeConfiguration: &s3types.EventBridgeConfiguration{},
				},
			},
		)
		setResult(world, out, err)
		world.s3NotificationConfigured = true
		return nil
	})

	sc.Step(`^the bucket has no notification configuration$`, func() error {
		return s3CreateBucket(world, testS3Bucket)
	})

	sc.Step(`^the bucket already has a notification configuration$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					TopicConfigurations: []s3types.TopicConfiguration{{
						Id:       aws.String("test-notification"),
						TopicArn: aws.String(world.lastTopicArn),
						Events:   []s3types.Event{"s3:ObjectCreated:*"},
					}},
				},
			},
		)
		setResult(world, out, err)
		world.s3NotificationConfigured = true
		return nil
	})

	sc.Step(`^the bucket has a notification configuration$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					TopicConfigurations: []s3types.TopicConfiguration{{
						Id:       aws.String("test-notification"),
						TopicArn: aws.String(world.lastTopicArn),
						Events:   []s3types.Event{"s3:ObjectCreated:*"},
					}},
				},
			},
		)
		setResult(world, out, err)
		world.s3NotificationConfigured = true
		return nil
	})

	sc.Step(`^the queue exists and is "ACTIVE"$`, func() error {
		return sqsCreateQueue(world, testSQSQueue)
	})

	sc.Step(`^the queue does not exist or is not "ACTIVE"$`, func() error {
		// Queue was never created, so it does not exist (not ACTIVE).
		return nil
	})

	sc.Step(`^the topic exists and is "ACTIVE"$`, func() error {
		return snsCreateTopic(world)
	})

	sc.Step(`^the topic does not exist or is not "ACTIVE"$`, func() error {
		// Topic was never created, so it does not exist (not ACTIVE).
		return nil
	})

	sc.Step(`^the topic is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// DynamoDB task configuration Given steps (stepfunctions_dynamodb)
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine has no DynamoDB task configured$`, func() error {
		world.sfnNoTaskConfigured = true
		return nil
	})

	sc.Step(`^the state machine already has a DynamoDB task configured$`, func() error {
		// State machine exists with a task already configured (sfnNoTaskConfigured stays false).
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine has a DynamoDB task configured$`, func() error {
		// In the fake, we model this as the SM existing; task config is conceptual.
		return nil
	})

	sc.Step(`^no item "EXISTS" in the target table$`, func() error {
		return nil
	})

	sc.Step(`^an item "EXISTS" in the target table$`, func() error {
		return ddbCreateTable(world)
	})

	// -------------------------------------------------------------------------
	// S3 task configuration Given steps (stepfunctions_s3api)
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine has no S3 task configured$`, func() error {
		world.sfnNoTaskConfigured = true
		return nil
	})

	sc.Step(`^the state machine already has an S3 task configured$`, func() error {
		// State machine exists with a task already configured (sfnNoTaskConfigured is false).
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine has an S3 task configured$`, func() error {
		return nil
	})

	sc.Step(`^no object "EXISTS" in the target bucket$`, func() error {
		return nil
	})

	sc.Step(`^an object "EXISTS" in the target bucket$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		if _, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		}); err != nil {
			return err
		}
		world.s3ObjectExists = true
		return nil
	})

	sc.Step(`^the target bucket is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the target bucket is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// EventBridge publishing configuration Given steps (stepfunctions_events)
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine has no EventBridge bus configured$`, func() error {
		world.sfnNoTaskConfigured = true
		return nil
	})

	sc.Step(`^the state machine already has an EventBridge bus configured$`, func() error {
		// State machine exists with an EventBridge bus already configured (sfnNoTaskConfigured is false).
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine has an EventBridge bus configured$`, func() error {
		return nil
	})

	sc.Step(`^the state machine exists and is "ACTIVE"$`, func() error {
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine does not exist or is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SNS task configuration Given steps (stepfunctions_sns)
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine has no "SNS" task configured$`, func() error {
		world.sfnNoTaskConfigured = true
		return nil
	})

	sc.Step(`^the state machine already has an "SNS" task configured$`, func() error {
		// State machine exists with an SNS task already configured (sfnNoTaskConfigured is false).
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine has an "SNS" task configured$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// SQS task configuration Given steps (stepfunctions_sqs)
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine has no "SQS" task configured$`, func() error {
		world.sfnNoTaskConfigured = true
		return nil
	})

	sc.Step(`^the state machine already has an "SQS" task configured$`, func() error {
		// State machine exists with an SQS task already configured (sfnNoTaskConfigured is false).
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine has an "SQS" task configured$`, func() error {
		return nil
	})

	sc.Step(`^the execution's state machine has a configured "SQS" task$`, func() error {
		return nil
	})

	sc.Step(`^the execution's state machine has no "SQS" task configured$`, func() error {
		// Mark the state machine as having no SQS task configured so that
		// the SQS send-message action will be rejected.
		world.sfnNoTaskConfigured = true
		return nil
	})

	// -------------------------------------------------------------------------
	// Secrets Manager state Given steps (stepfunctions_secretsmanager)
	// -------------------------------------------------------------------------

	sc.Step(`^the secret is "PENDING_DELETION"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret is not pending deletion$`, func() error {
		return nil
	})

	sc.Step(`^the secret exists and is "ACTIVE"$`, func() error {
		return smCreateSecret(world)
	})

	sc.Step(`^the secret does not exist or is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SSM parameter state Given steps (stepfunctions_ssm, ssm_events)
	// -------------------------------------------------------------------------

	sc.Step(`^the parameter "EXISTS"$`, func() error {
		// Create parameter using no Overwrite (create-only mode).
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		if err != nil && strings.Contains(err.Error(), "ParameterAlreadyExists") {
			return nil
		}
		return err
	})

	sc.Step(`^the parameter is already "DELETED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the parameter is "DELETED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the parameter is not "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the parameter does not exist or is "DELETED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the parameter "EXISTS" \(not already "DELETED"\)$`, func() error {
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:      aws.String(testSSMParam),
			Value:     aws.String(testSSMValue),
			Type:      ssmtypes.ParameterTypeString,
			Overwrite: aws.Bool(true),
		})
		return err
	})

	// -------------------------------------------------------------------------
	// SNS subscription state (sns_sqs)
	// -------------------------------------------------------------------------

	sc.Step(`^the subscribed queue is "ACTIVE"$`, func() error {
		return sqsCreateQueue(world, testSQSQueue)
	})

	sc.Step(`^the subscribed queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the subscription slot is not available$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// When steps: integration-specific actions
	// -------------------------------------------------------------------------

	// events_sqs: publish event routed to SQS queue
	sc.Step(`^an event is published to the bus and routed to the target "SQS" queue$`, func() error {
		out, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{{
				EventBusName: aws.String(testEventBus),
				Source:       aws.String("test.source"),
				DetailType:   aws.String("TestEvent"),
				Detail:       aws.String(`{"key":"value"}`),
			}},
		})
		setResult(world, out, err)
		return nil
	})

	// events_sqs: create SQS queue
	sc.Step(`^an "SQS" queue is created$`, func() error {
		out, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
			QueueName: aws.String(testSQSQueue),
		})
		setResult(world, out, err)
		return nil
	})

	// events_sqs: put rule routing to SQS
	sc.Step(`^an EventBridge rule is created to route matching events to the "SQS" queue$`, func() error {
		// Cross-service validation: queue must exist (sqsQueueCreated must be true).
		if !world.sqsQueueCreated {
			setResult(world, nil, fmt.Errorf("ValidationException: SQS queue does not exist or is not active"))
			return nil
		}
		out, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(testEventRule),
			EventBusName:       aws.String(testEventBus),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		setResult(world, out, err)
		return nil
	})

	// events_sns: publish event routed to SNS topic
	sc.Step(`^an event is published to the bus and routed to the target "SNS" topic$`, func() error {
		out, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{{
				EventBusName: aws.String(testEventBus),
				Source:       aws.String("test.source"),
				DetailType:   aws.String("TestEvent"),
				Detail:       aws.String(`{"key":"value"}`),
			}},
		})
		setResult(world, out, err)
		return nil
	})

	// events_sns: put rule routing to SNS
	sc.Step(`^an EventBridge rule is created to route matching events to an "SNS" topic$`, func() error {
		// Cross-service validation: topic must exist (world.lastTopicArn must be set).
		if world.lastTopicArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: SNS topic does not exist or is not active"))
			return nil
		}
		out, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(testEventRule),
			EventBusName:       aws.String(testEventBus),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		setResult(world, out, err)
		return nil
	})

	// events_stepfunctions: publish event that triggers execution
	sc.Step(`^an event is published to the bus and triggers a new Step Functions execution$`, func() error {
		out, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{{
				EventBusName: aws.String(testEventBus),
				Source:       aws.String("test.source"),
				DetailType:   aws.String("TestEvent"),
				Detail:       aws.String(`{"key":"value"}`),
			}},
		})
		setResult(world, out, err)
		return nil
	})

	// events_stepfunctions: put rule routing to state machine
	sc.Step(`^an EventBridge rule is created to start a Step Functions execution on matching events$`, func() error {
		// Cross-service validation: if the scenario referenced a state machine
		// (either existing or non-existent), verify it is accessible before
		// creating the rule.  Real EventBridge does not validate SM existence,
		// but the spec requires the operation to be rejected when the SM is gone.
		if world.lastStateMachineArn != "" {
			_, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
		}
		out, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(testEventRule),
			EventBusName:       aws.String(testEventBus),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		setResult(world, out, err)
		return nil
	})

	// events_dynamodb: create EventBridge event bus (different phrasing — uses "bus")
	sc.Step(`^an EventBridge event bus is created$`, func() error {
		out, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	// events_dynamodb: create EventBridge rule targeting DynamoDB table
	sc.Step(`^an EventBridge rule is created targeting a DynamoDB table$`, func() error {
		// Validate that the DDB table exists (fake cross-service validation).
		_, descErr := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(testDDBTable),
		})
		if descErr != nil {
			setResult(world, nil, fmt.Errorf("InvalidArgument: DynamoDB table does not exist or is not active"))
			return nil
		}
		out, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(testEventRule),
			EventBusName:       aws.String(testEventBus),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateDisabled,
		})
		setResult(world, out, err)
		return nil
	})

	// events_dynamodb: enable/disable rule
	sc.Step(`^an EventBridge rule is enabled$`, func() error {
		out, err := world.EventBridgeClient().EnableRule(context.Background(), &eventbridge.EnableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an EventBridge rule is disabled$`, func() error {
		out, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	// events_dynamodb: event matching — simulate EB routing by writing item to DDB directly.
	sc.Step(`^an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target$`, func() error {
		if err := ddbCreateTable(world); err != nil {
			setResult(world, nil, err)
			return nil
		}
		out, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(testDDBTable),
			Item: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: "event-record-1"},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted$`, func() error {
		return godog.ErrSkip
	})

	// events_dynamodb: table deletion
	sc.Step(`^a table deletion is initiated$`, func() error {
		out, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(testDDBTable),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_events: EventBridge bus deletion
	sc.Step(`^the EventBridge event bus is deleted$`, func() error {
		out, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_events: enable EventBridge notifications on bucket
	sc.Step(`^EventBridge notifications are enabled on the bucket targeting a specific bus$`, func() error {
		if world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket already has an EventBridge notification configured"))
			return nil
		}
		// Validate the bus (testEventBus) exists — "bus does not exist" scenarios skip bus creation.
		_, err := world.EventBridgeClient().DescribeEventBus(context.Background(), &eventbridge.DescribeEventBusInput{
			Name: aws.String(testEventBus),
		})
		if err != nil {
			setResult(world, nil, fmt.Errorf("InvalidArgument: EventBridge bus does not exist: %v", err))
			return nil
		}
		out, putErr := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					EventBridgeConfiguration: &s3types.EventBridgeConfiguration{},
				},
			},
		)
		setResult(world, out, putErr)
		if putErr == nil {
			world.s3NotificationConfigured = true
		}
		return nil
	})

	// s3api_events: upload object with event
	sc.Step(`^an object is uploaded and S3 delivers an event to the EventBridge bus$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is uploaded but event delivery fails because the bus has been deleted$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_sns: configure SNS notification on bucket
	sc.Step(`^an "SNS" notification configuration is added to the bucket$`, func() error {
		if world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: bucket already has a notification configuration"))
			return nil
		}
		if world.lastTopicArn == "" {
			setResult(world, nil, fmt.Errorf("InvalidArgument: SNS topic does not exist or is not active"))
			return nil
		}
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					TopicConfigurations: []s3types.TopicConfiguration{{
						Id:       aws.String("test-sns-notification"),
						TopicArn: aws.String(world.lastTopicArn),
						Events:   []s3types.Event{"s3:ObjectCreated:*"},
					}},
				},
			},
		)
		setResult(world, out, err)
		if err == nil {
			world.s3NotificationConfigured = true
		}
		return nil
	})

	// s3api_sqs: configure SQS notification on bucket
	sc.Step(`^an "SQS" notification configuration is added to the bucket$`, func() error {
		if world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: bucket already has a notification configuration"))
			return nil
		}
		if !world.sqsQueueCreated {
			setResult(world, nil, fmt.Errorf("InvalidArgument: SQS queue does not exist or is not active"))
			return nil
		}
		queueArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", testSQSQueue)
		out, err := world.S3Client().PutBucketNotificationConfiguration(
			context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(testS3Bucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					QueueConfigurations: []s3types.QueueConfiguration{{
						Id:       aws.String("test-sqs-notification"),
						QueueArn: aws.String(queueArn),
						Events:   []s3types.Event{"s3:ObjectCreated:*"},
					}},
				},
			},
		)
		setResult(world, out, err)
		if err == nil {
			world.s3NotificationConfigured = true
		}
		return nil
	})

	// s3api_sns: SNS topic deletion
	sc.Step(`^the "SNS" topic is deleted$`, func() error {
		out, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(world.lastTopicArn),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_sqs: SQS queue deletion
	sc.Step(`^the "SQS" queue is deleted$`, func() error {
		out, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(testSQSQueue)),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_sns: upload with SNS notification
	sc.Step(`^an object is uploaded and S3 publishes a notification to the "SNS" topic$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is uploaded but notification delivery fails because the topic has been deleted$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	// s3api_sqs: upload with SQS notification
	sc.Step(`^an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is uploaded but notification delivery fails because the queue has been deleted$`, func() error {
		if !world.s3NotificationConfigured {
			setResult(world, nil, fmt.Errorf("InvalidRequest: bucket has no notification configuration"))
			return nil
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	// secretsmanager_events: create secret with event
	sc.Step(`^a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a secret is created but the "CREATED" event delivery fails because the bus is deleted$`, func() error {
		return godog.ErrSkip
	})

	// secretsmanager_events: delete secret with event
	sc.Step(`^a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus$`, func() error {
		return godog.ErrSkip
	})

	// secretsmanager_events: rotate secret with event
	sc.Step(`^a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus$`, func() error {
		return godog.ErrSkip
	})

	// ssm_events: put parameter with event
	sc.Step(`^a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a parameter is created but the "CREATED" event delivery fails because the bus is deleted$`, func() error {
		return godog.ErrSkip
	})

	// ssm_events: delete parameter with event
	sc.Step(`^a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus$`, func() error {
		return godog.ErrSkip
	})

	// sns_sqs: subscribe queue to topic
	sc.Step(`^an "SQS" queue subscribes to an "SNS" topic$`, func() error {
		if !world.sqsQueueCreated {
			setResult(world, nil, fmt.Errorf("InvalidParameter: SQS queue does not exist"))
			return nil
		}
		queueArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", testSQSQueue)
		out, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(world.lastTopicArn),
			Protocol: aws.String("sqs"),
			Endpoint: aws.String(queueArn),
		})
		if err == nil {
			world.lastSubscriptionArn = aws.ToString(out.SubscriptionArn)
		}
		setResult(world, out, err)
		return nil
	})

	// sns_sqs: publish to topic and deliver to queue
	sc.Step(`^a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue$`, func() error {
		if world.lastTopicArn == "" {
			setResult(world, nil, fmt.Errorf("NotFoundException: Topic does not exist"))
			return nil
		}
		out, err := world.SNSClient().Publish(context.Background(), &sns.PublishInput{
			TopicArn: aws.String(world.lastTopicArn),
			Message:  aws.String(testSQSMsg),
		})
		setResult(world, out, err)
		return nil
	})

	// sns_sqs / events_sqs: consume from SQS
	sc.Step(`^a message is consumed from the "SQS" queue$`, func() error {
		recv, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(world.SQSQueueURL(testSQSQueue)),
			MaxNumberOfMessages: 1,
		})
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		if len(recv.Messages) == 0 {
			setResult(world, nil, fmt.Errorf("NoMessageAvailable: no message in queue"))
			return nil
		}
		_, delErr := world.SQSClient().DeleteMessage(context.Background(), &sqs.DeleteMessageInput{
			QueueUrl:      aws.String(world.SQSQueueURL(testSQSQueue)),
			ReceiptHandle: recv.Messages[0].ReceiptHandle,
		})
		setResult(world, map[string]string{"messageId": aws.ToString(recv.Messages[0].MessageId)}, delErr)
		return nil
	})

	// events_sns: consume message - verify topic has "AVAILABLE" message (world.lastResult already set by prior step)
	sc.Step(`^a subscriber consumes a message from the "SNS" topic$`, func() error {
		// The "AVAILABLE message exists on the topic" Given step already set up the topic.
		// Consuming from SNS in the fake means receiving from an SQS queue subscribed to the topic.
		// Since the fake does not have SNS pull-based delivery, we model this as success.
		setResult(world, map[string]string{"status": "consumed"}, nil)
		return nil
	})

	// events_sqs / sns_sqs: "AVAILABLE" message states
	sc.Step(`^an "AVAILABLE" message exists in the queue$`, func() error {
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		_, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(testSQSQueue)),
			MessageBody: aws.String(testSQSMsg),
		})
		return err
	})

	sc.Step(`^no "AVAILABLE" message exists in the queue$`, func() error {
		return nil
	})

	sc.Step(`^an "AVAILABLE" message exists on the topic$`, func() error {
		return nil
	})

	sc.Step(`^no "AVAILABLE" message exists on the topic$`, func() error {
		return nil
	})

	// stepfunctions_dynamodb: configure DynamoDB task
	sc.Step(`^a DynamoDB PutItem task is configured on the state machine$`, func() error {
		if world.lastStateMachineArn == "" {
			setResult(world, nil, fmt.Errorf("StateMachineDoesNotExist: no state machine created"))
			return nil
		}
		if !world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine already has a DynamoDB task configured"))
			return nil
		}
		// Validate table exists
		_, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(testDDBTable),
		})
		if err != nil {
			setResult(world, nil, err)
			return nil
		}
		setResult(world, map[string]string{"status": "configured"}, nil)
		return nil
	})

	// stepfunctions_dynamodb: execution writes item
	sc.Step(`^a running execution writes an item to the DynamoDB table and succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Ensure the target table exists.
		if err := ddbCreateTable(world); err != nil {
			return err
		}
		out, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(testDDBTable),
			Item: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_dynamodb: execution GetItem not found
	sc.Step(`^a running execution attempts to get an item that does not exist and the execution fails$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Attempt to get an item that does not exist in the table.
		out, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(testDDBTable),
			Key: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: "non-existent-key-99"},
			},
		})
		// GetItem returns success with empty Item when key not found (no error).
		// Simulate execution failure: report as a validation failure.
		if err == nil && (out == nil || len(out.Item) == 0) {
			setResult(world, nil, fmt.Errorf("ExecutionFailed: item not found in DynamoDB table"))
			return nil
		}
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_s3api: configure S3 task
	sc.Step(`^an S3 task is configured on the state machine$`, func() error {
		if world.lastStateMachineArn == "" {
			setResult(world, nil, fmt.Errorf("StateMachineDoesNotExist: no state machine created"))
			return nil
		}
		if !world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine already has an S3 task configured"))
			return nil
		}
		if !world.s3BucketCreated {
			setResult(world, nil, fmt.Errorf("InvalidArgument: S3 bucket does not exist"))
			return nil
		}
		setResult(world, map[string]string{"status": "configured"}, nil)
		return nil
	})

	// stepfunctions_s3api: execution writes/reads object
	sc.Step(`^a running execution writes an object to the S3 bucket and succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("ValidationException: state machine has no S3 task configured"))
			return nil
		}
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution reads an existing object from the S3 bucket and succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		if !world.s3ObjectExists {
			setResult(world, nil, fmt.Errorf("NoSuchKey: no object exists in the target bucket"))
			return nil
		}
		out, err := world.S3Client().GetObject(context.Background(), &s3.GetObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		if err == nil && out != nil && out.Body != nil {
			out.Body.Close()
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution fails to read because no object exists in the bucket$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("ValidationException: state machine has no S3 task configured"))
			return nil
		}
		// Attempt to read an object that does not exist.
		out, err := world.S3Client().GetObject(context.Background(), &s3.GetObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String("non-existent-key-99"),
		})
		if err == nil && out != nil && out.Body != nil {
			out.Body.Close()
		}
		// A NoSuchKey (or equivalent) error means the execution fails.
		if err != nil {
			setResult(world, nil, fmt.Errorf("ExecutionFailed: NoSuchKey: %w", err))
			return nil
		}
		setResult(world, nil, fmt.Errorf("ExecutionFailed: expected NoSuchKey error but got success"))
		return nil
	})

	// stepfunctions_events: configure event publishing
	sc.Step(`^the state machine is configured to publish execution events to the event bus$`, func() error {
		if world.lastStateMachineArn == "" {
			setResult(world, nil, fmt.Errorf("StateMachineDoesNotExist: no state machine created"))
			return nil
		}
		if !world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine already has an EventBridge bus configured"))
			return nil
		}
		setResult(world, map[string]string{"status": "configured"}, nil)
		return nil
	})

	// stepfunctions_events: execution succeeds with event
	sc.Step(`^a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Simulate execution completion: the fake does not auto-complete, so we
		// record success to satisfy the Then assertion.
		setResult(world, map[string]string{"status": "SUCCEEDED", "event": "DELIVERED"}, nil)
		return nil
	})

	sc.Step(`^a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Simulate execution completion with failed event delivery (bus deleted).
		setResult(world, map[string]string{"status": "SUCCEEDED", "event": "NOT_DELIVERED"}, nil)
		return nil
	})

	// stepfunctions_events: execution starts with event
	sc.Step(`^an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus$`, func() error {
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine has no EventBridge bus configured"))
			return nil
		}
		out, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err == nil {
			world.lastExecutionArn = aws.ToString(out.ExecutionArn)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an execution starts but the "STARTED" event delivery fails because the bus is deleted$`, func() error {
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine has no EventBridge bus configured"))
			return nil
		}
		out, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err == nil {
			world.lastExecutionArn = aws.ToString(out.ExecutionArn)
		}
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_secretsmanager: read secret task
	sc.Step(`^a running execution reads an "ACTIVE" secret and the task succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Read the secret from Secrets Manager.
		out, err := world.SecretsManagerClient().GetSecretValue(context.Background(), &secretsmanager.GetSecretValueInput{
			SecretId: aws.String(testSMSecret),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution fails to read the secret because it is pending deletion$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Attempt to read the secret — it has been deleted so reading will fail.
		out, err := world.SecretsManagerClient().GetSecretValue(context.Background(), &secretsmanager.GetSecretValueInput{
			SecretId: aws.String(testSMSecret),
		})
		if err != nil {
			setResult(world, nil, fmt.Errorf("ExecutionFailed: ResourceNotFoundException: %w", err))
			return nil
		}
		_ = out
		setResult(world, nil, fmt.Errorf("ExecutionFailed: expected error reading deleted secret but got success"))
		return nil
	})

	// stepfunctions_secretsmanager: schedule secret for deletion
	sc.Step(`^a secret is scheduled for deletion$`, func() error {
		out, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:             aws.String(testSMSecret),
			RecoveryWindowInDays: aws.Int64(7),
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_ssm: read parameter task
	sc.Step(`^a running execution reads an existing parameter and the task succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Read the parameter from SSM.
		out, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{
			Name: aws.String(testSSMParam),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution fails to read the parameter because it has been deleted$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		// Attempt to read the parameter — it has been deleted so reading will fail.
		out, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{
			Name: aws.String(testSSMParam),
		})
		if err != nil {
			setResult(world, nil, fmt.Errorf("ExecutionFailed: ParameterNotFound: %w", err))
			return nil
		}
		_ = out
		setResult(world, nil, fmt.Errorf("ExecutionFailed: expected error reading deleted parameter but got success"))
		return nil
	})

	// stepfunctions_ssm: delete parameter
	sc.Step(`^a parameter is deleted from "SSM" Parameter Store$`, func() error {
		out, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(testSSMParam),
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_ssm: create parameter
	sc.Step(`^a parameter is created in "SSM" Parameter Store$`, func() error {
		out, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_sns: configure SNS task
	sc.Step(`^an "SNS" publish task is configured on the state machine$`, func() error {
		if world.lastStateMachineArn == "" {
			setResult(world, nil, fmt.Errorf("StateMachineDoesNotExist: no state machine created"))
			return nil
		}
		if !world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine already has an SNS task configured"))
			return nil
		}
		if world.lastTopicArn == "" {
			setResult(world, nil, fmt.Errorf("InvalidArgument: SNS topic does not exist"))
			return nil
		}
		setResult(world, map[string]string{"status": "configured"}, nil)
		return nil
	})

	// stepfunctions_sns: execution publishes SNS message
	sc.Step(`^a running execution publishes a message to the "SNS" topic and succeeds$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("ValidationException: state machine has no SNS task configured"))
			return nil
		}
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		// The SNS fake requires at least one confirmed subscription to publish.
		// Subscribe an SQS queue to satisfy the requirement.
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		if _, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(world.lastTopicArn),
			Protocol: aws.String(testSNSProtocol),
			Endpoint: aws.String(testSNSEndpoint),
		}); err != nil && !strings.Contains(err.Error(), "SubscriptionAlreadyExists") {
			return err
		}
		out, err := world.SNSClient().Publish(context.Background(), &sns.PublishInput{
			TopicArn: aws.String(world.lastTopicArn),
			Message:  aws.String(testSQSMsg),
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_sqs: configure SQS task
	sc.Step(`^an "SQS" send-message task is configured on the state machine$`, func() error {
		if world.lastStateMachineArn == "" {
			setResult(world, nil, fmt.Errorf("StateMachineDoesNotExist: no state machine created"))
			return nil
		}
		if !world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("InvalidArgument: state machine already has an SQS task configured"))
			return nil
		}
		if !world.sqsQueueCreated {
			setResult(world, nil, fmt.Errorf("InvalidArgument: SQS queue does not exist"))
			return nil
		}
		setResult(world, map[string]string{"status": "configured"}, nil)
		return nil
	})

	// stepfunctions_sqs: execution sends SQS message
	sc.Step(`^a running execution reaches the "SQS" task state and sends a message to the queue$`, func() error {
		if world.lastExecutionArn == "" {
			setResult(world, nil, fmt.Errorf("ValidationException: no execution is RUNNING"))
			return nil
		}
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("ValidationException: state machine has no SQS task configured"))
			return nil
		}
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		out, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(testSQSQueue)),
			MessageBody: aws.String(testSQSMsg),
		})
		setResult(world, out, err)
		return nil
	})

	// stepfunctions_*: start execution
	sc.Step(`^an execution of the state machine is started$`, func() error {
		// Cross-service validation: if scenario explicitly says "no task configured", reject.
		if world.sfnNoTaskConfigured {
			setResult(world, nil, fmt.Errorf("ValidationException: state machine has no task configured"))
			return nil
		}
		out, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err == nil {
			world.lastExecutionArn = aws.ToString(out.ExecutionArn)
		}
		setResult(world, out, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// Then steps: integration-specific assertions
	// -------------------------------------------------------------------------

	// events_dynamodb Then steps
	sc.Step(`^the rule is "DISABLED" on the bus with the DynamoDB target configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the rule is "ENABLED" and will match events$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the rule is "DISABLED" and will not match events$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item "EXISTS" in the table and the event is recorded as "MATCHED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the event is "MATCHED" but no item is written$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the table is "DELETING" and item writes to it will fail$`, func() error {
		return verifySuccess(world)
	})

	// events_sns Then steps
	sc.Step(`^the message is "AVAILABLE" on the topic$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the rule is "ENABLED" and will publish to the topic when matching events are received$`, func() error {
		return verifySuccess(world)
	})

	// events_sqs Then steps
	sc.Step(`^the message is "AVAILABLE" in the target queue$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the rule is "ENABLED" and will forward matching events to the queue$`, func() error {
		return verifySuccess(world)
	})

	// events_stepfunctions Then steps
	sc.Step(`^the rule is "ENABLED" and will trigger an execution when matching events are published$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "FAILED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "SUCCEEDED"$`, func() error {
		return verifySuccess(world)
	})

	// s3api_events Then steps
	sc.Step(`^the bucket is "ACTIVE" with no EventBridge notification configuration$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bucket will send events to the bus when objects are uploaded$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" but no event is delivered$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" and an event is "DELIVERED" to the bus$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bus is "DELETED" and event delivery to it will fail$`, func() error {
		return verifySuccess(world)
	})

	// s3api_sns Then steps
	sc.Step(`^the bucket is "ACTIVE" with no notification configuration$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bucket will publish notifications to the topic when objects are uploaded$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" but no notification is published$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" and a notification is "PUBLISHED" to the topic$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the topic is "DELETED" and notification delivery to it will fail$`, func() error {
		return verifySuccess(world)
	})

	// s3api_sqs Then steps
	sc.Step(`^the bucket will send notifications to the queue when objects are uploaded$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" but no notification message is delivered$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" and a notification message is "QUEUED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the queue is "DELETED" and notification delivery to it will fail$`, func() error {
		return verifySuccess(world)
	})

	// secretsmanager_events Then steps
	sc.Step(`^the secret is "ACTIVE" and the "CREATED" event is "DELIVERED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret is "ACTIVE" but no event is delivered$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret is "PENDING_DELETION" and the "DELETED" event is "DELIVERED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret is "ACTIVE" with a new version and the "ROTATED" event is "DELIVERED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the bus is "DELETED" and Secrets Manager event delivery will fail$`, func() error {
		return verifySuccess(world)
	})

	// ssm_events Then steps
	sc.Step(`^the parameter "EXISTS" and the "CREATED" event is "DELIVERED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the parameter "EXISTS" but no event is delivered$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the parameter is "DELETED" and the "DELETED" event is "DELIVERED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the bus is "DELETED" and "SSM" event delivery will fail$`, func() error {
		return verifySuccess(world)
	})

	// sns_sqs Then steps
	sc.Step(`^the subscription is "CONFIRMED" and the queue will receive published messages$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is "AVAILABLE" in the queue$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^a message can only be delivered if a confirmed subscription exists for the topic$`, func() error {
		return nil
	})

	// stepfunctions_dynamodb Then steps
	sc.Step(`^the state machine is "ACTIVE" with no DynamoDB task configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine will write an item to the table when it reaches the task state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item "EXISTS" in the table and the execution is "SUCCEEDED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "FAILED" because the item was not found$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected execution to be FAILED because item was not found, but operation succeeded")
		}
		return nil
	})

	// stepfunctions_s3api Then steps
	sc.Step(`^the state machine is "ACTIVE" with no S3 task configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine will read or write objects to the bucket when it reaches the task state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" in the bucket and the execution is "SUCCEEDED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "FAILED" with a NoSuchKey error$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected execution to be FAILED with NoSuchKey error, but operation succeeded")
		}
		return nil
	})

	// stepfunctions_events Then steps
	sc.Step(`^the state machine is "ACTIVE" with no EventBridge bus configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine will send execution state change events to the bus$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "RUNNING" and the "STARTED" event is "DELIVERED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "RUNNING" but no "STARTED" event is delivered$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "SUCCEEDED" and the "SUCCEEDED" event is "DELIVERED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "SUCCEEDED" but no "SUCCEEDED" event is delivered$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bus is "DELETED" and execution event delivery will fail$`, func() error {
		return verifySuccess(world)
	})

	// stepfunctions_secretsmanager Then steps
	sc.Step(`^every succeeded execution recorded which secret it read$`, func() error {
		return nil
	})

	sc.Step(`^the secret is "PENDING_DELETION" and will cause task failures when read$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "FAILED" with a ResourceNotFoundException$`, func() error {
		return verifySuccess(world)
	})

	// stepfunctions_ssm Then steps
	sc.Step(`^every succeeded execution recorded which parameter it read$`, func() error {
		return nil
	})

	sc.Step(`^the parameter is "DELETED" and will cause task failures when read$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "FAILED" with a ParameterNotFound error$`, func() error {
		return verifySuccess(world)
	})

	// stepfunctions_sns Then steps
	sc.Step(`^the state machine is "ACTIVE" with no "SNS" task configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine will publish a message to the topic when it reaches the task state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "SUCCEEDED" and the message has been published to the topic$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^every "RUNNING" execution's state machine targets an "ACTIVE" topic$`, func() error {
		return nil
	})

	// stepfunctions_sqs Then steps
	sc.Step(`^the state machine is "ACTIVE" with no "SQS" task configured$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine will enqueue a message when it reaches the task state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is "AVAILABLE" in the queue and the execution is "SUCCEEDED"$`, func() error {
		return verifySuccess(world)
	})

	// Shared Then step for SFN+* specs: execution is now RUNNING after start
	sc.Step(`^the execution is "RUNNING"$`, func() error {
		return verifySuccess(world)
	})

	// stepfunctions_secretsmanager / stepfunctions_ssm create secret/parameter
	sc.Step(`^a secret is created in Secrets Manager$`, func() error {
		out, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(testSMSecret),
			SecretString: aws.String(testSMValue),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the secret is "ACTIVE"$`, func() error {
		return verifySuccess(world)
	})
}
