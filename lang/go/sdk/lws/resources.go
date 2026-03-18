package lws

import (
	"bytes"
	"context"
	"io"
	"strconv"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dyntypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
)

// DynamoDBHelper wraps a single DynamoDB table for easy test seeding and assertions.
type DynamoDBHelper struct {
	tableName string
	client    *dynamodb.Client
}

// Put writes an item to the table.
func (h *DynamoDBHelper) Put(item map[string]dyntypes.AttributeValue) error {
	_, err := h.client.PutItem(context.Background(), &dynamodb.PutItemInput{
		TableName: aws.String(h.tableName),
		Item:      item,
	})
	return err
}

// Get retrieves an item by its primary key. Returns an empty map if the item does not exist.
func (h *DynamoDBHelper) Get(key map[string]dyntypes.AttributeValue) (map[string]dyntypes.AttributeValue, error) {
	result, err := h.client.GetItem(context.Background(), &dynamodb.GetItemInput{
		TableName: aws.String(h.tableName),
		Key:       key,
	})
	if err != nil {
		return nil, err
	}
	return result.Item, nil
}

// Delete removes an item by its primary key.
func (h *DynamoDBHelper) Delete(key map[string]dyntypes.AttributeValue) error {
	_, err := h.client.DeleteItem(context.Background(), &dynamodb.DeleteItemInput{
		TableName: aws.String(h.tableName),
		Key:       key,
	})
	return err
}

// Scan returns all items in the table.
func (h *DynamoDBHelper) Scan() ([]map[string]dyntypes.AttributeValue, error) {
	result, err := h.client.Scan(context.Background(), &dynamodb.ScanInput{
		TableName: aws.String(h.tableName),
	})
	if err != nil {
		return nil, err
	}
	return result.Items, nil
}

// AssertItemExists fails the test if no item with the given key exists in the table.
// Returns the item attributes on success.
func (h *DynamoDBHelper) AssertItemExists(t testing.TB, key map[string]dyntypes.AttributeValue) map[string]dyntypes.AttributeValue {
	t.Helper()
	item, err := h.Get(key)
	if err != nil {
		t.Fatalf("DynamoDBHelper.AssertItemExists: GetItem error: %v", err)
	}
	if len(item) == 0 {
		t.Fatalf("DynamoDBHelper.AssertItemExists: no item found in table %q", h.tableName)
	}
	return item
}

// AssertItemCount fails the test if the total number of items in the table differs from expected.
func (h *DynamoDBHelper) AssertItemCount(t testing.TB, expected int) {
	t.Helper()
	items, err := h.Scan()
	if err != nil {
		t.Fatalf("DynamoDBHelper.AssertItemCount: Scan error: %v", err)
	}
	if len(items) != expected {
		t.Errorf("DynamoDBHelper.AssertItemCount: got %d items, want %d", len(items), expected)
	}
}

// SQSHelper wraps a single SQS queue for easy test message operations.
type SQSHelper struct {
	queueName string
	queueURL  string
	client    *sqs.Client
}

// URL returns the queue URL.
func (h *SQSHelper) URL() string {
	return h.queueURL
}

// Send sends a message body to the queue and returns the message ID.
func (h *SQSHelper) Send(body string) (*string, error) {
	result, err := h.client.SendMessage(context.Background(), &sqs.SendMessageInput{
		QueueUrl:    aws.String(h.queueURL),
		MessageBody: aws.String(body),
	})
	if err != nil {
		return nil, err
	}
	return result.MessageId, nil
}

// Receive retrieves up to maxMessages messages from the queue.
func (h *SQSHelper) Receive(maxMessages int) ([]sqstypes.Message, error) {
	result, err := h.client.ReceiveMessage(context.Background(), &sqs.ReceiveMessageInput{
		QueueUrl:            aws.String(h.queueURL),
		MaxNumberOfMessages: int32(maxMessages),
		WaitTimeSeconds:     1,
	})
	if err != nil {
		return nil, err
	}
	return result.Messages, nil
}

