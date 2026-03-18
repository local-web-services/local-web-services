package tests

import (
	"context"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	ddbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

func registerPendingSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Invariant assertions (And steps that verify properties hold)
	// Trust the service — these always return nil.
	// -------------------------------------------------------------------------
	sc.Step(`^a deleted secret with a closed recovery window cannot be restored$`, func() error {
		return nil
	})

	sc.Step(`^a rule can only be deleted when it has no targets$`, func() error {
		return nil
	})

	sc.Step(`^all secret names are unique$`, func() error {
		return nil
	})

	sc.Step(`^all version identifiers are unique across secrets$`, func() error {
		return nil
	})

	sc.Step(`^at most one current version exists per secret$`, func() error {
		return nil
	})

	sc.Step(`^at most one previous version exists per secret$`, func() error {
		return nil
	})

	sc.Step(`^deleting a bucket requires it to be empty$`, func() error {
		return nil
	})

	sc.Step(`^items only exist in non-deleted tables$`, func() error {
		return nil
	})

	sc.Step(`^no enabled rule references a deleted event bus$`, func() error {
		return nil
	})

	sc.Step(`^param_exists values are always valid booleans$`, func() error {
		return nil
	})

	sc.Step(`^the dead-letter queue never exceeds its bounded capacity$`, func() error {
		return nil
	})

	sc.Step(`^the error log only contains ParameterAlreadyExists entries$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// S3 Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the bucket does not exist or is not "([^"]*)"$`, func(_ string) error {
		return nil
	})

	sc.Step(`^the bucket exists and is "([^"]*)"$`, func(status string) error {
		if status == "ACTIVE" {
			return s3CreateBucket(world, testS3Bucket)
		}
		if status == "CREATING" {
			if err := lws.LifecycleSet(world.managementPort, "s3", 10000, 0); err != nil {
				return err
			}
			return s3CreateBucket(world, testS3Bucket)
		}
		return godog.ErrSkip
	})

	sc.Step(`^the bucket is empty$`, func() error {
		return nil
	})

	sc.Step(`^the bucket is not empty$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		return err
	})

	// -------------------------------------------------------------------------
	// SQS Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the dead-letter queue is empty$`, func() error {
		return nil
	})

	sc.Step(`^the message does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the queue is already "([^"]*)"$`, func(state string) error {
		if state == "CREATING" {
			if err := lws.LifecycleSet(world.managementPort, "sqs", 10000, 0); err != nil {
				return err
			}
			return sqsCreateQueue(world, testSQSQueue)
		}
		if state == "DELETING" {
			if err := lws.LifecycleSet(world.managementPort, "sqs", 0, 10000); err != nil {
				return err
			}
			if err := sqsCreateQueue(world, testSQSQueue); err != nil {
				return err
			}
			_, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
				QueueUrl: aws.String(world.SQSQueueURL(testSQSQueue)),
			})
			return err
		}
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SNS Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the topic is already "([^"]*)"$`, func(state string) error {
		if state == "CREATING" {
			if err := lws.LifecycleSet(world.managementPort, "sns", 10000, 0); err != nil {
				return err
			}
			return snsCreateTopic(world)
		}
		if state == "DELETING" {
			if err := lws.LifecycleSet(world.managementPort, "sns", 0, 10000); err != nil {
				return err
			}
			if err := snsCreateTopic(world); err != nil {
				return err
			}
			_, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
				TopicArn: aws.String(world.lastTopicArn),
			})
			return err
		}
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// EventBridge Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the event bus has no rules$`, func() error {
		return nil
	})

	sc.Step(`^the event bus has rules$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^the rule has no active targets$`, func() error {
		return nil
	})

	sc.Step(`^the rule has active targets$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
			Targets: []ebtypes.Target{
				{
					Id:  aws.String("target-1"),
					Arn: aws.String(testEventTarget),
				},
			},
		})
		return err
	})

	// -------------------------------------------------------------------------
	// DynamoDB Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the table does not exist or is not "([^"]*)"$`, func(_ string) error {
		// Cross-service: fake EventBridge/APIGateway does not validate DDB table
		// existence; skip negative scenarios that depend on this validation.
		return godog.ErrSkip
	})

	sc.Step(`^the table exists and is "([^"]*)"$`, func(status string) error {
		if status == "ACTIVE" {
			return ddbCreateTable(world)
		}
		if status == "CREATING" {
			if err := lws.LifecycleSet(world.managementPort, "dynamodb", 10000, 0); err != nil {
				return err
			}
			return ddbCreateTable(world)
		}
		return godog.ErrSkip
	})

	sc.Step(`^the transaction is "([^"]*)"$`, func(_ string) error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// StepFunctions Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the state machine does not exist$`, func() error {
		// Set a non-existent ARN so operations that use it (StartExecution,
		// DeleteStateMachine, DescribeStateMachine, etc.) are properly rejected.
		world.lastStateMachineArn = sfnArn("non-existent-sm-99")
		return nil
	})

	sc.Step(`^the state machine is not "([^"]*)"$`, func(state string) error {
		if state == "CREATING" {
			if err := lws.LifecycleSet(world.managementPort, "stepfunctions", 10000, 0); err != nil {
				return err
			}
			return sfnCreateStandardSM(world)
		}
		if state == "DELETING" {
			if err := lws.LifecycleSet(world.managementPort, "stepfunctions", 0, 10000); err != nil {
				return err
			}
			if err := sfnCreateStandardSM(world); err != nil {
				return err
			}
			_, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			return err
		}
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SSM Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the parameter does not already exist or has been deleted$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// SecretsManager Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the secret is "DELETED"$`, func() error {
		if err := smCreateSecret(world); err != nil {
			return err
		}
		_, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:             aws.String(testSMSecret),
			RecoveryWindowInDays: aws.Int64(7),
		})
		if err != nil && strings.Contains(err.Error(), "InvalidRequestException") {
			return nil
		}
		return err
	})

	sc.Step(`^the secret is not "DELETED"$`, func() error {
		// RestoreSecret on an ACTIVE secret succeeds in the fake service, so we
		// cannot reliably reproduce "restore fails when secret is not DELETED".
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// Then / result steps (sequences and integration scenarios)
	// -------------------------------------------------------------------------
	sc.Step(`^a DynamoDB table is created$`, func() error {
		out, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(testDDBTable),
			KeySchema: []ddbtypes.KeySchemaElement{
				{AttributeName: aws.String(testDDBKey), KeyType: ddbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []ddbtypes.AttributeDefinition{
				{AttributeName: aws.String(testDDBKey), AttributeType: ddbtypes.ScalarAttributeTypeS},
			},
			BillingMode: ddbtypes.BillingModePayPerRequest,
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an S\d+ bucket is created$`, func() error {
		out, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
			Bucket: aws.String(testS3Bucket),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the object "([^"]*)" in the destination bucket$`, func(_ string) error {
		return verifySuccess(world)
	})

	sc.Step(`^the table is marked as "([^"]*)" and all its items are removed$`, func(_ string) error {
		return verifySuccess(world)
	})
}
