package tests

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	smtypes "github.com/aws/aws-sdk-go-v2/service/secretsmanager/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	sfntypes "github.com/aws/aws-sdk-go-v2/service/sfn/types"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	snstypes "github.com/aws/aws-sdk-go-v2/service/sns/types"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	sqstypes "github.com/aws/aws-sdk-go-v2/service/sqs/types"
	ssmclient "github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
	godog "github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

const (
	iamAccount = "000000000000"
	iamRegion  = "us-east-1"
)

var fullAccessPolicy = map[string]interface{}{
	"Statement": []map[string]interface{}{
		{"Effect": "Allow", "Action": "*", "Resource": "*"},
	},
}

var noPermsPolicy = map[string]interface{}{
	"Statement": []map[string]interface{}{},
}

func ensureIAMIdentitiesRegistered(port int) error {
	return lws.IamRegisterIdentities(port, map[string]interface{}{
		"lws-test-full-access": map[string]interface{}{
			"inline_policies": []interface{}{fullAccessPolicy},
		},
		"lws-test-no-perms": map[string]interface{}{
			"inline_policies": []interface{}{noPermsPolicy},
		},
	})
}

func iamSetWithIdentity(port int, mode, defaultIdentity string) error {
	body := map[string]interface{}{
		"mode":             mode,
		"default_identity": defaultIdentity,
	}
	data, err := json.Marshal(body)
	if err != nil {
		return err
	}
	resp, err := http.Post(
		fmt.Sprintf("http://127.0.0.1:%d/_ldk/iam-auth", port),
		"application/json",
		bytes.NewReader(data),
	)
	if err != nil {
		return err
	}
	resp.Body.Close()
	return nil
}

func registerIAMSteps(sc *godog.ScenarioContext, world *World) {
	// Given
	sc.Given(`^IAM auth was enabled for "([^"]*)" with mode "([^"]*)"$`, func(service, mode string) error {
		if err := ensureIAMIdentitiesRegistered(world.managementPort); err != nil {
			return err
		}
		return lws.IamSet(world.managementPort, service, mode)
	})

	sc.Given(`^IAM auth was disabled for "([^"]*)"$`, func(service string) error {
		return lws.IamDisable(world.managementPort, service)
	})

	sc.Given(`^IAM auth was set for "([^"]*)" with mode "([^"]*)"$`, func(service, mode string) error {
		if err := ensureIAMIdentitiesRegistered(world.managementPort); err != nil {
			return err
		}
		return lws.IamSet(world.managementPort, service, mode)
	})

	sc.Given(`^IAM auth was set for "([^"]*)" with mode "([^"]*)" and identity "([^"]*)"$`, func(service, mode, identity string) error {
		if err := ensureIAMIdentitiesRegistered(world.managementPort); err != nil {
			return err
		}
		return iamSetWithIdentity(world.managementPort, mode, identity)
	})

	// Then (used as cleanup)
	sc.Then(`^IAM auth was cleaned up for "([^"]*)"$`, func(service string) error {
		return lws.IamDisable(world.managementPort, service)
	})

	// When: generic service call dispatcher
	sc.When(`^I call "([^"]*)" "([^"]*)"$`, func(service, operation string) error {
		pending := dispatchIAMServiceCall(world, service, operation)
		if pending {
			return godog.ErrPending
		}
		return nil
	})
}

// dispatchIAMServiceCall dispatches a service call for IAM tests.
// Returns true if the call is pending (not implemented).
func dispatchIAMServiceCall(world *World, service, operation string) bool {
	switch service {
	case "dynamodb":
		callIAMDynamodb(world, operation)
	case "sqs":
		callIAMSqs(world, operation)
	case "s3":
		callIAMS3(world, operation)
	case "sns":
		callIAMSns(world, operation)
	case "events":
		callIAMEvents(world, operation)
	case "stepfunctions":
		if callIAMStepFunctions(world, operation) {
			return true
		}
	case "ssm":
		callIAMSSM(world, operation)
	case "secretsmanager":
		callIAMSecretsManager(world, operation)
	default:
		// Service not implemented - mark as pending
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending: %s %s", service, operation)}}
		return true
	}
	return false
}

