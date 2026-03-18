package tests

import (
	"context"
	"fmt"
	"strconv"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
)

const passDefinition = `{"Comment":"test","StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
const sfnRoleArn = "arn:aws:iam::000000000000:role/StepFunctionsRole"

func registerResourceSteps(sc *godog.ScenarioContext, world *World) {
	// --- Resource Specification steps ---

	sc.Given(`^a session with a DynamoDB table "([^"]*)" with partition key "([^"]*)"$`, func(tableName, partitionKey string) error {
		world.sessionOpen = true
		return createDynamoDBTable(world, tableName, partitionKey)
	})

	sc.Given(`^a session with an SQS queue "([^"]*)"$`, func(queueName string) error {
		world.sessionOpen = true
		return createSQSQueue(world, queueName)
	})

	sc.Given(`^a session with an S3 bucket "([^"]*)"$`, func(bucketName string) error {
		world.sessionOpen = true
		return createS3Bucket(world, bucketName)
	})

	sc.Given(`^a session with an SNS topic "([^"]*)"$`, func(topicName string) error {
		world.sessionOpen = true
		return createSNSTopic(world, topicName)
	})

	sc.Given(`^a session with a state machine "([^"]*)" using a Pass definition$`, func(smName string) error {
		world.sessionOpen = true
		return createStateMachine(world, smName)
	})

	sc.Step(`^the session also has an SQS queue "([^"]*)"$`, func(queueName string) error {
		return createSQSQueue(world, queueName)
	})

	sc.Step(`^the session also has an S3 bucket "([^"]*)"$`, func(bucketName string) error {
		return createS3Bucket(world, bucketName)
	})

	// --- Existence assertions ---

	sc.Then(`^the table "([^"]*)" exists$`, func(tableName string) error {
		_, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(tableName),
		})
		return err
	})

	sc.Then(`^the queue "([^"]*)" exists$`, func(queueName string) error {
		_, err := world.SQSClient().GetQueueUrl(context.Background(), &sqs.GetQueueUrlInput{
			QueueName: aws.String(queueName),
		})
		return err
	})

	sc.Then(`^the bucket "([^"]*)" exists$`, func(bucketName string) error {
		_, err := world.S3Client().HeadBucket(context.Background(), &s3.HeadBucketInput{
			Bucket: aws.String(bucketName),
		})
		return err
	})

	sc.Then(`^the topic "([^"]*)" exists$`, func(topicName string) error {
		result, err := world.SNSClient().ListTopics(context.Background(), &sns.ListTopicsInput{})
		if err != nil {
			return err
		}
		for _, t := range result.Topics {
			if t.TopicArn != nil && strings.HasSuffix(*t.TopicArn, ":"+topicName) {
				return nil
			}
		}
		return fmt.Errorf("topic %q not found", topicName)
	})

	sc.Then(`^the state machine "([^"]*)" exists$`, func(smName string) error {
		result, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		if err != nil {
			return err
		}
		for _, sm := range result.StateMachines {
			if sm.Name != nil && *sm.Name == smName {
				return nil
			}
		}
		return fmt.Errorf("state machine %q not found", smName)
	})

	// --- Session Reset helpers ---

	sc.Given(`^a running session with a DynamoDB table "([^"]*)" with partition key "([^"]*)"$`, func(tableName, partitionKey string) error {
		world.sessionOpen = true
		return createDynamoDBTable(world, tableName, partitionKey)
	})

	sc.Given(`^a running session with an SQS queue "([^"]*)"$`, func(queueName string) error {
		world.sessionOpen = true
		return createSQSQueue(world, queueName)
	})

	sc.Step(`^an item with orderId "([^"]*)" has been put into "([^"]*)"$`, func(orderId, tableName string) error {
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(tableName),
			Item: map[string]dynamodbtypes.AttributeValue{
				"orderId": &dynamodbtypes.AttributeValueMemberS{Value: orderId},
			},
		})
		return err
	})

	sc.Then(`^the table "([^"]*)" contains (\d+) items$`, func(tableName string, expected int) error {
		result, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{
			TableName: aws.String(tableName),
		})
		if err != nil {
			// If the table doesn't exist after a reset, treat it as 0 items.
			if expected == 0 && strings.Contains(err.Error(), "ResourceNotFoundException") {
				return nil
			}
			return err
		}
		if len(result.Items) != expected {
			return fmt.Errorf("expected %d items in table %q, got %d", expected, tableName, len(result.Items))
		}
		return nil
	})

	sc.Step(`^a message has been sent to "([^"]*)"$`, func(queueName string) error {
		queueURL := world.SQSQueueURL(queueName)
		_, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(queueURL),
			MessageBody: aws.String("test-message"),
		})
		return err
	})

	sc.Then(`^"([^"]*)" contains (\d+) messages$`, func(queueName string, expected int) error {
		queueURL := world.SQSQueueURL(queueName)
		result, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(queueURL),
			AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameApproximateNumberOfMessages},
		})
		if err != nil {
			// If the queue doesn't exist after a reset, treat it as 0 messages.
			if expected == 0 && strings.Contains(err.Error(), "NonExistentQueue") {
				return nil
			}
			return err
		}
		actualStr := result.Attributes[string(sqstypes.QueueAttributeNameApproximateNumberOfMessages)]
		actual, _ := strconv.Atoi(actualStr)
		if actual != expected {
			return fmt.Errorf("expected %d messages in queue %q, got %d", expected, queueName, actual)
		}
		return nil
	})

	// --- Shared Given steps used by chaos/fake/iam/log tests ---

	sc.Given(`^a DynamoDB table "([^"]*)" with partition key "([^"]*)"$`, func(tableName, partitionKey string) error {
		return createDynamoDBTable(world, tableName, partitionKey)
	})

	sc.Step(`^an OrderProcessor state machine is running$`, func() error {
		return createStateMachine(world, "OrderProcessor")
	})
}

func createDynamoDBTable(world *World, tableName, partitionKey string) error {
	_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
		TableName: aws.String(tableName),
		KeySchema: []dynamodbtypes.KeySchemaElement{
			{AttributeName: aws.String(partitionKey), KeyType: dynamodbtypes.KeyTypeHash},
		},
		AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
			{AttributeName: aws.String(partitionKey), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
		},
		BillingMode: dynamodbtypes.BillingModePayPerRequest,
	})
	return err
}

func createSQSQueue(world *World, queueName string) error {
	_, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
		QueueName: aws.String(queueName),
	})
	return err
}

func createS3Bucket(world *World, bucketName string) error {
	_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
		Bucket: aws.String(bucketName),
	})
	return err
}

func createSNSTopic(world *World, topicName string) error {
	_, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(topicName),
	})
	return err
}

func createStateMachine(world *World, smName string) error {
	// Temporarily disable chaos and IAM to allow state machine creation
	// regardless of any active chaos or IAM enforce mode.
	_ = core.ChaosDisable(world.managementPort, "stepfunctions")
	_ = core.IamDisable(world.managementPort, "all")

	result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
		Name:       aws.String(smName),
		Definition: aws.String(passDefinition),
		RoleArn:    aws.String(sfnRoleArn),
		Type:       "STANDARD",
	})
	if err != nil {
		return err
	}
	if result.StateMachineArn != nil {
		world.lastStateMachineArn = *result.StateMachineArn
	}
	return nil
}
