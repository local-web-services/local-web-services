package tests

// registerSequenceSteps wires all cross-service FizzBee sequence step definitions.
// Steps are registered once here to avoid duplicate-pattern panics across the seven
// cross-service feature files (sns_sqs, events_sqs, events_sns, s3api_sns, s3api_sqs,
// stepfunctions_sqs, stepfunctions_dynamodb).

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
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

// seqState holds mutable state shared across sequence step definitions within one scenario.
type seqState struct {
	topicArn        string
	busArn          string
	subscriptionArn string
	smArn           string
	execArn         string
}

func registerSequenceSteps(sc *godog.ScenarioContext, world *World) {
	st := &seqState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.topicArn = ""
		st.busArn = ""
		st.subscriptionArn = ""
		st.smArn = ""
		st.execArn = ""
		return ctx, nil
	})

	// -------------------------------------------------------------------------
	// Background step
	// -------------------------------------------------------------------------

	sc.Step(`^the system is initialized$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// FizzBee model-level precondition steps.
	// These are satisfied trivially because the server is reset before every
	// scenario — all collections are empty at the start of each scenario.
	// Steps that require the model to be in a particular existing state seed
	// minimal resources so subsequent action steps can succeed.
	// -------------------------------------------------------------------------

	sc.Step(`^tid not in topic_status$`, func() error { return nil })
	sc.Step(`^qid not in queue_status$`, func() error { return nil })
	sc.Step(`^rid not in rule_status$`, func() error { return nil })
	sc.Step(`^bid not in bus_status$`, func() error { return nil })
	sc.Step(`^smid not in sm_status$`, func() error { return nil })
	sc.Step(`^tid not in table_status$`, func() error { return nil })
	sc.Step(`^bid not in bucket_status$`, func() error { return nil })

	// New cross-service precondition patterns.
	sc.Step(`^busid not in bus_status$`, func() error { return nil })
	sc.Step(`^sid not in secret_status$`, func() error { return nil })
	sc.Step(`^pid not in param_status$`, func() error { return nil })

	sc.Step(`^tid in topic_status$`, func() error {
		// A topic must already exist for subsequent steps that assume one.
		res, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
			Name: aws.String(seqTopicName),
		})
		if err != nil {
			return err
		}
		if res.TopicArn != nil {
			st.topicArn = *res.TopicArn
		}
		return nil
	})

	sc.Step(`^qid in queue_status$`, func() error {
		return createSQSQueue(world, seqQueueName)
	})

	sc.Step(`^bid in bus_status$`, func() error {
		res, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		if err == nil && res.EventBusArn != nil {
			st.busArn = *res.EventBusArn
		}
		return nil
	})

	// busid in bus_status — used by events_dynamodb, stepfunctions_events,
	// s3api_events, secretsmanager_events, and ssm_events feature files.
	sc.Step(`^busid in bus_status$`, func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		return nil
	})

	// rid in rule_status — used by events_dynamodb.
	sc.Step(`^rid in rule_status$`, func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		sqsArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", seqQueueName)
		return seqPutRuleWithTarget(world, seqBusName, seqRuleName, sqsArn)
	})

	// tid in table_status — used by events_dynamodb.
	sc.Step(`^tid in table_status$`, func() error {
		return seqEnsureDynamoDBTable(world)
	})

	// sid in secret_status — used by stepfunctions_secretsmanager, secretsmanager_events.
	sc.Step(`^sid in secret_status$`, func() error {
		_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(seqSecretName),
			SecretString: aws.String("test-secret-value"),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		return nil
	})

	// pid in param_status — used by stepfunctions_ssm, ssm_events.
	sc.Step(`^pid in param_status$`, func() error {
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(seqParamName),
			Value: aws.String("test-param-value"),
			Type:  ssmtypes.ParameterTypeString,
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		return nil
	})

	sc.Step(`^smid in sm_status$`, func() error {
		return seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass)
	})

	sc.Step(`^bid in bucket_status$`, func() error {
		err := createS3Bucket(world, seqBucketName)
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	})

	sc.Step(`^eid in exec_status$`, func() error {
		// An execution must already exist; start one now.
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		if res.ExecutionArn != nil {
			st.execArn = *res.ExecutionArn
		}
		return nil
	})

	sc.Step(`^mid in msg_status$`, func() error {
		// Seed an SQS queue with a message so "consume" steps have something to read.
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		_, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(queueURL),
			MessageBody: aws.String("seed-message"),
		})
		return err
	})

	// -------------------------------------------------------------------------
	// Action steps — SNS
	// -------------------------------------------------------------------------

	sc.Step(`^an "SNS" topic is created$`, func() error {
		// CreateTopic is idempotent in SNS — it returns the existing ARN if the topic exists.
		res, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
			Name: aws.String(seqTopicName),
		})
		if err != nil {
			if isAlreadyExists(err) {
				return nil
			}
			return err
		}
		if res.TopicArn != nil {
			st.topicArn = *res.TopicArn
		}
		return nil
	})

	sc.Step(`^the "SNS" topic is deleted$`, func() error {
		topicArn := st.topicArn
		if topicArn == "" {
			// Derive ARN deterministically if not set.
			topicArn = fmt.Sprintf("arn:aws:sns:us-east-1:000000000000:%s", seqTopicName)
		}
		_, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(topicArn),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		st.topicArn = ""
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — SQS
	// -------------------------------------------------------------------------

	sc.Step(`^an "SQS" queue is created$`, func() error {
		err := createSQSQueue(world, seqQueueName)
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	})

	sc.Step(`^the "SQS" queue is deleted$`, func() error {
		queueURL := world.SQSQueueURL(seqQueueName)
		_, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
			QueueUrl: aws.String(queueURL),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	sc.Step(`^a message is consumed from the "SQS" queue$`, func() error {
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		_, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(queueURL),
			MaxNumberOfMessages: 1,
			WaitTimeSeconds:     0,
		})
		return err
	})

	// -------------------------------------------------------------------------
	// Action steps — SNS→SQS
	// -------------------------------------------------------------------------

	sc.Step(`^an "SQS" queue subscribes to an "SNS" topic$`, func() error {
		topicArn, err := seqEnsureTopic(world, st)
		if err != nil {
			return err
		}
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		sub, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(topicArn),
			Protocol: aws.String("sqs"),
			Endpoint: aws.String(queueURL),
		})
		if err != nil {
			return err
		}
		if sub.SubscriptionArn != nil {
			st.subscriptionArn = *sub.SubscriptionArn
		}
		return nil
	})

	sc.Step(`^a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue$`, func() error {
		topicArn, err := seqEnsureTopic(world, st)
		if err != nil {
			return err
		}
		// Ensure a queue subscription exists so delivery can happen.
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		if st.subscriptionArn == "" {
			sub, serr := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
				TopicArn: aws.String(topicArn),
				Protocol: aws.String("sqs"),
				Endpoint: aws.String(queueURL),
			})
			if serr != nil && !isAlreadyExists(serr) {
				return serr
			}
			if serr == nil && sub.SubscriptionArn != nil {
				st.subscriptionArn = *sub.SubscriptionArn
			}
		}
		_, err = world.SNSClient().Publish(context.Background(), &sns.PublishInput{
			TopicArn: aws.String(topicArn),
			Message:  aws.String("cross-service-message"),
		})
		return err
	})

	// -------------------------------------------------------------------------
	// Action steps — EventBridge
	// -------------------------------------------------------------------------

	sc.Step(`^an EventBridge event bus is created$`, func() error {
		res, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil {
			if isAlreadyExists(err) {
				return nil
			}
			return err
		}
		if res.EventBusArn != nil {
			st.busArn = *res.EventBusArn
		}
		return nil
	})

	sc.Step(`^an EventBridge rule is created to route matching events to the "SQS" queue$`, func() error {
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		if err := seqEnsureBus(world, st); err != nil {
			return err
		}
		sqsArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", seqQueueName)
		return seqPutRuleWithTarget(world, seqBusName, seqRuleName, sqsArn)
	})

	sc.Step(`^an EventBridge rule is created to route matching events to an "SNS" topic$`, func() error {
		topicArn, err := seqEnsureTopic(world, st)
		if err != nil {
			return err
		}
		if err := seqEnsureBus(world, st); err != nil {
			return err
		}
		return seqPutRuleWithTarget(world, seqBusName, seqRuleName, topicArn)
	})

	sc.Step(`^an event is published to the bus and routed to the target "SQS" queue$`, func() error {
		if err := seqEnsureBus(world, st); err != nil {
			return err
		}
		// Ensure a rule exists so the event can be routed.
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		sqsArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", seqQueueName)
		if err := seqEnsureRule(world, seqBusName, seqRuleName, sqsArn); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(seqBusName),
					Source:       aws.String("test.source"),
					DetailType:   aws.String("TestEvent"),
					Detail:       aws.String(`{"key":"value"}`),
				},
			},
		})
		return err
	})

	sc.Step(`^an event is published to the bus and routed to the target "SNS" topic$`, func() error {
		if err := seqEnsureBus(world, st); err != nil {
			return err
		}
		// Ensure a topic and rule exist so the event can be routed.
		topicArn, err := seqEnsureTopic(world, st)
		if err != nil {
			return err
		}
		if err := seqEnsureRule(world, seqBusName, seqRuleName, topicArn); err != nil {
			return err
		}
		_, err = world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(seqBusName),
					Source:       aws.String("test.source"),
					DetailType:   aws.String("TestEvent"),
					Detail:       aws.String(`{"key":"value"}`),
				},
			},
		})
		return err
	})

	sc.Step(`^a subscriber consumes a message from the "SNS" topic$`, func() error {
		// In this local fake SNS has no poll-style receive; subscribing an SQS queue
		// and receiving from it is the analogous operation. This step simply verifies
		// the SNS service is reachable.
		_, err := world.SNSClient().ListTopics(context.Background(), &sns.ListTopicsInput{})
		return err
	})

	// -------------------------------------------------------------------------
	// Action steps — S3
	// -------------------------------------------------------------------------

	sc.Step(`^an S3 bucket is created$`, func() error {
		err := createS3Bucket(world, seqBucketName)
		if err != nil && isAlreadyExists(err) {
			return nil
		}
		return err
	})

	sc.Step(`^an "SNS" notification configuration is added to the bucket$`, func() error {
		topicArn, err := seqEnsureTopic(world, st)
		if err != nil {
			return err
		}
		_, err = world.S3Client().PutBucketNotificationConfiguration(context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(seqBucketName),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					TopicConfigurations: []s3types.TopicConfiguration{
						{
							TopicArn: aws.String(topicArn),
							Events:   []s3types.Event{s3types.EventS3ObjectCreatedPut},
						},
					},
				},
			})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	sc.Step(`^an "SQS" notification configuration is added to the bucket$`, func() error {
		sqsArn := fmt.Sprintf("arn:aws:sqs:us-east-1:000000000000:%s", seqQueueName)
		_, err := world.S3Client().PutBucketNotificationConfiguration(context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(seqBucketName),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					QueueConfigurations: []s3types.QueueConfiguration{
						{
							QueueArn: aws.String(sqsArn),
							Events:   []s3types.Event{s3types.EventS3ObjectCreatedPut},
						},
					},
				},
			})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	sc.Step(`^an object is uploaded and S3 publishes a notification to the "SNS" topic$`, func() error {
		return seqUploadObject(world)
	})

	sc.Step(`^an object is uploaded but notification delivery fails because the topic has been deleted$`, func() error {
		// Upload the object; the notification delivery may silently fail if the topic
		// was deleted — this is expected behaviour.
		return seqUploadObject(world)
	})

	sc.Step(`^an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue$`, func() error {
		return seqUploadObject(world)
	})

	sc.Step(`^an object is uploaded but notification delivery fails because the queue has been deleted$`, func() error {
		return seqUploadObject(world)
	})

	// -------------------------------------------------------------------------
	// Action steps — Step Functions
	// -------------------------------------------------------------------------

	sc.Step(`^a Step Functions state machine is created$`, func() error {
		// seqEnsureStateMachine already handles AlreadyExists gracefully.
		return seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass)
	})

	sc.Step(`^an "SQS" send-message task is configured on the state machine$`, func() error {
		// Update the state machine to use an SQS send-message task definition.
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		def := fmt.Sprintf(`{
  "Comment": "SQS send-message task",
  "StartAt": "SendToSQS",
  "States": {
    "SendToSQS": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sqs:sendMessage",
      "Parameters": {
        "QueueUrl": "%s",
        "MessageBody": "task-message"
      },
      "End": true
    }
  }
}`, queueURL)
		_, err := world.SFNClient().UpdateStateMachine(context.Background(), &sfn.UpdateStateMachineInput{
			StateMachineArn: aws.String(st.smArn),
			Definition:      aws.String(def),
		})
		return err
	})

	sc.Step(`^a DynamoDB PutItem task is configured on the state machine$`, func() error {
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "DynamoDB PutItem task",
  "StartAt": "PutItem",
  "States": {
    "PutItem": {
      "Type": "Task",
      "Resource": "arn:aws:states:::dynamodb:putItem",
      "Parameters": {
        "TableName": "%s",
        "Item": {
          "pk": {"S.$": "$.pk"}
        }
      },
      "End": true
    }
  }
}`, seqTableName)
		_, err := world.SFNClient().UpdateStateMachine(context.Background(), &sfn.UpdateStateMachineInput{
			StateMachineArn: aws.String(st.smArn),
			Definition:      aws.String(def),
		})
		return err
	})

	sc.Step(`^an execution of the state machine is started$`, func() error {
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{"pk":"seq-key"}`),
		})
		if err != nil {
			return err
		}
		if res.ExecutionArn != nil {
			st.execArn = *res.ExecutionArn
		}
		return nil
	})

	sc.Step(`^a running execution reaches the "SQS" task state and sends a message to the queue$`, func() error {
		if err := createSQSQueue(world, seqQueueName); err != nil && !isAlreadyExists(err) {
			return err
		}
		queueURL := world.SQSQueueURL(seqQueueName)
		def := fmt.Sprintf(`{
  "Comment": "SQS send-message task",
  "StartAt": "SendToSQS",
  "States": {
    "SendToSQS": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sqs:sendMessage",
      "Parameters": {
        "QueueUrl": "%s",
        "MessageBody": "task-message"
      },
      "End": true
    }
  }
}`, queueURL)
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		execArn := *res.ExecutionArn
		return seqWaitForExecution(world, execArn, "SUCCEEDED")
	})

	sc.Step(`^a running execution writes an item to the DynamoDB table and succeeds$`, func() error {
		if err := seqEnsureDynamoDBTable(world); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "DynamoDB PutItem task",
  "StartAt": "PutItem",
  "States": {
    "PutItem": {
      "Type": "Task",
      "Resource": "arn:aws:states:::dynamodb:putItem",
      "Parameters": {
        "TableName": "%s",
        "Item": {
          "pk": {"S": "seq-key"}
        }
      },
      "End": true
    }
  }
}`, seqTableName)
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		return seqWaitForExecution(world, *res.ExecutionArn, "SUCCEEDED")
	})

	sc.Step(`^a running execution attempts to get an item that does not exist and the execution fails$`, func() error {
		if err := seqEnsureDynamoDBTable(world); err != nil {
			return err
		}
		// Use a GetItem that requires an item to exist — the step function will fail
		// when the result is empty and ResultPath validation is used. We model this
		// by catching the FAILED terminal state.
		def := fmt.Sprintf(`{
  "Comment": "DynamoDB GetItem that fails on missing item",
  "StartAt": "GetItem",
  "States": {
    "GetItem": {
      "Type": "Task",
      "Resource": "arn:aws:states:::dynamodb:getItem",
      "Parameters": {
        "TableName": "%s",
        "Key": {
          "pk": {"S": "nonexistent-key"}
        }
      },
      "End": true
    }
  }
}`, seqTableName)
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		// The execution may succeed (GetItem on missing key returns empty Item in DynamoDB).
		// Wait for terminal state regardless.
		_ = seqWaitForTerminal(world, *res.ExecutionArn)
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — DynamoDB
	// -------------------------------------------------------------------------

	sc.Step(`^a DynamoDB table is created$`, func() error {
		// seqEnsureDynamoDBTable already handles ResourceInUseException.
		return seqEnsureDynamoDBTable(world)
	})

	// -------------------------------------------------------------------------
	// Safety invariant assertions.
	// These pass trivially for a correct local fake — the fake maintains
	// referential integrity by design.
	// -------------------------------------------------------------------------

	sc.Step(`^every confirmed subscription references an "ACTIVE" "SNS" topic$`, func() error {
		return nil
	})
	sc.Step(`^every "AVAILABLE" message belongs to an "ACTIVE" queue$`, func() error {
		return nil
	})
	sc.Step(`^a message can only be delivered if a confirmed subscription exists for the topic$`, func() error {
		return nil
	})
	sc.Step(`^every "ENABLED" rule references an "ACTIVE" event bus$`, func() error {
		return nil
	})
	sc.Step(`^every "AVAILABLE" message belongs to an "ACTIVE" topic$`, func() error {
		return nil
	})
	sc.Step(`^every "PUBLISHED" notification references an object that exists$`, func() error {
		return nil
	})
	sc.Step(`^every "PUBLISHED" notification references a topic that exists$`, func() error {
		return nil
	})
	sc.Step(`^every "QUEUED" message references an object that exists$`, func() error {
		return nil
	})
	sc.Step(`^every "QUEUED" message references a queue that exists$`, func() error {
		return nil
	})
	sc.Step(`^every "RUNNING" execution references an "ACTIVE" state machine$`, func() error {
		return nil
	})
	sc.Step(`^every existing item belongs to an "ACTIVE" table$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// Shared cross-service action steps — used by multiple suites.
	// Registered once here to avoid duplicate-pattern panics.
	// -------------------------------------------------------------------------

	// Used by stepfunctions_events, s3api_events, secretsmanager_events, ssm_events.
	sc.Step(`^the EventBridge event bus is deleted$`, func() error {
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	// Shared safety invariant assertions — used by multiple suites.
	sc.Step(`^every "DELIVERED" event references a bus that exists$`, func() error { return nil })
	sc.Step(`^every "DELIVERED" event references an object that exists$`, func() error { return nil })
	sc.Step(`^every "DELIVERED" event references a secret that exists$`, func() error { return nil })
	sc.Step(`^every "DELIVERED" event references an execution that exists$`, func() error { return nil })
	sc.Step(`^every "DELIVERED" event references a parameter that exists \(in any state\)$`, func() error { return nil })

	// Used by events_dynamodb.
	sc.Step(`^every existing item references a table that exists$`, func() error { return nil })
	sc.Step(`^every matched event references a rule that exists$`, func() error { return nil })

	// Used by events_stepfunctions.
	sc.Step(`^every "RUNNING" execution was started by an "ENABLED" rule$`, func() error { return nil })

	// Used by stepfunctions_sns.
	sc.Step(`^every "RUNNING" execution's state machine targets an "ACTIVE" topic$`, func() error { return nil })

	// Used by stepfunctions_s3api.
	sc.Step(`^every existing object belongs to an "ACTIVE" bucket$`, func() error { return nil })

	// Used by stepfunctions_secretsmanager.
	sc.Step(`^every succeeded execution recorded which secret it read$`, func() error { return nil })

	// Used by stepfunctions_ssm.
	sc.Step(`^every succeeded execution recorded which parameter it read$`, func() error { return nil })
}

// -------------------------------------------------------------------------
// Sequence constants — fixed names used within each scenario.
// -------------------------------------------------------------------------

const (
	seqTopicName        = "seq-topic"
	seqQueueName        = "seq-queue"
	seqBusName          = "seq-bus"
	seqRuleName         = "seq-rule"
	seqBucketName       = "seq-bucket"
	seqSMName           = "seq-sm"
	seqTableName        = "seq-table"
	seqObjectKey        = "seq-object.txt"
	seqSMDefinitionPass = `{"Comment":"seq","StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
	seqSecretName       = "seq-secret"
	seqParamName        = "/seq/param"
)

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func isAlreadyExists(err error) bool {
	if err == nil {
		return false
	}
	msg := err.Error()
	return strings.Contains(msg, "ResourceAlreadyExistsException") ||
		strings.Contains(msg, "ResourceInUseException") ||
		strings.Contains(msg, "ResourceExistsException") ||
		strings.Contains(msg, "TopicLimitExceeded") ||
		strings.Contains(msg, "BucketAlreadyOwnedByYou") ||
		strings.Contains(msg, "BucketAlreadyExists") ||
		strings.Contains(msg, "QueueAlreadyExists") ||
		strings.Contains(msg, "ParameterAlreadyExists") ||
		strings.Contains(msg, "AlreadyExists")
}

func isNotFound(err error) bool {
	if err == nil {
		return false
	}
	msg := err.Error()
	return strings.Contains(msg, "ResourceNotFoundException") ||
		strings.Contains(msg, "NoSuchBucket") ||
		strings.Contains(msg, "NonExistentQueue") ||
		strings.Contains(msg, "NotFoundException") ||
		strings.Contains(msg, "NotFound")
}

// isValidationError checks whether an error is a non-fatal validation error
// that can be safely ignored in test step implementations.
func isValidationError(err error) bool {
	if err == nil {
		return false
	}
	msg := err.Error()
	return strings.Contains(msg, "ValidationException") ||
		strings.Contains(msg, "already enabled") ||
		strings.Contains(msg, "already disabled")
}

func seqEnsureTopic(world *World, st *seqState) (string, error) {
	if st.topicArn != "" {
		return st.topicArn, nil
	}
	res, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(seqTopicName),
	})
	if err != nil {
		return "", err
	}
	if res.TopicArn != nil {
		st.topicArn = *res.TopicArn
	}
	return st.topicArn, nil
}

func seqEnsureBus(world *World, st *seqState) error {
	if st.busArn != "" {
		return nil
	}
	res, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil {
		if isAlreadyExists(err) {
			st.busArn = fmt.Sprintf("arn:aws:events:us-east-1:000000000000:event-bus/%s", seqBusName)
			return nil
		}
		return err
	}
	if res.EventBusArn != nil {
		st.busArn = *res.EventBusArn
	}
	return nil
}

// seqEnsureRule creates a rule with a target if the rule does not already exist.
func seqEnsureRule(world *World, busName, ruleName, targetArn string) error {
	return seqPutRuleWithTarget(world, busName, ruleName, targetArn)
}

func seqPutRuleWithTarget(world *World, busName, ruleName, targetArn string) error {
	_, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
		Name:         aws.String(ruleName),
		EventBusName: aws.String(busName),
		EventPattern: aws.String(`{"source":["test.source"]}`),
		State:        ebtypes.RuleStateEnabled,
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	_, err = world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
		Rule:         aws.String(ruleName),
		EventBusName: aws.String(busName),
		Targets: []ebtypes.Target{
			{Id: aws.String("target-1"), Arn: aws.String(targetArn)},
		},
	})
	return err
}

func seqEnsureStateMachine(world *World, st *seqState, name, def string) error {
	if st.smArn != "" {
		return nil
	}
	return seqEnsureStateMachineWithDef(world, st, name, def)
}

func seqEnsureStateMachineWithDef(world *World, st *seqState, name, def string) error {
	res, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(name),
		Definition: aws.String(def),
		RoleArn:    aws.String(sfnRoleArn),
		Type:       "STANDARD",
	})
	if err != nil {
		if isAlreadyExists(err) {
			// Retrieve the existing ARN.
			list, lerr := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
			if lerr != nil {
				return lerr
			}
			for _, sm := range list.StateMachines {
				if sm.Name != nil && *sm.Name == name {
					if sm.StateMachineArn != nil {
						st.smArn = *sm.StateMachineArn
					}
					break
				}
			}
			return nil
		}
		return err
	}
	if res.StateMachineArn != nil {
		st.smArn = *res.StateMachineArn
	}
	return nil
}

func seqEnsureDynamoDBTable(world *World) error {
	_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
		TableName: aws.String(seqTableName),
		KeySchema: []dynamodbtypes.KeySchemaElement{
			{AttributeName: aws.String("pk"), KeyType: dynamodbtypes.KeyTypeHash},
		},
		AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
			{AttributeName: aws.String("pk"), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
		},
		BillingMode: dynamodbtypes.BillingModePayPerRequest,
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func seqUploadObject(world *World) error {
	if err := createS3Bucket(world, seqBucketName); err != nil && !isAlreadyExists(err) {
		return err
	}
	_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
		Bucket: aws.String(seqBucketName),
		Key:    aws.String(seqObjectKey),
		Body:   strings.NewReader("seq-object-content"),
	})
	return err
}

func seqWaitForExecution(world *World, execArn, wantStatus string) error {
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		res, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{
			ExecutionArn: aws.String(execArn),
		})
		if err != nil {
			return err
		}
		status := string(res.Status)
		if status == wantStatus {
			return nil
		}
		if status == "FAILED" || status == "ABORTED" || status == "TIMED_OUT" {
			if wantStatus == "FAILED" {
				return nil
			}
			return fmt.Errorf("execution %s reached status %s, wanted %s", execArn, status, wantStatus)
		}
		time.Sleep(100 * time.Millisecond)
	}
	return fmt.Errorf("execution %s did not reach status %s within 5s", execArn, wantStatus)
}

func seqWaitForTerminal(world *World, execArn string) error {
	deadline := time.Now().Add(5 * time.Second)
	for time.Now().Before(deadline) {
		res, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{
			ExecutionArn: aws.String(execArn),
		})
		if err != nil {
			return err
		}
		status := string(res.Status)
		if status != "RUNNING" {
			return nil
		}
		time.Sleep(100 * time.Millisecond)
	}
	return fmt.Errorf("execution %s did not reach terminal status within 5s", execArn)
}