func callIAMDynamodb(world *World, operation string) {
	client := world.DynamoDBClient()
	tableName := "iam-test-table"
	tableArn := fmt.Sprintf("arn:aws:dynamodb:%s:%s:table/%s", iamRegion, iamAccount, tableName)
	ctx := context.Background()

	switch operation {
	case "list-tables":
		result, err := client.ListTables(ctx, &dynamodb.ListTablesInput{})
		setResult(world, result, err)
	case "create-table":
		result, err := client.CreateTable(ctx, &dynamodb.CreateTableInput{
			TableName:            aws.String(tableName),
			KeySchema:            []dynamodbtypes.KeySchemaElement{{AttributeName: aws.String("pk"), KeyType: dynamodbtypes.KeyTypeHash}},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{{AttributeName: aws.String("pk"), AttributeType: dynamodbtypes.ScalarAttributeTypeS}},
			BillingMode:          dynamodbtypes.BillingModePayPerRequest,
		})
		setResult(world, result, err)
	case "delete-table":
		result, err := client.DeleteTable(ctx, &dynamodb.DeleteTableInput{TableName: aws.String(tableName)})
		setResult(world, result, err)
	case "describe-table":
		result, err := client.DescribeTable(ctx, &dynamodb.DescribeTableInput{TableName: aws.String(tableName)})
		setResult(world, result, err)
	case "update-table":
		result, err := client.UpdateTable(ctx, &dynamodb.UpdateTableInput{TableName: aws.String(tableName), BillingMode: dynamodbtypes.BillingModePayPerRequest})
		setResult(world, result, err)
	case "describe-time-to-live":
		result, err := client.DescribeTimeToLive(ctx, &dynamodb.DescribeTimeToLiveInput{TableName: aws.String(tableName)})
		setResult(world, result, err)
	case "update-time-to-live":
		result, err := client.UpdateTimeToLive(ctx, &dynamodb.UpdateTimeToLiveInput{
			TableName:               aws.String(tableName),
			TimeToLiveSpecification: &dynamodbtypes.TimeToLiveSpecification{AttributeName: aws.String("ttl"), Enabled: aws.Bool(true)},
		})
		setResult(world, result, err)
	case "describe-continuous-backups":
		result, err := client.DescribeContinuousBackups(ctx, &dynamodb.DescribeContinuousBackupsInput{TableName: aws.String(tableName)})
		setResult(world, result, err)
	case "get-item":
		result, err := client.GetItem(ctx, &dynamodb.GetItemInput{
			TableName: aws.String(tableName),
			Key:       map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
		})
		setResult(world, result, err)
	case "put-item":
		result, err := client.PutItem(ctx, &dynamodb.PutItemInput{
			TableName: aws.String(tableName),
			Item:      map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
		})
		setResult(world, result, err)
	case "delete-item":
		result, err := client.DeleteItem(ctx, &dynamodb.DeleteItemInput{
			TableName: aws.String(tableName),
			Key:       map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
		})
		setResult(world, result, err)
	case "update-item":
		result, err := client.UpdateItem(ctx, &dynamodb.UpdateItemInput{
			TableName:                 aws.String(tableName),
			Key:                       map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
			UpdateExpression:          aws.String("SET #d = :d"),
			ExpressionAttributeNames:  map[string]string{"#d": "data"},
			ExpressionAttributeValues: map[string]dynamodbtypes.AttributeValue{":d": &dynamodbtypes.AttributeValueMemberS{Value: "v"}},
		})
		setResult(world, result, err)
	case "query":
		result, err := client.Query(ctx, &dynamodb.QueryInput{
			TableName:                 aws.String(tableName),
			KeyConditionExpression:    aws.String("pk = :pk"),
			ExpressionAttributeValues: map[string]dynamodbtypes.AttributeValue{":pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
		})
		setResult(world, result, err)
	case "scan":
		result, err := client.Scan(ctx, &dynamodb.ScanInput{TableName: aws.String(tableName)})
		setResult(world, result, err)
	case "batch-get-item":
		result, err := client.BatchGetItem(ctx, &dynamodb.BatchGetItemInput{
			RequestItems: map[string]dynamodbtypes.KeysAndAttributes{
				tableName: {Keys: []map[string]dynamodbtypes.AttributeValue{{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}}}},
			},
		})
		setResult(world, result, err)
	case "batch-write-item":
		result, err := client.BatchWriteItem(ctx, &dynamodb.BatchWriteItemInput{
			RequestItems: map[string][]dynamodbtypes.WriteRequest{
				tableName: {{PutRequest: &dynamodbtypes.PutRequest{Item: map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}}}}},
			},
		})
		setResult(world, result, err)
	case "transact-get-items":
		result, err := client.TransactGetItems(ctx, &dynamodb.TransactGetItemsInput{
			TransactItems: []dynamodbtypes.TransactGetItem{{
				Get: &dynamodbtypes.Get{
					TableName: aws.String(tableName),
					Key:       map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
				},
			}},
		})
		setResult(world, result, err)
	case "transact-write-items":
		result, err := client.TransactWriteItems(ctx, &dynamodb.TransactWriteItemsInput{
			TransactItems: []dynamodbtypes.TransactWriteItem{{
				Put: &dynamodbtypes.Put{
					TableName: aws.String(tableName),
					Item:      map[string]dynamodbtypes.AttributeValue{"pk": &dynamodbtypes.AttributeValueMemberS{Value: "k"}},
				},
			}},
		})
		setResult(world, result, err)
	case "list-tags-of-resource":
		result, err := client.ListTagsOfResource(ctx, &dynamodb.ListTagsOfResourceInput{ResourceArn: aws.String(tableArn)})
		setResult(world, result, err)
	case "tag-resource":
		result, err := client.TagResource(ctx, &dynamodb.TagResourceInput{
			ResourceArn: aws.String(tableArn),
			Tags:        []dynamodbtypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}},
		})
		setResult(world, result, err)
	case "untag-resource":
		result, err := client.UntagResource(ctx, &dynamodb.UntagResourceInput{ResourceArn: aws.String(tableArn), TagKeys: []string{"k"}})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending dynamodb: %s", operation)}}
	}
}

