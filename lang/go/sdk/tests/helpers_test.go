package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	"github.com/cucumber/godog"
)

func registerDynamoDBHelperSteps(sc *godog.ScenarioContext, world *World) {
	// When I put item with orderId "..." and status "..." into "Table"
	sc.When(`^I put item with orderId "([^"]*)" and status "([^"]*)" into "([^"]*)"$`, func(orderId, status, tableName string) error {
		return putDynamoItem(world, tableName, orderId, status)
	})

	sc.Step(`^I put item with orderId "([^"]*)" and status "([^"]*)" into "([^"]*)"$`, func(orderId, status, tableName string) error {
		return putDynamoItem(world, tableName, orderId, status)
	})

	// Then the table "Orders" will contain N item(s)
	sc.Then(`^the table "([^"]*)" will contain (\d+) items?$`, func(tableName string, expected int) error {
		result, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{
			TableName: aws.String(tableName),
		})
		if err != nil {
			return err
		}
		if len(result.Items) != expected {
			return fmt.Errorf("expected %d items in table %q, got %d", expected, tableName, len(result.Items))
		}
		return nil
	})

	// Then the table "Orders" will contain an item with orderId "xxx"
	sc.Then(`^the table "([^"]*)" will contain an item with orderId "([^"]*)"$`, func(tableName, orderId string) error {
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(tableName),
			Key: map[string]dynamodbtypes.AttributeValue{
				"orderId": &dynamodbtypes.AttributeValueMemberS{Value: orderId},
			},
		})
		if err != nil {
			return err
		}
		if len(result.Item) == 0 {
			return fmt.Errorf("expected item with orderId=%q in table %q but none found", orderId, tableName)
		}
		return nil
	})

	// Then the table "Orders" will not contain an item with orderId "xxx"
	sc.Then(`^the table "([^"]*)" will not contain an item with orderId "([^"]*)"$`, func(tableName, orderId string) error {
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(tableName),
			Key: map[string]dynamodbtypes.AttributeValue{
				"orderId": &dynamodbtypes.AttributeValueMemberS{Value: orderId},
			},
		})
		if err != nil {
			return err
		}
		if len(result.Item) > 0 {
			return fmt.Errorf("expected no item with orderId=%q in table %q but found one", orderId, tableName)
		}
		return nil
	})
}

func putDynamoItem(world *World, tableName, orderId, status string) error {
	_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
		TableName: aws.String(tableName),
		Item: map[string]dynamodbtypes.AttributeValue{
			"orderId": &dynamodbtypes.AttributeValueMemberS{Value: orderId},
			"status":  &dynamodbtypes.AttributeValueMemberS{Value: status},
		},
	})
	return err
}

func registerSQSHelperSteps(sc *godog.ScenarioContext, world *World) {
	// When / And I send message body "..." to "Queue"
	sc.When(`^I send message body "([^"]*)" to "([^"]*)"$`, func(body, queueName string) error {
		return sendSQSMessage(world, queueName, body)
	})

	sc.Step(`^I send message body "([^"]*)" to "([^"]*)"$`, func(body, queueName string) error {
		return sendSQSMessage(world, queueName, body)
	})

	// Then receiving N message(s) from "Queue" returns body "..."
	sc.Then(`^receiving (\d+) message from "([^"]*)" returns body "([^"]*)"$`, func(maxMessages int, queueName, expectedBody string) error {
		queueURL := world.SQSQueueURL(queueName)
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(queueURL),
			MaxNumberOfMessages: int32(maxMessages),
			WaitTimeSeconds:     1,
		})
		if err != nil {
			return err
		}
		if len(result.Messages) == 0 {
			return fmt.Errorf("expected %d message(s) from queue %q but received none", maxMessages, queueName)
		}
		if result.Messages[0].Body == nil || *result.Messages[0].Body != expectedBody {
			return fmt.Errorf("expected message body %q but got %q", expectedBody, aws.ToString(result.Messages[0].Body))
		}
		return nil
	})

	// When I receive N message from "Queue"
	sc.When(`^I receive (\d+) message from "([^"]*)"$`, func(maxMessages int, queueName string) error {
		queueURL := world.SQSQueueURL(queueName)
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl:            aws.String(queueURL),
			MaxNumberOfMessages: int32(maxMessages),
			WaitTimeSeconds:     1,
		})
		if err != nil {
			return err
		}
		world.lastMessages = result.Messages
		return nil
	})

	// Then exactly N message is returned
	sc.Then(`^exactly (\d+) message is returned$`, func(expected int) error {
		msgs, ok := world.lastMessages.([]sqstypes.Message)
		if !ok {
			return fmt.Errorf("no messages were received or unexpected type")
		}
		if len(msgs) != expected {
			return fmt.Errorf("expected %d message(s) but received %d", expected, len(msgs))
		}
		return nil
	})
}

func sendSQSMessage(world *World, queueName, body string) error {
	queueURL := world.SQSQueueURL(queueName)
	_, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
		QueueUrl:    aws.String(queueURL),
		MessageBody: aws.String(body),
	})
	return err
}
