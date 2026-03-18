package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	"github.com/cucumber/godog"
)

func nowMs() int64 {
	return time.Now().UnixNano() / int64(time.Millisecond)
}

func registerSQSSteps(sc *godog.ScenarioContext, world *World) {
	// Given
	sc.Given(`^a queue "([^"]*)" was created$`, func(queueName string) error {
		_, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{
			QueueName: aws.String(queueName),
		})
		return err
	})

	sc.Given(`^a message "([^"]*)" was sent to queue "([^"]*)"$`, func(messageBody, queueName string) error {
		_, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl:    aws.String(world.SQSQueueURL(queueName)),
			MessageBody: aws.String(messageBody),
		})
		return err
	})

	sc.Given(`^a message was received from queue "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), MaxNumberOfMessages: 1,
		})
		if err != nil {
			return err
		}
		if len(result.Messages) > 0 {
			world.lastReceiptHandle = aws.ToString(result.Messages[0].ReceiptHandle)
			world.lastQueueUrl = world.SQSQueueURL(queueName)
		}
		return nil
	})

	sc.Given(`^queue "([^"]*)" was tagged with "([^"]*)"$`, func(queueName, tagsJSON string) error {
		var tags map[string]string
		json.Unmarshal([]byte(tagsJSON), &tags)
		_, err := world.SQSClient().TagQueue(context.Background(), &sqs.TagQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), Tags: tags,
		})
		return err
	})

	// When
	sc.When(`^I create a queue named "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().CreateQueue(context.Background(), &sqs.CreateQueueInput{QueueName: aws.String(queueName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the queue "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().DeleteQueue(context.Background(), &sqs.DeleteQueueInput{QueueUrl: aws.String(world.SQSQueueURL(queueName))})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list queues$`, func() error {
		result, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SQS queues$`, func() error {
		result, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SQS queues with timing$`, func() error {
		start := nowMs()
		result, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		elapsed := nowMs() - start
		if err != nil {
			world.timedResult = TimedResult{Success: false, Output: err.Error(), ElapsedMs: elapsed}
		} else {
			world.timedResult = TimedResult{Success: true, Output: result, ElapsedMs: elapsed}
		}
		return nil
	})

	sc.When(`^I send a message "([^"]*)" to queue "([^"]*)"$`, func(messageBody, queueName string) error {
		result, err := world.SQSClient().SendMessage(context.Background(), &sqs.SendMessageInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), MessageBody: aws.String(messageBody),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I send a message batch with entries "([^"]*)" to queue "([^"]*)"$`, func(entriesJSON, queueName string) error {
		var rawEntries []struct {
			Id          string `json:"Id"`
			MessageBody string `json:"MessageBody"`
		}
		json.Unmarshal([]byte(entriesJSON), &rawEntries)
		var entries []sqstypes.SendMessageBatchRequestEntry
		for _, e := range rawEntries {
			id := e.Id
			body := e.MessageBody
			entries = append(entries, sqstypes.SendMessageBatchRequestEntry{Id: &id, MessageBody: &body})
		}
		result, err := world.SQSClient().SendMessageBatch(context.Background(), &sqs.SendMessageBatchInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), Entries: entries,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I receive a message from queue "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), MaxNumberOfMessages: 1,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
			if len(result.Messages) > 0 {
				world.lastReceiptHandle = aws.ToString(result.Messages[0].ReceiptHandle)
			}
		}
		return nil
	})

	sc.When(`^I delete the received message from queue "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().DeleteMessage(context.Background(), &sqs.DeleteMessageInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), ReceiptHandle: aws.String(world.lastReceiptHandle),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete messages in batch for the received message in queue "([^"]*)"$`, func(queueName string) error {
		rh := world.lastReceiptHandle
		result, err := world.SQSClient().DeleteMessageBatch(context.Background(), &sqs.DeleteMessageBatchInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
			Entries:  []sqstypes.DeleteMessageBatchRequestEntry{{Id: aws.String("1"), ReceiptHandle: &rh}},
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I purge queue "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().PurgeQueue(context.Background(), &sqs.PurgeQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get queue attributes for "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameAll},
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"GetQueueAttributesResponse": result}}
		}
		return nil
	})

	sc.When(`^I set queue attributes "([^"]*)" on queue "([^"]*)"$`, func(attrsJSON, queueName string) error {
		var attrs map[string]string
		json.Unmarshal([]byte(attrsJSON), &attrs)
		result, err := world.SQSClient().SetQueueAttributes(context.Background(), &sqs.SetQueueAttributesInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), Attributes: attrs,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get the queue URL for "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().GetQueueUrl(context.Background(), &sqs.GetQueueUrlInput{QueueName: aws.String(queueName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I tag queue "([^"]*)" with tags "([^"]*)"$`, func(queueName, tagsJSON string) error {
		var tags map[string]string
		json.Unmarshal([]byte(tagsJSON), &tags)
		result, err := world.SQSClient().TagQueue(context.Background(), &sqs.TagQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), Tags: tags,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I untag queue "([^"]*)" with tag keys "([^"]*)"$`, func(queueName, tagKeysJSON string) error {
		var tagKeys []string
		json.Unmarshal([]byte(tagKeysJSON), &tagKeys)
		result, err := world.SQSClient().UntagQueue(context.Background(), &sqs.UntagQueueInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), TagKeys: tagKeys,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list queue tags for "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().ListQueueTags(context.Background(), &sqs.ListQueueTagsInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I change the visibility timeout to "([^"]*)" for the received message in queue "([^"]*)"$`, func(timeout, queueName string) error {
		var vt int32
		fmt.Sscanf(timeout, "%d", &vt)
		rh := world.lastReceiptHandle
		result, err := world.SQSClient().ChangeMessageVisibility(context.Background(), &sqs.ChangeMessageVisibilityInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), ReceiptHandle: &rh, VisibilityTimeout: vt,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I change message visibility in batch with timeout "([^"]*)" for the received message in queue "([^"]*)"$`, func(timeout, queueName string) error {
		var vt int32
		fmt.Sscanf(timeout, "%d", &vt)
		rh := world.lastReceiptHandle
		result, err := world.SQSClient().ChangeMessageVisibilityBatch(context.Background(), &sqs.ChangeMessageVisibilityBatchInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
			Entries:  []sqstypes.ChangeMessageVisibilityBatchRequestEntry{{Id: aws.String("1"), ReceiptHandle: &rh, VisibilityTimeout: vt}},
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list dead letter source queues for "([^"]*)"$`, func(queueName string) error {
		result, err := world.SQSClient().ListDeadLetterSourceQueues(context.Background(), &sqs.ListDeadLetterSourceQueuesInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the queue "([^"]*)" will appear in the queue list$`, func(queueName string) error {
		result, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		if err != nil {
			return err
		}
		for _, url := range result.QueueUrls {
			if strings.Contains(url, queueName) {
				return nil
			}
		}
		return fmt.Errorf("queue %q not found in list", queueName)
	})

	sc.Then(`^the queue "([^"]*)" will not appear in the queue list$`, func(queueName string) error {
		result, err := world.SQSClient().ListQueues(context.Background(), &sqs.ListQueuesInput{})
		if err != nil {
			return err
		}
		for _, url := range result.QueueUrls {
			if strings.Contains(url, queueName) {
				return fmt.Errorf("queue %q found in list but should not be", queueName)
			}
		}
		return nil
	})

	sc.Then(`^the output will contain queue "([^"]*)"$`, func(queueName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), queueName) {
			return fmt.Errorf("expected output to contain %q but got: %s", queueName, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^the output will contain a message with body "([^"]*)"$`, func(expectedBody string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), expectedBody) {
			return fmt.Errorf("expected output to contain message body %q but got: %s", expectedBody, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^queue "([^"]*)" will contain a message with body "([^"]*)"$`, func(queueName, expectedBody string) error {
		result, err := world.SQSClient().ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)), MaxNumberOfMessages: 10,
		})
		if err != nil {
			return err
		}
		for _, m := range result.Messages {
			if aws.ToString(m.Body) == expectedBody {
				return nil
			}
		}
		return fmt.Errorf("queue %q does not contain message with body %q", queueName, expectedBody)
	})

	sc.Then(`^queue "([^"]*)" will have approximate message count "([^"]*)"$`, func(queueName, expectedCount string) error {
		result, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(world.SQSQueueURL(queueName)),
			AttributeNames: []sqstypes.QueueAttributeName{"ApproximateNumberOfMessages"},
		})
		if err != nil {
			return err
		}
		actualCount := result.Attributes["ApproximateNumberOfMessages"]
		if actualCount != expectedCount {
			return fmt.Errorf("expected count %q but got %q", expectedCount, actualCount)
		}
		return nil
	})

	sc.Then(`^queue "([^"]*)" will have attribute "([^"]*)" equal to "([^"]*)"$`, func(queueName, attrName, expectedValue string) error {
		result, err := world.SQSClient().GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
			QueueUrl:       aws.String(world.SQSQueueURL(queueName)),
			AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameAll},
		})
		if err != nil {
			return err
		}
		actualValue := result.Attributes[attrName]
		if actualValue != expectedValue {
			return fmt.Errorf("expected attr %q = %q but got %q", attrName, expectedValue, actualValue)
		}
		return nil
	})

	sc.Then(`^queue "([^"]*)" will have tag "([^"]*)" with value "([^"]*)"$`, func(queueName, tagKey, expectedValue string) error {
		result, err := world.SQSClient().ListQueueTags(context.Background(), &sqs.ListQueueTagsInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
		})
		if err != nil {
			return err
		}
		actualValue := result.Tags[tagKey]
		if actualValue != expectedValue {
			return fmt.Errorf("expected tag %q = %q but got %q", tagKey, expectedValue, actualValue)
		}
		return nil
	})

	sc.Then(`^queue "([^"]*)" will not have tag "([^"]*)"$`, func(queueName, tagKey string) error {
		result, err := world.SQSClient().ListQueueTags(context.Background(), &sqs.ListQueueTagsInput{
			QueueUrl: aws.String(world.SQSQueueURL(queueName)),
		})
		if err != nil {
			return err
		}
		if _, exists := result.Tags[tagKey]; exists {
			return fmt.Errorf("expected tag %q to not exist but it does", tagKey)
		}
		return nil
	})
}