func callIAMSqs(world *World, operation string) {
	client := world.SQSClient()
	queueName := "iam-test-queue"
	queueUrl := world.SQSQueueURL(queueName)
	ctx := context.Background()

	switch operation {
	case "list-queues":
		result, err := client.ListQueues(ctx, &sqs.ListQueuesInput{})
		setResult(world, result, err)
	case "create-queue":
		result, err := client.CreateQueue(ctx, &sqs.CreateQueueInput{QueueName: aws.String(queueName)})
		setResult(world, result, err)
	case "delete-queue":
		result, err := client.DeleteQueue(ctx, &sqs.DeleteQueueInput{QueueUrl: aws.String(queueUrl)})
		setResult(world, result, err)
	case "get-queue-url":
		result, err := client.GetQueueUrl(ctx, &sqs.GetQueueUrlInput{QueueName: aws.String(queueName)})
		setResult(world, result, err)
	case "get-queue-attributes":
		result, err := client.GetQueueAttributes(ctx, &sqs.GetQueueAttributesInput{QueueUrl: aws.String(queueUrl), AttributeNames: []sqstypes.QueueAttributeName{"All"}})
		setResult(world, result, err)
	case "set-queue-attributes":
		result, err := client.SetQueueAttributes(ctx, &sqs.SetQueueAttributesInput{QueueUrl: aws.String(queueUrl), Attributes: map[string]string{"VisibilityTimeout": "30"}})
		setResult(world, result, err)
	case "purge-queue":
		result, err := client.PurgeQueue(ctx, &sqs.PurgeQueueInput{QueueUrl: aws.String(queueUrl)})
		setResult(world, result, err)
	case "list-queue-tags":
		result, err := client.ListQueueTags(ctx, &sqs.ListQueueTagsInput{QueueUrl: aws.String(queueUrl)})
		setResult(world, result, err)
	case "tag-queue":
		result, err := client.TagQueue(ctx, &sqs.TagQueueInput{QueueUrl: aws.String(queueUrl), Tags: map[string]string{"env": "test"}})
		setResult(world, result, err)
	case "untag-queue":
		result, err := client.UntagQueue(ctx, &sqs.UntagQueueInput{QueueUrl: aws.String(queueUrl), TagKeys: []string{"env"}})
		setResult(world, result, err)
	case "send-message":
		result, err := client.SendMessage(ctx, &sqs.SendMessageInput{QueueUrl: aws.String(queueUrl), MessageBody: aws.String("test")})
		setResult(world, result, err)
	case "send-message-batch":
		result, err := client.SendMessageBatch(ctx, &sqs.SendMessageBatchInput{
			QueueUrl: aws.String(queueUrl),
			Entries:  []sqstypes.SendMessageBatchRequestEntry{{Id: aws.String("1"), MessageBody: aws.String("test")}},
		})
		setResult(world, result, err)
	case "receive-message":
		result, err := client.ReceiveMessage(ctx, &sqs.ReceiveMessageInput{QueueUrl: aws.String(queueUrl), MaxNumberOfMessages: 1})
		setResult(world, result, err)
	case "delete-message":
		result, err := client.DeleteMessage(ctx, &sqs.DeleteMessageInput{QueueUrl: aws.String(queueUrl), ReceiptHandle: aws.String("dummy")})
		setResult(world, result, err)
	case "delete-message-batch":
		result, err := client.DeleteMessageBatch(ctx, &sqs.DeleteMessageBatchInput{
			QueueUrl: aws.String(queueUrl),
			Entries:  []sqstypes.DeleteMessageBatchRequestEntry{{Id: aws.String("1"), ReceiptHandle: aws.String("dummy")}},
		})
		setResult(world, result, err)
	case "change-message-visibility":
		result, err := client.ChangeMessageVisibility(ctx, &sqs.ChangeMessageVisibilityInput{QueueUrl: aws.String(queueUrl), ReceiptHandle: aws.String("dummy"), VisibilityTimeout: 30})
		setResult(world, result, err)
	case "change-message-visibility-batch":
		result, err := client.ChangeMessageVisibilityBatch(ctx, &sqs.ChangeMessageVisibilityBatchInput{
			QueueUrl: aws.String(queueUrl),
			Entries:  []sqstypes.ChangeMessageVisibilityBatchRequestEntry{{Id: aws.String("1"), ReceiptHandle: aws.String("dummy"), VisibilityTimeout: 30}},
		})
		setResult(world, result, err)
	case "list-dead-letter-source-queues":
		result, err := client.ListDeadLetterSourceQueues(ctx, &sqs.ListDeadLetterSourceQueuesInput{QueueUrl: aws.String(queueUrl)})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sqs: %s", operation)}}
	}
}

