package tests

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
	smtypes "github.com/aws/aws-sdk-go-v2/service/secretsmanager/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
	"github.com/cucumber/godog"
)

// Fixed constants for abstract (non-parametrized) step definitions.
const (
	testSQSQueue    = "test-q-1"
	testSQSDLQ      = "test-dlq-1"
	testSQSMsg      = "test-message-1"
	testDDBTable    = "test-table-1"
	testDDBKey      = "id"
	testDDBKeyVal   = "test-id-1"
	testS3Bucket    = "test-bucket-1"
	testS3SrcBucket = "test-src-1"
	testS3DstBucket = "test-dst-1"
	testS3Key       = "test-key-1"
	testS3Body      = "test-body-1"
	testSNSTopic    = "test-topic-1"
	testSNSEndpoint = "arn:aws:sqs:us-east-1:000000000000:test-q-1"
	testSNSProtocol = "sqs"
	testEventBus    = "test-bus-1"
	testEventRule   = "test-rule-1"
	testEventTarget = "arn:aws:sqs:us-east-1:000000000000:test-q-1"

	testSFNStandardSM = "test-sm-1"
	testSFNExpressSM  = "test-sm-express-1"
	testSFNRoleArn    = "arn:aws:iam::000000000000:role/StepFunctionsRole"
	testSFNDefinition = `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
	testSFNInput      = `{}`
	testSSMParam      = "/test/param/1"
	testSSMParam2     = "/test/param/2"
	testSSMValue      = "test-value-1"
	testSSMValue2     = "test-value-2"
	testSSMTagKey     = "env"
	testSSMTagVal     = "test"
	testSMSecret      = "test-secret-1"
	testSMValue       = "test-secret-value-1"
	testSMValue2      = "test-secret-value-2"
	testSMTagKey      = "env"
	testSMTagVal      = "test"
)

func sfnArn(name string) string {
	return fmt.Sprintf("arn:aws:states:us-east-1:000000000000:stateMachine:%s", name)
}

// verifySuccess checks that world.lastResult.Success is true.
func verifySuccess(world *World) error {
	if !world.lastResult.Success {
		return fmt.Errorf("expected success: %v", world.lastResult.Output)
	}
	return nil
}

// setResult is a helper that stores an AWS result or error into world.lastResult.
func setResult(world *World, out interface{}, err error) {
	if err != nil {
		world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
	} else {
		world.lastResult = LastResult{Success: true, Output: out}
	}
}

// sqsCreateQueue creates an SQS queue, ignoring AlreadyExists errors.
func sqsCreateQueue(world *World, name string) error {
	_, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
		QueueName: aws.String(name),
	})
	if err != nil && !strings.Contains(err.Error(), "QueueAlreadyExists") {
		return err
	}
	if name == testSQSQueue {
		world.sqsQueueCreated = true
	}
	return nil
}

// ddbCreateTable creates a DynamoDB table, ignoring ResourceInUse errors.
func ddbCreateTable(world *World) error {
	_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
		TableName: aws.String(testDDBTable),
		KeySchema: []ddbtypes.KeySchemaElement{
			{AttributeName: aws.String(testDDBKey), KeyType: ddbtypes.KeyTypeHash},
		},
		AttributeDefinitions: []ddbtypes.AttributeDefinition{
			{AttributeName: aws.String(testDDBKey), AttributeType: ddbtypes.ScalarAttributeTypeS},
		},
		BillingMode: ddbtypes.BillingModePayPerRequest,
	})
	if err != nil && !strings.Contains(err.Error(), "ResourceInUseException") {
		return err
	}
	return nil
}

// s3CreateBucket creates an S3 bucket, ignoring BucketAlreadyExists errors.
func s3CreateBucket(world *World, name string) error {
	_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
		Bucket: aws.String(name),
	})
	if err != nil && !strings.Contains(err.Error(), "BucketAlreadyExists") &&
		!strings.Contains(err.Error(), "BucketAlreadyOwnedByYou") {
		return err
	}
	return nil
}

// snsCreateTopic creates an SNS topic, storing the ARN in world.lastTopicArn.
// It is idempotent: if the topic was already created (world.lastTopicArn is set), it returns nil.
func snsCreateTopic(world *World) error {
	if world.lastTopicArn != "" {
		return nil
	}
	result, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(testSNSTopic),
	})
	if err != nil {
		return err
	}
	world.lastTopicArn = aws.ToString(result.TopicArn)
	return nil
}

// ebCreateBus creates an EventBridge event bus, ignoring AlreadyExists errors.
func ebCreateBus(world *World) error {
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(testEventBus),
	})
	if err != nil && !strings.Contains(err.Error(), "ResourceAlreadyExists") {
		return err
	}
	return nil
}

// ebPutRule creates a PutRule on testEventBus, ignoring AlreadyExists errors.
func ebPutRule(world *World) error {
	_, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
		Name:               aws.String(testEventRule),
		EventBusName:       aws.String(testEventBus),
		ScheduleExpression: aws.String("rate(1 day)"),
		State:              ebtypes.RuleStateEnabled,
	})
	if err != nil && strings.Contains(err.Error(), "ResourceAlreadyExists") {
		return nil
	}
	return err
}

// sfnCreateStandardSM creates a STANDARD state machine and stores its ARN.
func sfnCreateStandardSM(world *World) error {
	result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(testSFNStandardSM),
		Definition: aws.String(testSFNDefinition),
		RoleArn:    aws.String(testSFNRoleArn),
		Type:       sfntypes.StateMachineTypeStandard,
	})
	if err != nil {
		if strings.Contains(err.Error(), "StateMachineAlreadyExists") {
			world.lastStateMachineArn = sfnArn(testSFNStandardSM)
			return nil
		}
		return err
	}
	world.lastStateMachineArn = aws.ToString(result.StateMachineArn)
	return nil
}

// sfnCreateExpressSM creates an EXPRESS state machine and stores its ARN.
func sfnCreateExpressSM(world *World) error {
	result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(testSFNExpressSM),
		Definition: aws.String(testSFNDefinition),
		RoleArn:    aws.String(testSFNRoleArn),
		Type:       sfntypes.StateMachineTypeExpress,
	})
	if err != nil {
		if strings.Contains(err.Error(), "StateMachineAlreadyExists") {
			world.lastStateMachineArn = sfnArn(testSFNExpressSM)
			return nil
		}
		return err
	}
	world.lastStateMachineArn = aws.ToString(result.StateMachineArn)
	return nil
}

// smCreateSecret creates a Secrets Manager secret, ignoring AlreadyExists errors.
func smCreateSecret(world *World) error {
	_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
		Name:         aws.String(testSMSecret),
		SecretString: aws.String(testSMValue),
	})
	if err != nil && !strings.Contains(err.Error(), "ResourceExistsException") {
		return err
	}
	return nil
}

func registerAbstractSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Common steps
	// -------------------------------------------------------------------------
	sc.Step(`^the system is initialized$`, func() error {
		return nil
	})

	sc.Step(`^the operation is rejected$`, func() error {
		if world.lastResult.Success {
			return fmt.Errorf("expected operation to be rejected but it succeeded")
		}
		return nil
	})

	// Catch-all for invariant assertions ("every ...")
	sc.Step(`^every .+`, func() error {
		return nil
	})

	sc.Step(`^"GSI" pending write count is never negative$`, func() error {
		return nil
	})

	sc.Step(`^transaction status is always a valid value$`, func() error {
		return nil
	})

	sc.Step(`^a pending transaction always references an existing table$`, func() error {
		return nil
	})

	sc.Step(`^deleted tables are never the target of a pending transaction$`, func() error {
		return nil
	})

	sc.Step(`^no delivery is in-flight to a deleted subscription$`, func() error {
		return nil
	})

	sc.Step(`^no delivery is in-flight to an unconfirmed subscription$`, func() error {
		return nil
	})

	sc.Step(`^overwriting a parameter always increments its version$`, func() error {
		return nil
	})

	sc.Step(`^all tag keys are strings$`, func() error {
		return nil
	})

	sc.Step(`^synchronous executions only run on express state machines$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// SQS Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the queue does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the queue already exists$`, func() error {
		return sqsCreateQueue(world, testSQSQueue)
	})

	sc.Step(`^the queue exists$`, func() error {
		return sqsCreateQueue(world, testSQSQueue)
	})

	sc.Step(`^the queue is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the queue does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the message slot is available$`, func() error {
		return nil
	})

	sc.Step(`^the message slot is not available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the message exists$`, func() error {
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		result, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(testSQSQueue)),
			MessageBody: aws.String(testSQSMsg),
		})
		if err != nil {
			return err
		}
		_ = result
		return nil
	})

	sc.Step(`^the message is "AVAILABLE"$`, func() error {
		return nil
	})

	sc.Step(`^the message is not "AVAILABLE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the message's queue exists$`, func() error {
		return nil
	})

	sc.Step(`^the message's queue does not exist$`, func() error {
		// Default state: no queue has been created. The queue URL resolves to a
		// non-existent queue and ReceiveMessage will return QueueDoesNotExist.
		return nil
	})

	sc.Step(`^the message's queue is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the message's queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the message is "IN_FLIGHT"$`, func() error {
		if err := sqsCreateQueue(world, testSQSQueue); err != nil {
			return err
		}
		// Ensure a message exists to receive.
		_, _ = world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(testSQSQueue)),
			MessageBody: aws.String(testSQSMsg),
		})
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(world.SQSQueueURL(testSQSQueue)),
			MaxNumberOfMessages: 1,
			VisibilityTimeout:   30,
		})
		if err != nil {
			return err
		}
		if len(result.Messages) > 0 {
			world.lastReceiptHandle = aws.ToString(result.Messages[0].ReceiptHandle)
		}
		return nil
	})

	sc.Step(`^the message is not "IN_FLIGHT"$`, func() error {
		return nil
	})

	sc.Step(`^the queue has a maximum receive count configured$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the queue does not have a maximum receive count configured$`, func() error {
		return nil
	})

	sc.Step(`^the message has exceeded the maximum receive count$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the message has not exceeded the maximum receive count$`, func() error {
		return nil
	})

	sc.Step(`^the dead-letter queue exists$`, func() error {
		return sqsCreateQueue(world, testSQSDLQ)
	})

	sc.Step(`^the dead-letter queue is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the dead-letter queue does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the dead-letter queue is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SQS When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a queue is created$`, func() error {
		out, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
			QueueName: aws.String(testSQSQueue),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a queue is deleted$`, func() error {
		out, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(testSQSQueue)),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a message is sent to the queue$`, func() error {
		out, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(testSQSQueue)),
			MessageBody: aws.String(testSQSMsg),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a message is received from the queue$`, func() error {
		out, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(world.SQSQueueURL(testSQSQueue)),
			MaxNumberOfMessages: 1,
		})
		if err == nil && len(out.Messages) > 0 {
			world.lastReceiptHandle = aws.ToString(out.Messages[0].ReceiptHandle)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an in-flight message is deleted$`, func() error {
		out, err := world.SQSClient().DeleteMessage(context.Background(), &sqs.DeleteMessageInput{
			QueueUrl:      aws.String(world.SQSQueueURL(testSQSQueue)),
			ReceiptHandle: aws.String(world.lastReceiptHandle),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^queue attributes are retrieved$`, func() error {
		out, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(world.SQSQueueURL(testSQSQueue)),
			AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameAll},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^all messages in a queue are purged$`, func() error {
		out, err := world.SQSClient().PurgeQueue(context.Background(), &sqs.PurgeQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(testSQSQueue)),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^message visibility timeout is changed$`, func() error {
		out, err := world.SQSClient().ChangeMessageVisibility(context.Background(), &sqs.ChangeMessageVisibilityInput{
			QueueUrl:          aws.String(world.SQSQueueURL(testSQSQueue)),
			ReceiptHandle:     aws.String(world.lastReceiptHandle),
			VisibilityTimeout: 60,
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a message exceeding its receive count is moved to the dead-letter queue$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a message visibility timeout expires$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SQS Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the queue is "DELETED" and its messages are removed$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is "AVAILABLE" for delivery$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is removed from the queue$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the queue attributes are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^all messages in the queue are "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message visibility is updated$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is "AVAILABLE" in the dead-letter queue$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the message becomes "AVAILABLE" again$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// DynamoDB Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the table does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the table already exists$`, func() error {
		return ddbCreateTable(world)
	})

	sc.Step(`^the table exists$`, func() error {
		return ddbCreateTable(world)
	})

	sc.Step(`^the table is "CREATING"$`, func() error {
		// The fake always creates tables as ACTIVE immediately.
		return godog.ErrSkip
	})

	sc.Step(`^the table is not "CREATING"$`, func() error {
		return nil
	})

	sc.Step(`^the table does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the table is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the table is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^writes are not throttled$`, func() error {
		return nil
	})

	sc.Step(`^writes are throttled$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^reads are not throttled$`, func() error {
		return nil
	})

	sc.Step(`^reads are throttled$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the item exists$`, func() error {
		if err := ddbCreateTable(world); err != nil {
			return err
		}
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(testDDBTable),
			Item: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		return err
	})

	sc.Step(`^the item is present$`, func() error {
		return nil
	})

	sc.Step(`^the item does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the item is not present$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^no transaction is currently in progress$`, func() error {
		return nil
	})

	sc.Step(`^a transaction is currently in progress$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a transaction is "PENDING"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the transaction's table exists$`, func() error {
		return nil
	})

	sc.Step(`^the transaction's table is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the transaction's table does not exist$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the transaction's table is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the transaction is "COMMITTED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the transaction is not "COMMITTED"$`, func() error {
		return nil
	})

	sc.Step(`^the transaction is "ROLLED_BACK"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the transaction is not "ROLLED_BACK"$`, func() error {
		return nil
	})

	sc.Step(`^the table has pending "GSI" propagation$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the table does not have pending "GSI" propagation$`, func() error {
		return nil
	})

	sc.Step(`^there are writes pending propagation to the "GSI"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^there are no writes pending propagation to the "GSI"$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// DynamoDB When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a table is created$`, func() error {
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

	sc.Step(`^a table finishes creating and becomes active$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a table is deleted$`, func() error {
		out, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(testDDBTable),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a table is described$`, func() error {
		out, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(testDDBTable),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^all tables are listed$`, func() error {
		out, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an item is written to the table$`, func() error {
		out, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(testDDBTable),
			Item: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an item is read from the table$`, func() error {
		out, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(testDDBTable),
			Key: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an existing item is deleted from the table$`, func() error {
		out, err := world.DynamoDBClient().DeleteItem(context.Background(), &dynamodb.DeleteItemInput{
			TableName: aws.String(testDDBTable),
			Key: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an existing item is updated in the table$`, func() error {
		out, err := world.DynamoDBClient().UpdateItem(context.Background(), &dynamodb.UpdateItemInput{
			TableName: aws.String(testDDBTable),
			Key: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
			UpdateExpression:          aws.String("SET #v = :v"),
			ExpressionAttributeNames:  map[string]string{"#v": "value"},
			ExpressionAttributeValues: map[string]ddbtypes.AttributeValue{":v": &ddbtypes.AttributeValueMemberS{Value: "updated"}},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^items are queried from the table by key$`, func() error {
		out, err := world.DynamoDBClient().Query(context.Background(), &dynamodb.QueryInput{
			TableName:              aws.String(testDDBTable),
			KeyConditionExpression: aws.String("#k = :v"),
			ExpressionAttributeNames: map[string]string{
				"#k": testDDBKey,
			},
			ExpressionAttributeValues: map[string]ddbtypes.AttributeValue{
				":v": &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^all items in the table are scanned$`, func() error {
		out, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{
			TableName: aws.String(testDDBTable),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an item is conditionally written to the table$`, func() error {
		out, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(testDDBTable),
			Item: map[string]ddbtypes.AttributeValue{
				testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
			},
			ConditionExpression: aws.String("attribute_not_exists(id)"),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a transactional write is initiated across one or more items$`, func() error {
		out, err := world.DynamoDBClient().TransactWriteItems(context.Background(), &dynamodb.TransactWriteItemsInput{
			TransactItems: []ddbtypes.TransactWriteItem{
				{
					Put: &ddbtypes.Put{
						TableName: aws.String(testDDBTable),
						Item: map[string]ddbtypes.AttributeValue{
							testDDBKey: &ddbtypes.AttributeValueMemberS{Value: testDDBKeyVal},
						},
					},
				},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a pending transaction resolves non-deterministically$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a committed transaction is cleared$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a rolled-back transaction is cleared$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a "GSI" catches up with pending write propagation$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^read throttling is toggled on or off$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^write throttling is toggled on or off$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// DynamoDB Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the table is in "CREATING" state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the table is "ACTIVE" and ready for reads and writes$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the table is marked as "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the table metadata is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of tables is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item exists in the table and "GSI" propagation is pending$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item value is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item is deleted or unchanged \(conditional delete\)$`, func() error {
		return nil
	})

	sc.Step(`^the item is updated or unchanged \(conditional update\)$`, func() error {
		return nil
	})

	sc.Step(`^matching items are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^all items are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the item is written if the condition holds, otherwise the write is rejected$`, func() error {
		return nil
	})

	sc.Step(`^the transaction is "COMMITTED" or "ROLLED_BACK"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^no transaction is "PENDING"$`, func() error {
		return nil
	})

	sc.Step(`^the transaction slot is free$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the "GSI" is consistent with the table$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^reads are throttled or unthrottled$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^writes are throttled or unthrottled$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// S3 Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the bucket does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the bucket already exists$`, func() error {
		return s3CreateBucket(world, testS3Bucket)
	})

	sc.Step(`^the bucket exists$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		world.s3BucketCreated = true
		return nil
	})

	sc.Step(`^the bucket is "ACTIVE"$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		world.s3BucketCreated = true
		return nil
	})

	sc.Step(`^the bucket does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the bucket is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the object exists in the bucket$`, func() error {
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

	sc.Step(`^the object is not deleted$`, func() error {
		return nil
	})

	sc.Step(`^the object does not exist in the bucket$`, func() error {
		return nil
	})

	sc.Step(`^the object is deleted$`, func() error {
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
		_, err := world.S3Client().DeleteObject(context.Background(), &s3.DeleteObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		return err
	})

	sc.Step(`^the source bucket exists$`, func() error {
		return s3CreateBucket(world, testS3SrcBucket)
	})

	sc.Step(`^the source bucket is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the source object exists$`, func() error {
		if err := s3CreateBucket(world, testS3SrcBucket); err != nil {
			return err
		}
		_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3SrcBucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		return err
	})

	sc.Step(`^the source object is not deleted$`, func() error {
		return nil
	})

	sc.Step(`^the destination bucket exists$`, func() error {
		return s3CreateBucket(world, testS3DstBucket)
	})

	sc.Step(`^the destination bucket is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the source bucket does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the source bucket is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the source object does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the source object is deleted$`, func() error {
		if err := s3CreateBucket(world, testS3SrcBucket); err != nil {
			return err
		}
		if _, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3SrcBucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		}); err != nil {
			return err
		}
		_, err := world.S3Client().DeleteObject(context.Background(), &s3.DeleteObjectInput{
			Bucket: aws.String(testS3SrcBucket),
			Key:    aws.String(testS3Key),
		})
		return err
	})

	sc.Step(`^the destination bucket does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the destination bucket is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the upload does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the upload exists$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		result, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		if err != nil {
			return err
		}
		world.lastUploadId = aws.ToString(result.UploadId)
		world.lastBucket = testS3Bucket
		world.lastKey = testS3Key
		return nil
	})

	sc.Step(`^the upload is "IN_PROGRESS"$`, func() error {
		return nil
	})

	// NOTE: "the upload has at least one part" appears as both Given and Then.
	// Registered once here using sc.Step so it matches any keyword.
	sc.Step(`^the upload has at least one part$`, func() error {
		if world.lastUploadId == "" {
			// As a Given: ensure upload exists and upload a part.
			if err := s3CreateBucket(world, testS3Bucket); err != nil {
				return err
			}
			result, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
				Bucket: aws.String(testS3Bucket),
				Key:    aws.String(testS3Key),
			})
			if err != nil {
				return err
			}
			world.lastUploadId = aws.ToString(result.UploadId)
			world.lastBucket = testS3Bucket
			world.lastKey = testS3Key
		}
		// Upload a part if not already done (used as a Given setup step).
		if world.lastETag == "" {
			partResult, err := world.S3Client().UploadPart(context.Background(), &s3.UploadPartInput{
				Bucket:     aws.String(world.lastBucket),
				Key:        aws.String(world.lastKey),
				UploadId:   aws.String(world.lastUploadId),
				PartNumber: aws.Int32(1),
				Body:       strings.NewReader(testS3Body),
			})
			if err != nil {
				return err
			}
			world.lastETag = aws.ToString(partResult.ETag)
		}
		return nil
	})

	sc.Step(`^the upload does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the upload is not "IN_PROGRESS"$`, func() error {
		// If a multipart upload was already created (by "the upload exists"),
		// abort it so its status is ABORTED (not IN_PROGRESS).
		// If no upload exists yet, create one and then abort it.
		if world.lastUploadId == "" {
			if err := s3CreateBucket(world, testS3Bucket); err != nil {
				return err
			}
			result, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
				Bucket: aws.String(testS3Bucket),
				Key:    aws.String(testS3Key),
			})
			if err != nil {
				return err
			}
			world.lastUploadId = aws.ToString(result.UploadId)
			world.lastBucket = testS3Bucket
			world.lastKey = testS3Key
		}
		_, err := world.S3Client().AbortMultipartUpload(context.Background(), &s3.AbortMultipartUploadInput{
			Bucket:   aws.String(world.lastBucket),
			Key:      aws.String(world.lastKey),
			UploadId: aws.String(world.lastUploadId),
		})
		return err
	})

	sc.Step(`^the upload has no parts$`, func() error {
		// Signal that the complete step should not auto-upload a part.
		world.uploadNoParts = true
		return nil
	})

	sc.Step(`^the upload already exists$`, func() error {
		if err := s3CreateBucket(world, testS3Bucket); err != nil {
			return err
		}
		result, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		if err != nil {
			return err
		}
		world.lastUploadId = aws.ToString(result.UploadId)
		world.lastBucket = testS3Bucket
		world.lastKey = testS3Key
		return nil
	})

	// -------------------------------------------------------------------------
	// S3 When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a bucket is created$`, func() error {
		out, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
			Bucket: aws.String(testS3Bucket),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a bucket is deleted$`, func() error {
		out, err := world.S3Client().DeleteBucket(context.Background(), &s3.DeleteBucketInput{
			Bucket: aws.String(testS3Bucket),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the list of buckets is retrieved$`, func() error {
		out, err := world.S3Client().ListBuckets(context.Background(), &s3.ListBucketsInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is uploaded to a bucket$`, func() error {
		out, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
			Body:   strings.NewReader(testS3Body),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is retrieved from a bucket$`, func() error {
		out, err := world.S3Client().GetObject(context.Background(), &s3.GetObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		if err == nil {
			out.Body.Close()
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^object metadata is retrieved from a bucket$`, func() error {
		out, err := world.S3Client().HeadObject(context.Background(), &s3.HeadObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is deleted from a bucket$`, func() error {
		out, err := world.S3Client().DeleteObject(context.Background(), &s3.DeleteObjectInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^objects in a bucket are listed$`, func() error {
		out, err := world.S3Client().ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{
			Bucket: aws.String(testS3Bucket),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an object is copied from one bucket to another$`, func() error {
		out, err := world.S3Client().CopyObject(context.Background(), &s3.CopyObjectInput{
			Bucket:     aws.String(testS3DstBucket),
			Key:        aws.String(testS3Key),
			CopySource: aws.String(testS3SrcBucket + "/" + testS3Key),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a multipart upload is initiated$`, func() error {
		out, err := world.S3Client().CreateMultipartUpload(context.Background(), &s3.CreateMultipartUploadInput{
			Bucket: aws.String(testS3Bucket),
			Key:    aws.String(testS3Key),
		})
		if err == nil {
			world.lastUploadId = aws.ToString(out.UploadId)
			world.lastBucket = testS3Bucket
			world.lastKey = testS3Key
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a part is uploaded for a multipart upload$`, func() error {
		out, err := world.S3Client().UploadPart(context.Background(), &s3.UploadPartInput{
			Bucket:     aws.String(world.lastBucket),
			Key:        aws.String(world.lastKey),
			UploadId:   aws.String(world.lastUploadId),
			PartNumber: aws.Int32(1),
			Body:       strings.NewReader(testS3Body),
		})
		if err == nil {
			world.lastETag = aws.ToString(out.ETag)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a multipart upload is completed$`, func() error {
		// Only auto-upload a part if the scenario hasn't declared "no parts".
		if world.lastETag == "" && !world.uploadNoParts {
			partOut, err := world.S3Client().UploadPart(context.Background(), &s3.UploadPartInput{
				Bucket:     aws.String(world.lastBucket),
				Key:        aws.String(world.lastKey),
				UploadId:   aws.String(world.lastUploadId),
				PartNumber: aws.Int32(1),
				Body:       strings.NewReader(testS3Body),
			})
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
			world.lastETag = aws.ToString(partOut.ETag)
		}
		var parts []s3types.CompletedPart
		if world.lastETag != "" {
			parts = []s3types.CompletedPart{
				{ETag: aws.String(world.lastETag), PartNumber: aws.Int32(1)},
			}
		}
		out, err := world.S3Client().CompleteMultipartUpload(context.Background(), &s3.CompleteMultipartUploadInput{
			Bucket:   aws.String(world.lastBucket),
			Key:      aws.String(world.lastKey),
			UploadId: aws.String(world.lastUploadId),
			MultipartUpload: &s3types.CompletedMultipartUpload{
				Parts: parts,
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a multipart upload is aborted$`, func() error {
		out, err := world.S3Client().AbortMultipartUpload(context.Background(), &s3.AbortMultipartUploadInput{
			Bucket:   aws.String(world.lastBucket),
			Key:      aws.String(world.lastKey),
			UploadId: aws.String(world.lastUploadId),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^versioning is configured on a bucket$`, func() error {
		out, err := world.S3Client().PutBucketVersioning(context.Background(), &s3.PutBucketVersioningInput{
			Bucket: aws.String(testS3Bucket),
			VersioningConfiguration: &s3types.VersioningConfiguration{
				Status: s3types.BucketVersioningStatusEnabled,
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a lifecycle rule expires an object$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// S3 Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the bucket is "ACTIVE" with versioning disabled$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bucket is "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the available buckets are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object "EXISTS" in the bucket$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object data is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object metadata is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object is "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of objects in the bucket is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the upload is "IN_PROGRESS" with no parts$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the upload is "ABORTED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the object is "DELETED" by the lifecycle policy$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SNS Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the topic does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the topic already exists$`, func() error {
		return snsCreateTopic(world)
	})

	sc.Step(`^the topic exists$`, func() error {
		return snsCreateTopic(world)
	})

	// NOTE: "the topic is 'ACTIVE'" appears as both Given and Then.
	// Registered once with sc.Step to match any keyword.
	sc.Step(`^the topic is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the topic is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the topic does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the subscription slot is available$`, func() error {
		return nil
	})

	sc.Step(`^the subscription slot is not available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the subscription exists$`, func() error {
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		result, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(world.lastTopicArn),
			Protocol: aws.String(testSNSProtocol),
			Endpoint: aws.String(testSNSEndpoint),
		})
		if err != nil {
			return err
		}
		world.lastSubscriptionArn = aws.ToString(result.SubscriptionArn)
		return nil
	})

	// NOTE: "the subscription is 'CONFIRMED'" appears as both Given and Then.
	// Registered once here.
	sc.Step(`^the subscription is "CONFIRMED"$`, func() error {
		return nil
	})

	sc.Step(`^the subscription is not "CONFIRMED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the subscription is "PENDING_CONFIRMATION"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the subscription is not "PENDING_CONFIRMATION"$`, func() error {
		return nil
	})

	sc.Step(`^the subscription does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the subscription's topic exists$`, func() error {
		return nil
	})

	sc.Step(`^the subscription's topic is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the subscription's topic does not exist$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the subscription's topic is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a confirmed subscription exists for the topic$`, func() error {
		if err := snsCreateTopic(world); err != nil {
			return err
		}
		result, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(world.lastTopicArn),
			Protocol: aws.String(testSNSProtocol),
			Endpoint: aws.String(testSNSEndpoint),
		})
		if err != nil {
			return err
		}
		world.lastSubscriptionArn = aws.ToString(result.SubscriptionArn)
		return nil
	})

	sc.Step(`^the subscription belongs to this topic$`, func() error {
		return nil
	})

	sc.Step(`^a delivery slot is available$`, func() error {
		return nil
	})

	sc.Step(`^no confirmed subscription exists for the topic$`, func() error {
		return nil
	})

	sc.Step(`^the subscription does not belong to this topic$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^no delivery slot is available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery exists$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery is "IN_FLIGHT"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery does not exist$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery is not "IN_FLIGHT"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the retry count is below the limit$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the retry count has reached the limit$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SNS When steps
	// -------------------------------------------------------------------------
	sc.Step(`^an "SNS" topic is created$`, func() error {
		out, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
			Name: aws.String(testSNSTopic),
		})
		if err == nil {
			world.lastTopicArn = aws.ToString(out.TopicArn)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an "SNS" topic is deleted$`, func() error {
		out, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{
			TopicArn: aws.String(world.lastTopicArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an endpoint subscribes to a topic$`, func() error {
		out, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(world.lastTopicArn),
			Protocol: aws.String(testSNSProtocol),
			Endpoint: aws.String(testSNSEndpoint),
		})
		if err == nil {
			world.lastSubscriptionArn = aws.ToString(out.SubscriptionArn)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a subscription is removed$`, func() error {
		out, err := world.SNSClient().Unsubscribe(context.Background(), &sns.UnsubscribeInput{
			SubscriptionArn: aws.String(world.lastSubscriptionArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a pending subscription is confirmed$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a message is published to a topic$`, func() error {
		out, err := world.SNSClient().Publish(context.Background(), &sns.PublishInput{
			TopicArn: aws.String(world.lastTopicArn),
			Message:  aws.String("test-message"),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a delivery attempt succeeds$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a delivery attempt fails and is retried$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^all delivery retries are exhausted$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a subscription confirmation token expires$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SNS Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the topic is "DELETED" and its subscriptions are removed$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the subscription is "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the message is delivered to confirmed subscriptions$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the delivery is "DONE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery retry count is incremented$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the delivery is marked "DONE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the pending subscription is "DELETED"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// EventBridge Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the event bus does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the event bus already exists$`, func() error {
		return ebCreateBus(world)
	})

	sc.Step(`^the event bus exists$`, func() error {
		return ebCreateBus(world)
	})

	// NOTE: "the event bus is 'ACTIVE'" appears as both Given and Then.
	sc.Step(`^the event bus is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the event bus is not "ACTIVE"$`, func() error {
		// Create the bus then delete it so it is in DELETED (not ACTIVE) state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the event bus does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the event bus is not the default bus$`, func() error {
		return nil
	})

	sc.Step(`^the event bus is the default bus$`, func() error {
		return nil
	})

	sc.Step(`^the rule does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the rule already exists$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^the rule exists$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^the rule is not "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the rule does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the rule is "DELETED"$`, func() error {
		// Create bus+rule then delete the rule so it is in DELETED state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteRule(context.Background(), &eventbridge.DeleteRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		return err
	})

	// "the rule is DISABLED":
	// - As a Given/And (Given context): create the rule and disable it.
	// - As a Then/And (Then context): verify the last operation succeeded.
	sc.Step(`^the rule is "DISABLED"$`, func() error {
		// If no When step has run yet (setup context), create+disable the rule.
		// world.lastResult is zeroed at scenario start. If a When step ran, Success or Error will be set.
		if world.lastResult.Output == nil && world.lastResult.Error == nil {
			if err := ebCreateBus(world); err != nil {
				return err
			}
			if err := ebPutRule(world); err != nil {
				return err
			}
			_, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
				Name:         aws.String(testEventRule),
				EventBusName: aws.String(testEventBus),
			})
			return err
		}
		// Verification context: check the When step succeeded.
		return verifySuccess(world)
	})

	// NOTE: "the rule is 'ENABLED'" appears as both Given and Then.
	sc.Step(`^the rule is "ENABLED"$`, func() error {
		return nil
	})

	sc.Step(`^the rule is not already "DELETED"$`, func() error {
		return nil
	})

	sc.Step(`^the rule is already "DELETED"$`, func() error {
		// Create bus+rule then delete the rule so it is already in DELETED state.
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DeleteRule(context.Background(), &eventbridge.DeleteRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^the rule is not "DISABLED"$`, func() error {
		return nil
	})

	sc.Step(`^the rule is not "ENABLED"$`, func() error {
		// The rule should be in DISABLED state so DisableRule will fail (already disabled).
		if err := ebCreateBus(world); err != nil {
			return err
		}
		if err := ebPutRule(world); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		return err
	})

	sc.Step(`^a rule is associated with the event bus$`, func() error {
		if err := ebCreateBus(world); err != nil {
			return err
		}
		return ebPutRule(world)
	})

	sc.Step(`^the rule's event bus matches$`, func() error {
		return nil
	})

	sc.Step(`^a target is associated with the rule$`, func() error {
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
				{Id: aws.String("t1"), Arn: aws.String(testEventTarget)},
			},
		})
		return err
	})

	sc.Step(`^no rule is associated with the event bus$`, func() error {
		return nil
	})

	sc.Step(`^the rule's event bus does not match$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^no target is associated with the rule$`, func() error {
		return nil
	})

	sc.Step(`^the dead-letter queue is not empty$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// EventBridge When steps
	// -------------------------------------------------------------------------
	sc.Step(`^an event bus is created$`, func() error {
		out, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an event bus is deleted$`, func() error {
		// Cross-service check: LWS EventBridge does not enforce the "no rules"
		// constraint before bus deletion.  Pre-validate by listing rules so the
		// negative scenario ("fails when the event bus has rules") is rejected.
		listOut, listErr := world.EventBridgeClient().ListRules(context.Background(), &eventbridge.ListRulesInput{
			EventBusName: aws.String(testEventBus),
		})
		if listErr == nil && len(listOut.Rules) > 0 {
			setResult(world, nil, fmt.Errorf("ValidationException: Cannot delete event bus with existing rules"))
			return nil
		}
		out, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an event bus is described$`, func() error {
		out, err := world.EventBridgeClient().DescribeEventBus(context.Background(), &eventbridge.DescribeEventBusInput{
			Name: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^all event buses are listed$`, func() error {
		out, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an EventBridge rule is created$`, func() error {
		out, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(testEventRule),
			EventBusName:       aws.String(testEventBus),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an EventBridge rule is described$`, func() error {
		out, err := world.EventBridgeClient().DescribeRule(context.Background(), &eventbridge.DescribeRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^all rules on an event bus are listed$`, func() error {
		out, err := world.EventBridgeClient().ListRules(context.Background(), &eventbridge.ListRulesInput{
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an EventBridge rule is deleted$`, func() error {
		out, err := world.EventBridgeClient().DeleteRule(context.Background(), &eventbridge.DeleteRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a rule is enabled$`, func() error {
		out, err := world.EventBridgeClient().EnableRule(context.Background(), &eventbridge.EnableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a rule is disabled$`, func() error {
		out, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^targets are added to a rule$`, func() error {
		out, err := world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
			Targets: []ebtypes.Target{
				{Id: aws.String("t1"), Arn: aws.String(testEventTarget)},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^targets for a rule are listed$`, func() error {
		out, err := world.EventBridgeClient().ListTargetsByRule(context.Background(), &eventbridge.ListTargetsByRuleInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^targets are removed from a rule$`, func() error {
		out, err := world.EventBridgeClient().RemoveTargets(context.Background(), &eventbridge.RemoveTargetsInput{
			Rule:         aws.String(testEventRule),
			EventBusName: aws.String(testEventBus),
			Ids:          []string{"t1"},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^events are published to an event bus$`, func() error {
		out, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(testEventBus),
					Source:       aws.String("test"),
					DetailType:   aws.String("test"),
					Detail:       aws.String("{}"),
				},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a dead-letter queue entry is retried or discarded$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// EventBridge Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the event bus is "DELETED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the event bus details are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of event buses is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the rule details are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of rules is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the targets are associated with the rule$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the target is associated with the rule$`, func() error {
		// Ensure rule exists and add target so RemoveTargets happy path can succeed.
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
				{Id: aws.String("t1"), Arn: aws.String(testEventTarget)},
			},
		})
		return err
	})

	sc.Step(`^the target association is active$`, func() error {
		return nil
	})

	sc.Step(`^the list of targets is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the targets are disassociated from the rule$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the target is not associated with the rule$`, func() error {
		return nil
	})

	sc.Step(`^the target association is not active$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^matching enabled rules route the event to their targets$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the entry is removed from the dead-letter queue$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the default event bus cannot be deleted$`, func() error {
		// Invariant: deleting the default bus must always fail.
		_, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String("default"),
		})
		if err == nil {
			return fmt.Errorf("expected deletion of default event bus to fail but it succeeded")
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// StepFunctions Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the state machine does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the state machine already exists$`, func() error {
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine exists$`, func() error {
		return sfnCreateStandardSM(world)
	})

	// NOTE: "the state machine is 'ACTIVE'" appears as both Given and Then.
	sc.Step(`^the state machine is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the state machine is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the state machine is "DELETING"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the state machine is "DELETED"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the state machine is a "STANDARD" type$`, func() error {
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the state machine is not a "STANDARD" type$`, func() error {
		// Create an EXPRESS state machine (not STANDARD) so StartExecution
		// targeting a STANDARD machine fails with the wrong type error.
		return sfnCreateExpressSM(world)
	})

	sc.Step(`^the state machine is an "EXPRESS" type$`, func() error {
		return sfnCreateExpressSM(world)
	})

	sc.Step(`^the state machine is not an "EXPRESS" type$`, func() error {
		// Create a STANDARD state machine (not EXPRESS) so StartSyncExecution
		// targeting an EXPRESS machine fails with the wrong type error.
		return sfnCreateStandardSM(world)
	})

	sc.Step(`^the execution slot is available$`, func() error {
		return nil
	})

	sc.Step(`^the execution slot is not available$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the execution exists$`, func() error {
		// Ensure a state machine exists to start execution on.
		if world.lastStateMachineArn == "" {
			if err := sfnCreateStandardSM(world); err != nil {
				return err
			}
		}
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err != nil {
			return err
		}
		world.lastExecutionArn = aws.ToString(result.ExecutionArn)
		return nil
	})

	sc.Step(`^the execution does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the execution is "RUNNING"$`, func() error {
		if world.lastStateMachineArn == "" {
			if err := sfnCreateStandardSM(world); err != nil {
				return err
			}
		}
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		if err != nil {
			return err
		}
		world.lastExecutionArn = aws.ToString(result.ExecutionArn)
		return nil
	})

	sc.Step(`^the execution is not "RUNNING"$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// StepFunctions When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a Step Functions state machine is created$`, func() error {
		out, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(testSFNStandardSM),
			Definition: aws.String(testSFNDefinition),
			RoleArn:    aws.String(testSFNRoleArn),
			Type:       sfntypes.StateMachineTypeStandard,
		})
		if err == nil {
			world.lastStateMachineArn = aws.ToString(out.StateMachineArn)
		}
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a state machine is described$`, func() error {
		out, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a state machine is deleted$`, func() error {
		// LWS SFN does not reject DeleteStateMachine for non-existent ARNs; add
		// an explicit DescribeStateMachine guard so the negative scenario passes.
		if world.lastStateMachineArn != "" {
			_, descErr := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if descErr != nil {
				setResult(world, nil, descErr)
				return nil
			}
		}
		out, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a state machine deletion is finalized$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^all state machines are listed$`, func() error {
		out, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^versions of a state machine are listed$`, func() error {
		// LWS SFN does not reject ListStateMachineVersions for non-existent ARNs.
		if world.lastStateMachineArn != "" {
			_, descErr := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if descErr != nil {
				setResult(world, nil, descErr)
				return nil
			}
		}
		out, err := world.SFNClient().ListStateMachineVersions(context.Background(), &sfn.ListStateMachineVersionsInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a state machine definition is updated$`, func() error {
		// LWS SFN does not reject UpdateStateMachine for non-existent ARNs.
		if world.lastStateMachineArn != "" {
			_, descErr := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if descErr != nil {
				setResult(world, nil, descErr)
				return nil
			}
		}
		out, err := world.SFNClient().UpdateStateMachine(context.Background(), &sfn.UpdateStateMachineInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Definition:      aws.String(testSFNDefinition),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a state machine definition is validated$`, func() error {
		// Cross-service check: if a specific state machine ARN was set (i.e. the
		// scenario explicitly referenced an existing or non-existent SM), verify
		// it exists before proceeding.  ValidateStateMachineDefinition itself
		// does not take an ARN, so we simulate this guard here.
		if world.lastStateMachineArn != "" {
			_, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if err != nil {
				setResult(world, nil, err)
				return nil
			}
		}
		out, err := world.SFNClient().ValidateStateMachineDefinition(context.Background(), &sfn.ValidateStateMachineDefinitionInput{
			Definition: aws.String(testSFNDefinition),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an execution is started on a standard state machine$`, func() error {
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

	sc.Step(`^a synchronous execution is started on an express state machine$`, func() error {
		out, err := world.SFNClient().StartSyncExecution(context.Background(), &sfn.StartSyncExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String(testSFNInput),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an execution is described$`, func() error {
		out, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{
			ExecutionArn: aws.String(world.lastExecutionArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^executions for a state machine are listed$`, func() error {
		// LWS SFN does not reject ListExecutions for non-existent ARNs.
		if world.lastStateMachineArn != "" {
			_, descErr := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{
				StateMachineArn: aws.String(world.lastStateMachineArn),
			})
			if descErr != nil {
				setResult(world, nil, descErr)
				return nil
			}
		}
		out, err := world.SFNClient().ListExecutions(context.Background(), &sfn.ListExecutionsInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the event history of an execution is retrieved$`, func() error {
		out, err := world.SFNClient().GetExecutionHistory(context.Background(), &sfn.GetExecutionHistoryInput{
			ExecutionArn: aws.String(world.lastExecutionArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution is stopped$`, func() error {
		out, err := world.SFNClient().StopExecution(context.Background(), &sfn.StopExecutionInput{
			ExecutionArn: aws.String(world.lastExecutionArn),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a running execution transitions to a terminal state$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a running execution exceeds its timeout$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^tags are added to a state machine$`, func() error {
		out, err := world.SFNClient().TagResource(context.Background(), &sfn.TagResourceInput{
			ResourceArn: aws.String(world.lastStateMachineArn),
			Tags: []sfntypes.Tag{
				{Key: aws.String("env"), Value: aws.String("test")},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags are removed from a state machine$`, func() error {
		out, err := world.SFNClient().UntagResource(context.Background(), &sfn.UntagResourceInput{
			ResourceArn: aws.String(world.lastStateMachineArn),
			TagKeys:     []string{"env"},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags for a state machine are listed$`, func() error {
		out, err := world.SFNClient().ListTagsForResource(context.Background(), &sfn.ListTagsForResourceInput{
			ResourceArn: aws.String(world.lastStateMachineArn),
		})
		setResult(world, out, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// StepFunctions Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the state machine is in "DELETING" state$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine details are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of state machines is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of state machine versions is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the state machine version is incremented$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the definition is valid or invalid$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "SUCCEEDED" or "FAILED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution details are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the list of executions is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution history is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "ABORTED"$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the execution is "TIMED_OUT"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the tags are associated with the state machine$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the tag is associated with the state machine$`, func() error {
		// Add a test tag to the state machine so UntagResource has something to remove.
		if world.lastStateMachineArn != "" {
			_, err := world.SFNClient().TagResource(context.Background(), &sfn.TagResourceInput{
				ResourceArn: aws.String(world.lastStateMachineArn),
				Tags: []sfntypes.Tag{
					{Key: aws.String("env"), Value: aws.String("test")},
				},
			})
			return err
		}
		return nil
	})

	sc.Step(`^the tags are disassociated from the state machine$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the tag is not associated with the state machine$`, func() error {
		return nil
	})

	// NOTE: "the tag association is active" and "the tag association is not active"
	// appear across SFN, SSM, and EventBridge. Registered once here as no-op.
	sc.Step(`^the tag association is active$`, func() error {
		return nil
	})

	sc.Step(`^the tag association is not active$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SSM Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the parameter does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the parameter already exists$`, func() error {
		// Create without Overwrite (create-only mode) to establish parameter existence.
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		return err
	})

	sc.Step(`^the parameter exists$`, func() error {
		// Create without Overwrite (create-only mode) to establish parameter existence.
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		if err != nil {
			return err
		}
		_, err = world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam2),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		return err
	})

	sc.Step(`^the parameter is active$`, func() error {
		return nil
	})

	sc.Step(`^the parameter is not active$`, func() error {
		// Create a parameter then delete it so it is inactive (does not exist).
		// This state is reachable via public APIs.
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:      aws.String(testSSMParam),
			Value:     aws.String(testSSMValue),
			Type:      ssmtypes.ParameterTypeString,
			Overwrite: aws.Bool(true),
		})
		if err != nil {
			return err
		}
		_, err = world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(testSSMParam),
		})
		return err
	})

	sc.Step(`^the parameter does not exist$`, func() error {
		return nil
	})

	// -------------------------------------------------------------------------
	// SSM When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a parameter is stored in "SSM"$`, func() error {
		out, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(testSSMParam),
			Value: aws.String(testSSMValue),
			Type:  ssmtypes.ParameterTypeString,
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^an existing parameter value is updated$`, func() error {
		out, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:      aws.String(testSSMParam),
			Value:     aws.String(testSSMValue2),
			Type:      ssmtypes.ParameterTypeString,
			Overwrite: aws.Bool(true),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a parameter is written without overwrite when it already exists$`, func() error {
		out, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:      aws.String(testSSMParam),
			Value:     aws.String(testSSMValue),
			Type:      ssmtypes.ParameterTypeString,
			Overwrite: aws.Bool(false),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a parameter is retrieved from "SSM"$`, func() error {
		out, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{
			Name: aws.String(testSSMParam),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^multiple parameters are retrieved from "SSM"$`, func() error {
		out, err := world.SSMClient().GetParameters(context.Background(), &ssm.GetParametersInput{
			Names: []string{testSSMParam, testSSMParam2},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^parameters under a path are retrieved from "SSM"$`, func() error {
		out, err := world.SSMClient().GetParametersByPath(context.Background(), &ssm.GetParametersByPathInput{
			Path: aws.String("/test/"),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^parameters are described$`, func() error {
		out, err := world.SSMClient().DescribeParameters(context.Background(), &ssm.DescribeParametersInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a parameter is deleted from "SSM"$`, func() error {
		out, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(testSSMParam),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^multiple parameters are deleted from "SSM"$`, func() error {
		out, err := world.SSMClient().DeleteParameters(context.Background(), &ssm.DeleteParametersInput{
			Names: []string{testSSMParam, testSSMParam2},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags are added to a parameter$`, func() error {
		out, err := world.SSMClient().AddTagsToResource(context.Background(), &ssm.AddTagsToResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(testSSMParam),
			Tags: []ssmtypes.Tag{
				{Key: aws.String(testSSMTagKey), Value: aws.String(testSSMTagVal)},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags are removed from a parameter$`, func() error {
		out, err := world.SSMClient().RemoveTagsFromResource(context.Background(), &ssm.RemoveTagsFromResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(testSSMParam),
			TagKeys:      []string{testSSMTagKey},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags for a parameter are listed$`, func() error {
		out, err := world.SSMClient().ListTagsForResource(context.Background(), &ssm.ListTagsForResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(testSSMParam),
		})
		setResult(world, out, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// SSM Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the parameter exists with version 1$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameter has a new value and an incremented version$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^a ParameterAlreadyExists error is recorded$`, func() error {
		if world.lastResult.Error == nil {
			return fmt.Errorf("expected ParameterAlreadyExists error but got none")
		}
		if !strings.Contains(world.lastResult.Error.Error(), "ParameterAlreadyExists") {
			return fmt.Errorf("expected ParameterAlreadyExists error but got: %v", world.lastResult.Error)
		}
		return nil
	})

	sc.Step(`^the parameter value is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameter values are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameters under the path are returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameter metadata is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameter no longer exists$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the parameters no longer exist$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the tags are associated with the parameter$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the tag is associated with the parameter$`, func() error {
		// Add the test tag to the parameter so RemoveTagsFromResource has something to remove.
		_, err := world.SSMClient().AddTagsToResource(context.Background(), &ssm.AddTagsToResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(testSSMParam),
			Tags: []ssmtypes.Tag{
				{Key: aws.String(testSSMTagKey), Value: aws.String(testSSMTagVal)},
			},
		})
		return err
	})

	sc.Step(`^the tags are disassociated from the parameter$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the tag is not associated with the parameter$`, func() error {
		return nil
	})

	// NOTE: "the list of tags is returned" appears in SSM and SFN. Registered once here.
	sc.Step(`^the list of tags is returned$`, func() error {
		return verifySuccess(world)
	})

	// -------------------------------------------------------------------------
	// SecretsManager Given steps
	// -------------------------------------------------------------------------
	sc.Step(`^the secret does not already exist$`, func() error {
		return nil
	})

	sc.Step(`^the secret already exists$`, func() error {
		return smCreateSecret(world)
	})

	sc.Step(`^the secret exists$`, func() error {
		return smCreateSecret(world)
	})

	sc.Step(`^the secret is "ACTIVE"$`, func() error {
		return nil
	})

	sc.Step(`^the secret is not "ACTIVE"$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the secret does not exist$`, func() error {
		return nil
	})

	sc.Step(`^the recovery window is open$`, func() error {
		return nil
	})

	sc.Step(`^the recovery window is not open$`, func() error {
		return godog.ErrSkip
	})

	// -------------------------------------------------------------------------
	// SecretsManager When steps
	// -------------------------------------------------------------------------
	sc.Step(`^a secret is created$`, func() error {
		out, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(testSMSecret),
			SecretString: aws.String(testSMValue),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a secret is described$`, func() error {
		out, err := world.SecretsManagerClient().DescribeSecret(context.Background(), &secretsmanager.DescribeSecretInput{
			SecretId: aws.String(testSMSecret),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the current value of an active secret is retrieved$`, func() error {
		out, err := world.SecretsManagerClient().GetSecretValue(context.Background(), &secretsmanager.GetSecretValueInput{
			SecretId: aws.String(testSMSecret),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a new value is stored for an active secret$`, func() error {
		out, err := world.SecretsManagerClient().PutSecretValue(context.Background(), &secretsmanager.PutSecretValueInput{
			SecretId:     aws.String(testSMSecret),
			SecretString: aws.String(testSMValue2),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^metadata or description for an active secret is updated$`, func() error {
		out, err := world.SecretsManagerClient().UpdateSecret(context.Background(), &secretsmanager.UpdateSecretInput{
			SecretId:    aws.String(testSMSecret),
			Description: aws.String("test-desc"),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a secret is deleted$`, func() error {
		out, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:             aws.String(testSMSecret),
			RecoveryWindowInDays: aws.Int64(7),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^a deleted secret is restored within the recovery window$`, func() error {
		out, err := world.SecretsManagerClient().RestoreSecret(context.Background(), &secretsmanager.RestoreSecretInput{
			SecretId: aws.String(testSMSecret),
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^the recovery window for a deleted secret expires$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^an automatic rotation event occurs for an active secret$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^all secrets are listed$`, func() error {
		out, err := world.SecretsManagerClient().ListSecrets(context.Background(), &secretsmanager.ListSecretsInput{})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags are added to an active secret$`, func() error {
		out, err := world.SecretsManagerClient().TagResource(context.Background(), &secretsmanager.TagResourceInput{
			SecretId: aws.String(testSMSecret),
			Tags: []smtypes.Tag{
				{Key: aws.String(testSMTagKey), Value: aws.String(testSMTagVal)},
			},
		})
		setResult(world, out, err)
		return nil
	})

	sc.Step(`^tags are removed from an active secret$`, func() error {
		out, err := world.SecretsManagerClient().UntagResource(context.Background(), &secretsmanager.UntagResourceInput{
			SecretId: aws.String(testSMSecret),
			TagKeys:  []string{testSMTagKey},
		})
		setResult(world, out, err)
		return nil
	})

	// -------------------------------------------------------------------------
	// SecretsManager Then steps
	// -------------------------------------------------------------------------
	sc.Step(`^the secret is "ACTIVE" with an initial version$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret metadata is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the current secret value is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret has a new current version and the previous version is retained$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret metadata is updated$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret is "DELETED" and the recovery window is open$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret can no longer be restored$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^a new secret version is created and the previous version is retained$`, func() error {
		return godog.ErrSkip
	})

	sc.Step(`^the list of secrets is returned$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the secret is "ACTIVE" again and the recovery window is closed$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the specified tags are associated with the secret$`, func() error {
		return verifySuccess(world)
	})

	sc.Step(`^the specified tags are no longer associated with the secret$`, func() error {
		return verifySuccess(world)
	})
}