// Purge deletes all messages from the queue.
func (h *SQSHelper) Purge() error {
	_, err := h.client.PurgeQueue(context.Background(), &sqs.PurgeQueueInput{
		QueueUrl: aws.String(h.queueURL),
	})
	return err
}

// AssertMessageCount fails the test if the approximate visible message count differs from expected.
func (h *SQSHelper) AssertMessageCount(t testing.TB, expected int) {
	t.Helper()
	result, err := h.client.GetQueueAttributes(context.Background(), &sqs.GetQueueAttributesInput{
		QueueUrl:       aws.String(h.queueURL),
		AttributeNames: []sqstypes.QueueAttributeName{sqstypes.QueueAttributeNameApproximateNumberOfMessages},
	})
	if err != nil {
		t.Fatalf("SQSHelper.AssertMessageCount: GetQueueAttributes error: %v", err)
	}
	actualStr := result.Attributes[string(sqstypes.QueueAttributeNameApproximateNumberOfMessages)]
	actual, _ := strconv.Atoi(actualStr)
	if actual != expected {
		t.Errorf("SQSHelper.AssertMessageCount: got %d messages, want %d", actual, expected)
	}
}

// S3Helper wraps a single S3 bucket for easy test object operations.
type S3Helper struct {
	bucket string
	client *s3.Client
}

// Put uploads an object to the bucket.
func (h *S3Helper) Put(key string, body []byte) error {
	_, err := h.client.PutObject(context.Background(), &s3.PutObjectInput{
		Bucket: aws.String(h.bucket),
		Key:    aws.String(key),
		Body:   bytes.NewReader(body),
	})
	return err
}

// Get downloads an object from the bucket and returns its contents.
func (h *S3Helper) Get(key string) ([]byte, error) {
	result, err := h.client.GetObject(context.Background(), &s3.GetObjectInput{
		Bucket: aws.String(h.bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		return nil, err
	}
	defer result.Body.Close()
	return io.ReadAll(result.Body)
}

// GetText downloads an object and returns its contents as a string.
func (h *S3Helper) GetText(key string) (string, error) {
	data, err := h.Get(key)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

// Delete removes an object from the bucket.
func (h *S3Helper) Delete(key string) error {
	_, err := h.client.DeleteObject(context.Background(), &s3.DeleteObjectInput{
		Bucket: aws.String(h.bucket),
		Key:    aws.String(key),
	})
	return err
}

// ListKeys returns the keys of all objects in the bucket with the given prefix.
// Use an empty prefix to list all objects.
func (h *S3Helper) ListKeys(prefix string) ([]string, error) {
	result, err := h.client.ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{
		Bucket: aws.String(h.bucket),
		Prefix: aws.String(prefix),
	})
	if err != nil {
		return nil, err
	}
	var keys []string
	for _, obj := range result.Contents {
		if obj.Key != nil {
			keys = append(keys, *obj.Key)
		}
	}
	return keys, nil
}

// AssertObjectExists fails the test if the given key does not exist in the bucket.
func (h *S3Helper) AssertObjectExists(t testing.TB, key string) {
	t.Helper()
	_, err := h.client.HeadObject(context.Background(), &s3.HeadObjectInput{
		Bucket: aws.String(h.bucket),
		Key:    aws.String(key),
	})
	if err != nil {
		t.Fatalf("S3Helper.AssertObjectExists: key %q not found in bucket %q: %v", key, h.bucket, err)
	}
}

// AssertObjectCount fails the test if the number of objects with the given prefix differs from expected.
func (h *S3Helper) AssertObjectCount(t testing.TB, expected int, prefix string) {
	t.Helper()
	keys, err := h.ListKeys(prefix)
	if err != nil {
		t.Fatalf("S3Helper.AssertObjectCount: ListKeys error: %v", err)
	}
	if len(keys) != expected {
		t.Errorf("S3Helper.AssertObjectCount: got %d objects, want %d", len(keys), expected)
	}
}