func callIAMS3(world *World, operation string) {
	client := world.S3Client()
	bucket := "iam-test-bucket"
	key := "iam-test-key.txt"
	ctx := context.Background()

	switch operation {
	case "list-buckets":
		result, err := client.ListBuckets(ctx, &s3.ListBucketsInput{})
		setResult(world, result, err)
	case "create-bucket":
		result, err := client.CreateBucket(ctx, &s3.CreateBucketInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "delete-bucket":
		result, err := client.DeleteBucket(ctx, &s3.DeleteBucketInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "head-bucket":
		result, err := client.HeadBucket(ctx, &s3.HeadBucketInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "list-objects-v2":
		result, err := client.ListObjectsV2(ctx, &s3.ListObjectsV2Input{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "get-bucket-location":
		result, err := client.GetBucketLocation(ctx, &s3.GetBucketLocationInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "get-bucket-tagging":
		result, err := client.GetBucketTagging(ctx, &s3.GetBucketTaggingInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "put-bucket-tagging":
		result, err := client.PutBucketTagging(ctx, &s3.PutBucketTaggingInput{Bucket: aws.String(bucket), Tagging: &s3types.Tagging{TagSet: []s3types.Tag{}}})
		setResult(world, result, err)
	case "delete-bucket-tagging":
		result, err := client.DeleteBucketTagging(ctx, &s3.DeleteBucketTaggingInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "get-bucket-policy":
		result, err := client.GetBucketPolicy(ctx, &s3.GetBucketPolicyInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "put-bucket-policy":
		result, err := client.PutBucketPolicy(ctx, &s3.PutBucketPolicyInput{Bucket: aws.String(bucket), Policy: aws.String(`{"Version":"2012-10-17","Statement":[]}`)})
		setResult(world, result, err)
	case "get-bucket-notification-configuration":
		result, err := client.GetBucketNotificationConfiguration(ctx, &s3.GetBucketNotificationConfigurationInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "put-bucket-notification-configuration":
		result, err := client.PutBucketNotificationConfiguration(ctx, &s3.PutBucketNotificationConfigurationInput{
			Bucket:                    aws.String(bucket),
			NotificationConfiguration: &s3types.NotificationConfiguration{},
		})
		setResult(world, result, err)
	case "get-bucket-website":
		result, err := client.GetBucketWebsite(ctx, &s3.GetBucketWebsiteInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "put-bucket-website":
		result, err := client.PutBucketWebsite(ctx, &s3.PutBucketWebsiteInput{
			Bucket: aws.String(bucket),
			WebsiteConfiguration: &s3types.WebsiteConfiguration{
				IndexDocument: &s3types.IndexDocument{Suffix: aws.String("index.html")},
			},
		})
		setResult(world, result, err)
	case "delete-bucket-website":
		result, err := client.DeleteBucketWebsite(ctx, &s3.DeleteBucketWebsiteInput{Bucket: aws.String(bucket)})
		setResult(world, result, err)
	case "get-object":
		result, err := client.GetObject(ctx, &s3.GetObjectInput{Bucket: aws.String(bucket), Key: aws.String(key)})
		setResult(world, result, err)
	case "put-object":
		result, err := client.PutObject(ctx, &s3.PutObjectInput{Bucket: aws.String(bucket), Key: aws.String(key), Body: bytes.NewReader([]byte("test"))})
		setResult(world, result, err)
	case "delete-object":
		result, err := client.DeleteObject(ctx, &s3.DeleteObjectInput{Bucket: aws.String(bucket), Key: aws.String(key)})
		setResult(world, result, err)
	case "head-object":
		result, err := client.HeadObject(ctx, &s3.HeadObjectInput{Bucket: aws.String(bucket), Key: aws.String(key)})
		setResult(world, result, err)
	case "copy-object":
		result, err := client.CopyObject(ctx, &s3.CopyObjectInput{Bucket: aws.String(bucket), Key: aws.String("dest.txt"), CopySource: aws.String(bucket + "/" + key)})
		setResult(world, result, err)
	case "delete-objects":
		result, err := client.DeleteObjects(ctx, &s3.DeleteObjectsInput{
			Bucket: aws.String(bucket),
			Delete: &s3types.Delete{Objects: []s3types.ObjectIdentifier{{Key: aws.String(key)}}},
		})
		setResult(world, result, err)
	case "create-multipart-upload":
		result, err := client.CreateMultipartUpload(ctx, &s3.CreateMultipartUploadInput{Bucket: aws.String(bucket), Key: aws.String(key)})
		setResult(world, result, err)
	case "upload-part":
		result, err := client.UploadPart(ctx, &s3.UploadPartInput{Bucket: aws.String(bucket), Key: aws.String(key), UploadId: aws.String("dummy"), PartNumber: aws.Int32(1), Body: bytes.NewReader([]byte("part"))})
		setResult(world, result, err)
	case "complete-multipart-upload":
		result, err := client.CompleteMultipartUpload(ctx, &s3.CompleteMultipartUploadInput{
			Bucket:          aws.String(bucket),
			Key:             aws.String(key),
			UploadId:        aws.String("dummy"),
			MultipartUpload: &s3types.CompletedMultipartUpload{},
		})
		setResult(world, result, err)
	case "list-parts":
		result, err := client.ListParts(ctx, &s3.ListPartsInput{Bucket: aws.String(bucket), Key: aws.String(key), UploadId: aws.String("dummy")})
		setResult(world, result, err)
	case "abort-multipart-upload":
		result, err := client.AbortMultipartUpload(ctx, &s3.AbortMultipartUploadInput{Bucket: aws.String(bucket), Key: aws.String(key), UploadId: aws.String("dummy")})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending s3: %s", operation)}}
	}
}

func callIAMSns(world *World, operation string) {
	client := world.SNSClient()
	topicArn := fmt.Sprintf("arn:aws:sns:%s:%s:iam-test-topic", iamRegion, iamAccount)
	subArn := fmt.Sprintf("arn:aws:sns:%s:%s:iam-test-topic:dummy-sub", iamRegion, iamAccount)
	ctx := context.Background()

	switch operation {
	case "list-topics":
		result, err := client.ListTopics(ctx, &sns.ListTopicsInput{})
		setResult(world, result, err)
	case "list-subscriptions":
		result, err := client.ListSubscriptions(ctx, &sns.ListSubscriptionsInput{})
		setResult(world, result, err)
	case "list-subscriptions-by-topic":
		result, err := client.ListSubscriptionsByTopic(ctx, &sns.ListSubscriptionsByTopicInput{TopicArn: aws.String(topicArn)})
		setResult(world, result, err)
	case "create-topic":
		result, err := client.CreateTopic(ctx, &sns.CreateTopicInput{Name: aws.String("iam-test-topic")})
		setResult(world, result, err)
	case "delete-topic":
		result, err := client.DeleteTopic(ctx, &sns.DeleteTopicInput{TopicArn: aws.String(topicArn)})
		setResult(world, result, err)
	case "publish":
		result, err := client.Publish(ctx, &sns.PublishInput{TopicArn: aws.String(topicArn), Message: aws.String("test")})
		setResult(world, result, err)
	case "subscribe":
		dummyEndpoint := fmt.Sprintf("arn:aws:sqs:%s:%s:dummy", iamRegion, iamAccount)
		result, err := client.Subscribe(ctx, &sns.SubscribeInput{TopicArn: aws.String(topicArn), Protocol: aws.String("sqs"), Endpoint: aws.String(dummyEndpoint)})
		setResult(world, result, err)
	case "unsubscribe":
		result, err := client.Unsubscribe(ctx, &sns.UnsubscribeInput{SubscriptionArn: aws.String(subArn)})
		setResult(world, result, err)
	case "get-topic-attributes":
		result, err := client.GetTopicAttributes(ctx, &sns.GetTopicAttributesInput{TopicArn: aws.String(topicArn)})
		setResult(world, result, err)
	case "set-topic-attributes":
		result, err := client.SetTopicAttributes(ctx, &sns.SetTopicAttributesInput{TopicArn: aws.String(topicArn), AttributeName: aws.String("DisplayName"), AttributeValue: aws.String("test")})
		setResult(world, result, err)
	case "get-subscription-attributes":
		result, err := client.GetSubscriptionAttributes(ctx, &sns.GetSubscriptionAttributesInput{SubscriptionArn: aws.String(subArn)})
		setResult(world, result, err)
	case "set-subscription-attributes":
		result, err := client.SetSubscriptionAttributes(ctx, &sns.SetSubscriptionAttributesInput{SubscriptionArn: aws.String(subArn), AttributeName: aws.String("RawMessageDelivery"), AttributeValue: aws.String("true")})
		setResult(world, result, err)
	case "confirm-subscription":
		result, err := client.ConfirmSubscription(ctx, &sns.ConfirmSubscriptionInput{TopicArn: aws.String(topicArn), Token: aws.String("dummy")})
		setResult(world, result, err)
	case "list-tags-for-resource":
		result, err := client.ListTagsForResource(ctx, &sns.ListTagsForResourceInput{ResourceArn: aws.String(topicArn)})
		setResult(world, result, err)
	case "tag-resource":
		result, err := client.TagResource(ctx, &sns.TagResourceInput{ResourceArn: aws.String(topicArn), Tags: []snstypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}}})
		setResult(world, result, err)
	case "untag-resource":
		result, err := client.UntagResource(ctx, &sns.UntagResourceInput{ResourceArn: aws.String(topicArn), TagKeys: []string{"k"}})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sns: %s", operation)}}
	}
}

func callIAMEvents(world *World, operation string) {
	client := world.EventBridgeClient()
	busArn := fmt.Sprintf("arn:aws:events:%s:%s:event-bus/iam-test-bus", iamRegion, iamAccount)
	ctx := context.Background()

	switch operation {
	case "list-rules":
		result, err := client.ListRules(ctx, &eventbridge.ListRulesInput{EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "list-event-buses":
		result, err := client.ListEventBuses(ctx, &eventbridge.ListEventBusesInput{})
		setResult(world, result, err)
	case "describe-event-bus":
		result, err := client.DescribeEventBus(ctx, &eventbridge.DescribeEventBusInput{Name: aws.String("default")})
		setResult(world, result, err)
	case "create-event-bus":
		result, err := client.CreateEventBus(ctx, &eventbridge.CreateEventBusInput{Name: aws.String("iam-test-bus")})
		setResult(world, result, err)
	case "delete-event-bus":
		result, err := client.DeleteEventBus(ctx, &eventbridge.DeleteEventBusInput{Name: aws.String("iam-test-bus")})
		setResult(world, result, err)
	case "put-rule":
		result, err := client.PutRule(ctx, &eventbridge.PutRuleInput{
			Name:               aws.String("iam-test-rule"),
			EventBusName:       aws.String("default"),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		setResult(world, result, err)
	case "delete-rule":
		result, err := client.DeleteRule(ctx, &eventbridge.DeleteRuleInput{Name: aws.String("iam-test-rule"), EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "describe-rule":
		result, err := client.DescribeRule(ctx, &eventbridge.DescribeRuleInput{Name: aws.String("iam-test-rule"), EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "put-targets":
		dummyArn := fmt.Sprintf("arn:aws:sqs:%s:%s:dummy", iamRegion, iamAccount)
		result, err := client.PutTargets(ctx, &eventbridge.PutTargetsInput{
			Rule:         aws.String("iam-test-rule"),
			EventBusName: aws.String("default"),
			Targets:      []ebtypes.Target{{Id: aws.String("t1"), Arn: aws.String(dummyArn)}},
		})
		setResult(world, result, err)
	case "remove-targets":
		result, err := client.RemoveTargets(ctx, &eventbridge.RemoveTargetsInput{Rule: aws.String("iam-test-rule"), EventBusName: aws.String("default"), Ids: []string{"t1"}})
		setResult(world, result, err)
	case "list-targets-by-rule":
		result, err := client.ListTargetsByRule(ctx, &eventbridge.ListTargetsByRuleInput{Rule: aws.String("iam-test-rule"), EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "enable-rule":
		result, err := client.EnableRule(ctx, &eventbridge.EnableRuleInput{Name: aws.String("iam-test-rule"), EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "disable-rule":
		result, err := client.DisableRule(ctx, &eventbridge.DisableRuleInput{Name: aws.String("iam-test-rule"), EventBusName: aws.String("default")})
		setResult(world, result, err)
	case "put-events":
		result, err := client.PutEvents(ctx, &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{{Source: aws.String("test"), DetailType: aws.String("test"), Detail: aws.String("{}")}},
		})
		setResult(world, result, err)
	case "list-tags-for-resource":
		result, err := client.ListTagsForResource(ctx, &eventbridge.ListTagsForResourceInput{ResourceARN: aws.String(busArn)})
		setResult(world, result, err)
	case "tag-resource":
		result, err := client.TagResource(ctx, &eventbridge.TagResourceInput{ResourceARN: aws.String(busArn), Tags: []ebtypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}}})
		setResult(world, result, err)
	case "untag-resource":
		result, err := client.UntagResource(ctx, &eventbridge.UntagResourceInput{ResourceARN: aws.String(busArn), TagKeys: []string{"k"}})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending events: %s", operation)}}
	}
}

func callIAMStepFunctions(world *World, operation string) bool {
	client := world.SFNClient()
	smArn := fmt.Sprintf("arn:aws:states:%s:%s:stateMachine:iam-test-sm", iamRegion, iamAccount)
	execArn := fmt.Sprintf("arn:aws:states:%s:%s:execution:iam-test-sm:dummy", iamRegion, iamAccount)
	passDefinition := `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`
	roleArn := fmt.Sprintf("arn:aws:iam::%s:role/dummy", iamAccount)
	ctx := context.Background()

	switch operation {
	case "list-state-machines":
		result, err := client.ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		setResult(world, result, err)
	case "create-state-machine":
		result, err := client.CreateStateMachine(ctx, &sfn.CreateStateMachineInput{
			Name:       aws.String("iam-test-sm"),
			Definition: aws.String(passDefinition),
			RoleArn:    aws.String(roleArn),
			Type:       "STANDARD",
		})
		setResult(world, result, err)
	case "delete-state-machine":
		result, err := client.DeleteStateMachine(ctx, &sfn.DeleteStateMachineInput{StateMachineArn: aws.String(smArn)})
		setResult(world, result, err)
	case "describe-state-machine":
		result, err := client.DescribeStateMachine(ctx, &sfn.DescribeStateMachineInput{StateMachineArn: aws.String(smArn)})
		setResult(world, result, err)
	case "update-state-machine":
		result, err := client.UpdateStateMachine(ctx, &sfn.UpdateStateMachineInput{StateMachineArn: aws.String(smArn), Definition: aws.String(passDefinition)})
		setResult(world, result, err)
	case "validate-state-machine-definition":
		result, err := client.ValidateStateMachineDefinition(ctx, &sfn.ValidateStateMachineDefinitionInput{Definition: aws.String(passDefinition)})
		setResult(world, result, err)
	case "list-state-machine-versions":
		result, err := client.ListStateMachineVersions(ctx, &sfn.ListStateMachineVersionsInput{StateMachineArn: aws.String(smArn)})
		setResult(world, result, err)
	case "start-execution":
		result, err := client.StartExecution(ctx, &sfn.StartExecutionInput{StateMachineArn: aws.String(smArn), Input: aws.String("{}")})
		setResult(world, result, err)
	case "start-sync-execution":
		// StartSyncExecution prepends "sync-" to the endpoint hostname; mark pending.
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": "pending sfn: start-sync-execution"}}
		return true
	case "stop-execution":
		result, err := client.StopExecution(ctx, &sfn.StopExecutionInput{ExecutionArn: aws.String(execArn)})
		setResult(world, result, err)
	case "describe-execution":
		result, err := client.DescribeExecution(ctx, &sfn.DescribeExecutionInput{ExecutionArn: aws.String(execArn)})
		setResult(world, result, err)
	case "list-executions":
		result, err := client.ListExecutions(ctx, &sfn.ListExecutionsInput{StateMachineArn: aws.String(smArn)})
		setResult(world, result, err)
	case "get-execution-history":
		result, err := client.GetExecutionHistory(ctx, &sfn.GetExecutionHistoryInput{ExecutionArn: aws.String(execArn)})
		setResult(world, result, err)
	case "list-tags-for-resource":
		result, err := client.ListTagsForResource(ctx, &sfn.ListTagsForResourceInput{ResourceArn: aws.String(smArn)})
		setResult(world, result, err)
	case "tag-resource":
		result, err := client.TagResource(ctx, &sfn.TagResourceInput{
			ResourceArn: aws.String(smArn),
			Tags:        []sfntypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}},
		})
		setResult(world, result, err)
	case "untag-resource":
		result, err := client.UntagResource(ctx, &sfn.UntagResourceInput{ResourceArn: aws.String(smArn), TagKeys: []string{"k"}})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sfn: %s", operation)}}
	}
	return false
}

func callIAMSSM(world *World, operation string) {
	client := world.SSMClient()
	paramName := "/iam-test/param"
	ctx := context.Background()

	switch operation {
	case "describe-parameters":
		result, err := client.DescribeParameters(ctx, &ssmclient.DescribeParametersInput{})
		setResult(world, result, err)
	case "get-parameter":
		result, err := client.GetParameter(ctx, &ssmclient.GetParameterInput{Name: aws.String(paramName)})
		setResult(world, result, err)
	case "get-parameters":
		result, err := client.GetParameters(ctx, &ssmclient.GetParametersInput{Names: []string{paramName}})
		setResult(world, result, err)
	case "get-parameters-by-path":
		result, err := client.GetParametersByPath(ctx, &ssmclient.GetParametersByPathInput{Path: aws.String("/iam-test")})
		setResult(world, result, err)
	case "put-parameter":
		result, err := client.PutParameter(ctx, &ssmclient.PutParameterInput{Name: aws.String(paramName), Value: aws.String("v"), Type: ssmtypes.ParameterTypeString})
		setResult(world, result, err)
	case "delete-parameter":
		result, err := client.DeleteParameter(ctx, &ssmclient.DeleteParameterInput{Name: aws.String(paramName)})
		setResult(world, result, err)
	case "delete-parameters":
		result, err := client.DeleteParameters(ctx, &ssmclient.DeleteParametersInput{Names: []string{paramName}})
		setResult(world, result, err)
	case "add-tags-to-resource":
		result, err := client.AddTagsToResource(ctx, &ssmclient.AddTagsToResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(paramName),
			Tags:         []ssmtypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}},
		})
		setResult(world, result, err)
	case "remove-tags-from-resource":
		result, err := client.RemoveTagsFromResource(ctx, &ssmclient.RemoveTagsFromResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(paramName),
			TagKeys:      []string{"k"},
		})
		setResult(world, result, err)
	case "list-tags-for-resource":
		result, err := client.ListTagsForResource(ctx, &ssmclient.ListTagsForResourceInput{
			ResourceType: ssmtypes.ResourceTypeForTaggingParameter,
			ResourceId:   aws.String(paramName),
		})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending ssm: %s", operation)}}
	}
}

func callIAMSecretsManager(world *World, operation string) {
	client := world.SecretsManagerClient()
	secretName := "iam-test-secret"
	ctx := context.Background()

	switch operation {
	case "list-secrets":
		result, err := client.ListSecrets(ctx, &secretsmanager.ListSecretsInput{})
		setResult(world, result, err)
	case "create-secret":
		result, err := client.CreateSecret(ctx, &secretsmanager.CreateSecretInput{Name: aws.String(secretName), SecretString: aws.String("val")})
		setResult(world, result, err)
	case "get-secret-value":
		result, err := client.GetSecretValue(ctx, &secretsmanager.GetSecretValueInput{SecretId: aws.String(secretName)})
		setResult(world, result, err)
	case "put-secret-value":
		result, err := client.PutSecretValue(ctx, &secretsmanager.PutSecretValueInput{SecretId: aws.String(secretName), SecretString: aws.String("new")})
		setResult(world, result, err)
	case "describe-secret":
		result, err := client.DescribeSecret(ctx, &secretsmanager.DescribeSecretInput{SecretId: aws.String(secretName)})
		setResult(world, result, err)
	case "update-secret":
		result, err := client.UpdateSecret(ctx, &secretsmanager.UpdateSecretInput{SecretId: aws.String(secretName), SecretString: aws.String("updated")})
		setResult(world, result, err)
	case "delete-secret":
		result, err := client.DeleteSecret(ctx, &secretsmanager.DeleteSecretInput{SecretId: aws.String(secretName), ForceDeleteWithoutRecovery: aws.Bool(true)})
		setResult(world, result, err)
	case "restore-secret":
		result, err := client.RestoreSecret(ctx, &secretsmanager.RestoreSecretInput{SecretId: aws.String(secretName)})
		setResult(world, result, err)
	case "list-secret-version-ids":
		result, err := client.ListSecretVersionIds(ctx, &secretsmanager.ListSecretVersionIdsInput{SecretId: aws.String(secretName)})
		setResult(world, result, err)
	case "get-resource-policy":
		result, err := client.GetResourcePolicy(ctx, &secretsmanager.GetResourcePolicyInput{SecretId: aws.String(secretName)})
		setResult(world, result, err)
	case "tag-resource":
		result, err := client.TagResource(ctx, &secretsmanager.TagResourceInput{
			SecretId: aws.String(secretName),
			Tags:     []smtypes.Tag{{Key: aws.String("k"), Value: aws.String("v")}},
		})
		setResult(world, result, err)
	case "untag-resource":
		result, err := client.UntagResource(ctx, &secretsmanager.UntagResourceInput{SecretId: aws.String(secretName), TagKeys: []string{"k"}})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending secretsmanager: %s", operation)}}
	}
}
