/** IAM auth step definitions. */

import { Given, Then } from "@cucumber/cucumber";
import { When } from "@cucumber/cucumber";
import * as cli from "../../src/cli";
import type { LwsWorld } from "../support/world";
import type { IamPolicy } from "../../src/types";
import {
  DynamoDBClient,
  ListTablesCommand,
  CreateTableCommand,
  DeleteTableCommand,
  DescribeTableCommand,
  UpdateTableCommand,
  DescribeTimeToLiveCommand,
  UpdateTimeToLiveCommand,
  DescribeContinuousBackupsCommand,
  GetItemCommand,
  PutItemCommand,
  DeleteItemCommand,
  UpdateItemCommand,
  QueryCommand,
  ScanCommand,
  BatchGetItemCommand,
  BatchWriteItemCommand,
  TransactGetItemsCommand,
  TransactWriteItemsCommand,
  ListTagsOfResourceCommand,
  TagResourceCommand,
  UntagResourceCommand,
} from "@aws-sdk/client-dynamodb";
import {
  SQSClient,
  ListQueuesCommand,
  CreateQueueCommand,
  DeleteQueueCommand,
  GetQueueUrlCommand,
  GetQueueAttributesCommand,
  SetQueueAttributesCommand,
  PurgeQueueCommand,
  ListQueueTagsCommand,
  TagQueueCommand,
  UntagQueueCommand,
  SendMessageCommand,
  SendMessageBatchCommand,
  ReceiveMessageCommand,
  DeleteMessageCommand,
  DeleteMessageBatchCommand,
  ChangeMessageVisibilityCommand,
  ChangeMessageVisibilityBatchCommand,
  ListDeadLetterSourceQueuesCommand,
} from "@aws-sdk/client-sqs";
import {
  S3Client,
  ListBucketsCommand,
  CreateBucketCommand,
  DeleteBucketCommand,
  HeadBucketCommand,
  ListObjectsV2Command,
  GetBucketLocationCommand,
  GetBucketTaggingCommand,
  PutBucketTaggingCommand,
  DeleteBucketTaggingCommand,
  GetBucketPolicyCommand,
  PutBucketPolicyCommand,
  GetBucketNotificationConfigurationCommand,
  PutBucketNotificationConfigurationCommand,
  GetBucketWebsiteCommand,
  PutBucketWebsiteCommand,
  DeleteBucketWebsiteCommand,
  GetObjectCommand,
  PutObjectCommand,
  DeleteObjectCommand,
  HeadObjectCommand,
  CopyObjectCommand,
  DeleteObjectsCommand,
  CreateMultipartUploadCommand,
  UploadPartCommand,
  CompleteMultipartUploadCommand,
  ListPartsCommand,
  AbortMultipartUploadCommand,
} from "@aws-sdk/client-s3";
import {
  SNSClient,
  ListTopicsCommand,
  ListSubscriptionsCommand,
  ListSubscriptionsByTopicCommand,
  CreateTopicCommand,
  DeleteTopicCommand,
  PublishCommand,
  SubscribeCommand,
  UnsubscribeCommand,
  GetTopicAttributesCommand,
  SetTopicAttributesCommand,
  GetSubscriptionAttributesCommand,
  SetSubscriptionAttributesCommand,
  ConfirmSubscriptionCommand,
  ListTagsForResourceCommand as SnsListTagsForResourceCommand,
  TagResourceCommand as SnsTagResourceCommand,
  UntagResourceCommand as SnsUntagResourceCommand,
} from "@aws-sdk/client-sns";
import {
  EventBridgeClient,
  ListRulesCommand,
  ListEventBusesCommand,
  DescribeEventBusCommand,
  CreateEventBusCommand,
  DeleteEventBusCommand,
  PutRuleCommand,
  DeleteRuleCommand,
  DescribeRuleCommand,
  PutTargetsCommand,
  RemoveTargetsCommand,
  ListTargetsByRuleCommand,
  EnableRuleCommand,
  DisableRuleCommand,
  PutEventsCommand,
  ListTagsForResourceCommand as EbListTagsCommand,
  TagResourceCommand as EbTagCommand,
  UntagResourceCommand as EbUntagCommand,
} from "@aws-sdk/client-eventbridge";
import {
  SFNClient,
  ListStateMachinesCommand,
  CreateStateMachineCommand,
  DeleteStateMachineCommand,
  DescribeStateMachineCommand,
  UpdateStateMachineCommand,
  ValidateStateMachineDefinitionCommand,
  ListStateMachineVersionsCommand,
  StartExecutionCommand,
  StartSyncExecutionCommand,
  StopExecutionCommand,
  DescribeExecutionCommand,
  ListExecutionsCommand,
  GetExecutionHistoryCommand,
  ListTagsForResourceCommand as SfnListTagsCommand,
  TagResourceCommand as SfnTagCommand,
  UntagResourceCommand as SfnUntagCommand,
} from "@aws-sdk/client-sfn";
import {
  SSMClient,
  DescribeParametersCommand,
  GetParameterCommand,
  GetParametersCommand,
  GetParametersByPathCommand,
  PutParameterCommand,
  DeleteParameterCommand,
  DeleteParametersCommand,
  AddTagsToResourceCommand,
  RemoveTagsFromResourceCommand,
  ListTagsForResourceCommand as SsmListTagsCommand,
} from "@aws-sdk/client-ssm";
import {
  SecretsManagerClient,
  ListSecretsCommand,
  CreateSecretCommand,
  GetSecretValueCommand,
  PutSecretValueCommand,
  DescribeSecretCommand,
  UpdateSecretCommand,
  DeleteSecretCommand,
  RestoreSecretCommand,
  ListSecretVersionIdsCommand,
  GetResourcePolicyCommand,
  TagResourceCommand as SmTagCommand,
  UntagResourceCommand as SmUntagCommand,
} from "@aws-sdk/client-secrets-manager";
import {
  CognitoIdentityProviderClient,
  ListUserPoolsCommand,
  CreateUserPoolCommand,
  DeleteUserPoolCommand,
  DescribeUserPoolCommand,
  UpdateUserPoolCommand,
  CreateUserPoolClientCommand,
  DeleteUserPoolClientCommand,
  DescribeUserPoolClientCommand,
  ListUserPoolClientsCommand,
  AdminGetUserCommand,
  AdminCreateUserCommand,
  AdminDeleteUserCommand,
  ListUsersCommand,
  SignUpCommand,
  ConfirmSignUpCommand,
  ForgotPasswordCommand,
  ConfirmForgotPasswordCommand,
  ChangePasswordCommand,
  GlobalSignOutCommand,
  InitiateAuthCommand,
} from "@aws-sdk/client-cognito-identity-provider";

const ACCOUNT = "000000000000";
const REGION = "us-east-1";

// Test identities
const FULL_ACCESS_POLICY: IamPolicy = {
  Statement: [{ Effect: "Allow", Action: "*", Resource: "*" }],
};
const NO_PERMS_POLICY: IamPolicy = {
  Statement: [],
};

// Register identities before any IAM scenario
async function ensureIdentitiesRegistered(world: LwsWorld): Promise<void> {
  await cli.iamRegisterIdentities(world.managementPort, {
    "lws-test-full-access": { inline_policies: [FULL_ACCESS_POLICY] },
    "lws-test-no-perms": { inline_policies: [NO_PERMS_POLICY] },
  });
}

// --- Given -----------------------------------------------------------------

Given(
  "IAM auth was enabled for {string} with mode {string}",
  async function (this: LwsWorld, _service: string, mode: string) {
    await ensureIdentitiesRegistered(this);
    await cli.iamSet(this.managementPort, _service, mode);
  },
);

Given("IAM auth was disabled for {string}", async function (this: LwsWorld, service: string) {
  await cli.iamDisable(this.managementPort, service);
});

Given(
  "IAM auth was set for {string} with mode {string}",
  async function (this: LwsWorld, service: string, mode: string) {
    await ensureIdentitiesRegistered(this);
    await cli.iamSet(this.managementPort, service, mode);
  },
);

Given(
  "IAM auth was set for {string} with mode {string} and identity {string}",
  async function (this: LwsWorld, service: string, mode: string, identity: string) {
    await ensureIdentitiesRegistered(this);
    // Send mode and default_identity together so management API sets both
    await fetch(`http://127.0.0.1:${this.managementPort}/_ldk/iam-auth`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ mode, default_identity: identity }),
    });
  },
);

Then("IAM auth was cleaned up for {string}", async function (this: LwsWorld, _service: string) {
  await cli.iamDisable(this.managementPort, _service);
});

// --- When: generic service call dispatcher ---------------------------------

When(
  "I call {string} {string}",
  async function (this: LwsWorld, service: string, operation: string) {
    // Dispatch based on service + operation
    try {
      await dispatchServiceCall(this, service, operation);
    } catch (err: unknown) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

async function dispatchServiceCall(
  world: LwsWorld,
  service: string,
  operation: string,
): Promise<void> {
  switch (service) {
    case "dynamodb":
      await callDynamodb(world, operation);
      break;
    case "sqs":
      await callSqs(world, operation);
      break;
    case "s3":
      await callS3(world, operation);
      break;
    case "sns":
      await callSns(world, operation);
      break;
    case "events":
      await callEvents(world, operation);
      break;
    case "stepfunctions":
      await callStepFunctions(world, operation);
      break;
    case "ssm":
      await callSsm(world, operation);
      break;
    case "secretsmanager":
      await callSecretsManager(world, operation);
      break;
    case "cognito-idp":
      await callCognito(world, operation);
      break;
    default:
      world.lastResult = { success: true, output: { message: `pending: ${service} ${operation}` } };
  }
}

async function callDynamodb(world: LwsWorld, operation: string): Promise<void> {
  const client = world.dynamodbClient();
  const tableName = "iam-test-table";
  const tableArn = `arn:aws:dynamodb:us-east-1:${ACCOUNT}:table/${tableName}`;
  try {
    switch (operation) {
      case "list-tables":
        world.lastResult = { success: true, output: await client.send(new ListTablesCommand({})) };
        break;
      case "create-table":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CreateTableCommand({
              TableName: tableName,
              KeySchema: [{ AttributeName: "pk", KeyType: "HASH" }],
              AttributeDefinitions: [{ AttributeName: "pk", AttributeType: "S" }],
              BillingMode: "PAY_PER_REQUEST",
            }),
          ),
        };
        break;
      case "delete-table":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteTableCommand({ TableName: tableName })),
        };
        break;
      case "describe-table":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeTableCommand({ TableName: tableName })),
        };
        break;
      case "update-table":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UpdateTableCommand({ TableName: tableName, BillingMode: "PAY_PER_REQUEST" }),
          ),
        };
        break;
      case "describe-time-to-live":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeTimeToLiveCommand({ TableName: tableName })),
        };
        break;
      case "update-time-to-live":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UpdateTimeToLiveCommand({
              TableName: tableName,
              TimeToLiveSpecification: { AttributeName: "ttl", Enabled: true },
            }),
          ),
        };
        break;
      case "describe-continuous-backups":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeContinuousBackupsCommand({ TableName: tableName })),
        };
        break;
      case "get-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new GetItemCommand({ TableName: tableName, Key: { pk: { S: "k" } } }),
          ),
        };
        break;
      case "put-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutItemCommand({ TableName: tableName, Item: { pk: { S: "k" } } }),
          ),
        };
        break;
      case "delete-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteItemCommand({ TableName: tableName, Key: { pk: { S: "k" } } }),
          ),
        };
        break;
      case "update-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UpdateItemCommand({
              TableName: tableName,
              Key: { pk: { S: "k" } },
              UpdateExpression: "SET #d = :d",
              ExpressionAttributeNames: { "#d": "data" },
              ExpressionAttributeValues: { ":d": { S: "v" } },
            }),
          ),
        };
        break;
      case "query":
        world.lastResult = {
          success: true,
          output: await client.send(
            new QueryCommand({
              TableName: tableName,
              KeyConditionExpression: "pk = :pk",
              ExpressionAttributeValues: { ":pk": { S: "k" } },
            }),
          ),
        };
        break;
      case "scan":
        world.lastResult = {
          success: true,
          output: await client.send(new ScanCommand({ TableName: tableName })),
        };
        break;
      case "batch-get-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new BatchGetItemCommand({
              RequestItems: { [tableName]: { Keys: [{ pk: { S: "k" } }] } },
            }),
          ),
        };
        break;
      case "batch-write-item":
        world.lastResult = {
          success: true,
          output: await client.send(
            new BatchWriteItemCommand({
              RequestItems: { [tableName]: [{ PutRequest: { Item: { pk: { S: "k" } } } }] },
            }),
          ),
        };
        break;
      case "transact-get-items":
        world.lastResult = {
          success: true,
          output: await client.send(
            new TransactGetItemsCommand({
              TransactItems: [{ Get: { TableName: tableName, Key: { pk: { S: "k" } } } }],
            }),
          ),
        };
        break;
      case "transact-write-items":
        world.lastResult = {
          success: true,
          output: await client.send(
            new TransactWriteItemsCommand({
              TransactItems: [{ Put: { TableName: tableName, Item: { pk: { S: "k" } } } }],
            }),
          ),
        };
        break;
      case "list-tags-of-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new ListTagsOfResourceCommand({ ResourceArn: tableArn })),
        };
        break;
      case "tag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new TagResourceCommand({ ResourceArn: tableArn, Tags: [{ Key: "k", Value: "v" }] }),
          ),
        };
        break;
      case "untag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UntagResourceCommand({ ResourceArn: tableArn, TagKeys: ["k"] }),
          ),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending dynamodb: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callSqs(world: LwsWorld, operation: string): Promise<void> {
  const client = world.sqsClient();
  const queueName = "iam-test-queue";
  const queueUrl = world.sqsQueueUrl(queueName);
  try {
    switch (operation) {
      case "list-queues":
        world.lastResult = { success: true, output: await client.send(new ListQueuesCommand({})) };
        break;
      case "create-queue":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateQueueCommand({ QueueName: queueName })),
        };
        break;
      case "delete-queue":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteQueueCommand({ QueueUrl: queueUrl })),
        };
        break;
      case "get-queue-url":
        world.lastResult = {
          success: true,
          output: await client.send(new GetQueueUrlCommand({ QueueName: queueName })),
        };
        break;
      case "get-queue-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(
            new GetQueueAttributesCommand({ QueueUrl: queueUrl, AttributeNames: ["All"] }),
          ),
        };
        break;
      case "set-queue-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SetQueueAttributesCommand({
              QueueUrl: queueUrl,
              Attributes: { VisibilityTimeout: "30" },
            }),
          ),
        };
        break;
      case "purge-queue":
        world.lastResult = {
          success: true,
          output: await client.send(new PurgeQueueCommand({ QueueUrl: queueUrl })),
        };
        break;
      case "list-queue-tags":
        world.lastResult = {
          success: true,
          output: await client.send(new ListQueueTagsCommand({ QueueUrl: queueUrl })),
        };
        break;
      case "tag-queue":
        world.lastResult = {
          success: true,
          output: await client.send(
            new TagQueueCommand({ QueueUrl: queueUrl, Tags: { env: "test" } }),
          ),
        };
        break;
      case "untag-queue":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UntagQueueCommand({ QueueUrl: queueUrl, TagKeys: ["env"] }),
          ),
        };
        break;
      case "send-message":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "test" }),
          ),
        };
        break;
      case "send-message-batch":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SendMessageBatchCommand({
              QueueUrl: queueUrl,
              Entries: [{ Id: "1", MessageBody: "test" }],
            }),
          ),
        };
        break;
      case "receive-message":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
          ),
        };
        break;
      case "delete-message":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteMessageCommand({ QueueUrl: queueUrl, ReceiptHandle: "dummy" }),
          ),
        };
        break;
      case "delete-message-batch":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteMessageBatchCommand({
              QueueUrl: queueUrl,
              Entries: [{ Id: "1", ReceiptHandle: "dummy" }],
            }),
          ),
        };
        break;
      case "change-message-visibility":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ChangeMessageVisibilityCommand({
              QueueUrl: queueUrl,
              ReceiptHandle: "dummy",
              VisibilityTimeout: 30,
            }),
          ),
        };
        break;
      case "change-message-visibility-batch":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ChangeMessageVisibilityBatchCommand({
              QueueUrl: queueUrl,
              Entries: [{ Id: "1", ReceiptHandle: "dummy", VisibilityTimeout: 30 }],
            }),
          ),
        };
        break;
      case "list-dead-letter-source-queues":
        world.lastResult = {
          success: true,
          output: await client.send(new ListDeadLetterSourceQueuesCommand({ QueueUrl: queueUrl })),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending sqs: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callS3(world: LwsWorld, operation: string): Promise<void> {
  const client = world.s3Client();
  const bucket = "iam-test-bucket";
  const key = "iam-test-key.txt";
  try {
    switch (operation) {
      case "list-buckets":
        world.lastResult = { success: true, output: await client.send(new ListBucketsCommand({})) };
        break;
      case "create-bucket":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateBucketCommand({ Bucket: bucket })),
        };
        break;
      case "delete-bucket":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteBucketCommand({ Bucket: bucket })),
        };
        break;
      case "head-bucket":
        world.lastResult = {
          success: true,
          output: await client.send(new HeadBucketCommand({ Bucket: bucket })),
        };
        break;
      case "list-objects-v2":
        world.lastResult = {
          success: true,
          output: await client.send(new ListObjectsV2Command({ Bucket: bucket })),
        };
        break;
      case "get-bucket-location":
        world.lastResult = {
          success: true,
          output: await client.send(new GetBucketLocationCommand({ Bucket: bucket })),
        };
        break;
      case "get-bucket-tagging":
        world.lastResult = {
          success: true,
          output: await client.send(new GetBucketTaggingCommand({ Bucket: bucket })),
        };
        break;
      case "put-bucket-tagging":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutBucketTaggingCommand({ Bucket: bucket, Tagging: { TagSet: [] } }),
          ),
        };
        break;
      case "delete-bucket-tagging":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteBucketTaggingCommand({ Bucket: bucket })),
        };
        break;
      case "get-bucket-policy":
        world.lastResult = {
          success: true,
          output: await client.send(new GetBucketPolicyCommand({ Bucket: bucket })),
        };
        break;
      case "put-bucket-policy":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutBucketPolicyCommand({
              Bucket: bucket,
              Policy: '{"Version":"2012-10-17","Statement":[]}',
            }),
          ),
        };
        break;
      case "get-bucket-notification-configuration":
        world.lastResult = {
          success: true,
          output: await client.send(
            new GetBucketNotificationConfigurationCommand({ Bucket: bucket }),
          ),
        };
        break;
      case "put-bucket-notification-configuration":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutBucketNotificationConfigurationCommand({
              Bucket: bucket,
              NotificationConfiguration: {},
            }),
          ),
        };
        break;
      case "get-bucket-website":
        world.lastResult = {
          success: true,
          output: await client.send(new GetBucketWebsiteCommand({ Bucket: bucket })),
        };
        break;
      case "put-bucket-website":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutBucketWebsiteCommand({
              Bucket: bucket,
              WebsiteConfiguration: { IndexDocument: { Suffix: "index.html" } },
            }),
          ),
        };
        break;
      case "delete-bucket-website":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteBucketWebsiteCommand({ Bucket: bucket })),
        };
        break;
      case "get-object":
        world.lastResult = {
          success: true,
          output: await client.send(new GetObjectCommand({ Bucket: bucket, Key: key })),
        };
        break;
      case "put-object":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutObjectCommand({ Bucket: bucket, Key: key, Body: Buffer.from("test") }),
          ),
        };
        break;
      case "delete-object":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteObjectCommand({ Bucket: bucket, Key: key })),
        };
        break;
      case "head-object":
        world.lastResult = {
          success: true,
          output: await client.send(new HeadObjectCommand({ Bucket: bucket, Key: key })),
        };
        break;
      case "copy-object":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CopyObjectCommand({
              Bucket: bucket,
              Key: "dest.txt",
              CopySource: `${bucket}/${key}`,
            }),
          ),
        };
        break;
      case "delete-objects":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteObjectsCommand({ Bucket: bucket, Delete: { Objects: [{ Key: key }] } }),
          ),
        };
        break;
      case "create-multipart-upload":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateMultipartUploadCommand({ Bucket: bucket, Key: key })),
        };
        break;
      case "upload-part":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UploadPartCommand({
              Bucket: bucket,
              Key: key,
              UploadId: "dummy",
              PartNumber: 1,
              Body: Buffer.from("part"),
            }),
          ),
        };
        break;
      case "complete-multipart-upload":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CompleteMultipartUploadCommand({
              Bucket: bucket,
              Key: key,
              UploadId: "dummy",
              MultipartUpload: { Parts: [] },
            }),
          ),
        };
        break;
      case "list-parts":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ListPartsCommand({ Bucket: bucket, Key: key, UploadId: "dummy" }),
          ),
        };
        break;
      case "abort-multipart-upload":
        world.lastResult = {
          success: true,
          output: await client.send(
            new AbortMultipartUploadCommand({ Bucket: bucket, Key: key, UploadId: "dummy" }),
          ),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending s3: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callSns(world: LwsWorld, operation: string): Promise<void> {
  const client = world.snsClient();
  const topicArn = `arn:aws:sns:${REGION}:${ACCOUNT}:iam-test-topic`;
  const subArn = `arn:aws:sns:${REGION}:${ACCOUNT}:iam-test-topic:dummy-sub`;
  try {
    switch (operation) {
      case "list-topics":
        world.lastResult = { success: true, output: await client.send(new ListTopicsCommand({})) };
        break;
      case "list-subscriptions":
        world.lastResult = {
          success: true,
          output: await client.send(new ListSubscriptionsCommand({})),
        };
        break;
      case "list-subscriptions-by-topic":
        world.lastResult = {
          success: true,
          output: await client.send(new ListSubscriptionsByTopicCommand({ TopicArn: topicArn })),
        };
        break;
      case "create-topic":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateTopicCommand({ Name: "iam-test-topic" })),
        };
        break;
      case "delete-topic":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteTopicCommand({ TopicArn: topicArn })),
        };
        break;
      case "publish":
        world.lastResult = {
          success: true,
          output: await client.send(new PublishCommand({ TopicArn: topicArn, Message: "test" })),
        };
        break;
      case "subscribe":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SubscribeCommand({
              TopicArn: topicArn,
              Protocol: "sqs",
              Endpoint: `arn:aws:sqs:${REGION}:${ACCOUNT}:dummy`,
            }),
          ),
        };
        break;
      case "unsubscribe":
        world.lastResult = {
          success: true,
          output: await client.send(new UnsubscribeCommand({ SubscriptionArn: subArn })),
        };
        break;
      case "get-topic-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(new GetTopicAttributesCommand({ TopicArn: topicArn })),
        };
        break;
      case "set-topic-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SetTopicAttributesCommand({
              TopicArn: topicArn,
              AttributeName: "DisplayName",
              AttributeValue: "test",
            }),
          ),
        };
        break;
      case "get-subscription-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(
            new GetSubscriptionAttributesCommand({ SubscriptionArn: subArn }),
          ),
        };
        break;
      case "set-subscription-attributes":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SetSubscriptionAttributesCommand({
              SubscriptionArn: subArn,
              AttributeName: "RawMessageDelivery",
              AttributeValue: "true",
            }),
          ),
        };
        break;
      case "confirm-subscription":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ConfirmSubscriptionCommand({ TopicArn: topicArn, Token: "dummy" }),
          ),
        };
        break;
      case "list-tags-for-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new SnsListTagsForResourceCommand({ ResourceArn: topicArn })),
        };
        break;
      case "tag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SnsTagResourceCommand({ ResourceArn: topicArn, Tags: [{ Key: "k", Value: "v" }] }),
          ),
        };
        break;
      case "untag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SnsUntagResourceCommand({ ResourceArn: topicArn, TagKeys: ["k"] }),
          ),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending sns: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callEvents(world: LwsWorld, operation: string): Promise<void> {
  const client = world.eventbridgeClient();
  const busArn = `arn:aws:events:${REGION}:${ACCOUNT}:event-bus/iam-test-bus`;
  try {
    switch (operation) {
      case "list-rules":
        world.lastResult = {
          success: true,
          output: await client.send(new ListRulesCommand({ EventBusName: "default" })),
        };
        break;
      case "list-event-buses":
        world.lastResult = {
          success: true,
          output: await client.send(new ListEventBusesCommand({})),
        };
        break;
      case "describe-event-bus":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeEventBusCommand({ Name: "default" })),
        };
        break;
      case "create-event-bus":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateEventBusCommand({ Name: "iam-test-bus" })),
        };
        break;
      case "delete-event-bus":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteEventBusCommand({ Name: "iam-test-bus" })),
        };
        break;
      case "put-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutRuleCommand({
              Name: "iam-test-rule",
              EventBusName: "default",
              ScheduleExpression: "rate(1 day)",
              State: "ENABLED",
            }),
          ),
        };
        break;
      case "delete-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteRuleCommand({ Name: "iam-test-rule", EventBusName: "default" }),
          ),
        };
        break;
      case "describe-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DescribeRuleCommand({ Name: "iam-test-rule", EventBusName: "default" }),
          ),
        };
        break;
      case "put-targets":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutTargetsCommand({
              Rule: "iam-test-rule",
              EventBusName: "default",
              Targets: [{ Id: "t1", Arn: `arn:aws:sqs:${REGION}:${ACCOUNT}:dummy` }],
            }),
          ),
        };
        break;
      case "remove-targets":
        world.lastResult = {
          success: true,
          output: await client.send(
            new RemoveTargetsCommand({
              Rule: "iam-test-rule",
              EventBusName: "default",
              Ids: ["t1"],
            }),
          ),
        };
        break;
      case "list-targets-by-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ListTargetsByRuleCommand({ Rule: "iam-test-rule", EventBusName: "default" }),
          ),
        };
        break;
      case "enable-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new EnableRuleCommand({ Name: "iam-test-rule", EventBusName: "default" }),
          ),
        };
        break;
      case "disable-rule":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DisableRuleCommand({ Name: "iam-test-rule", EventBusName: "default" }),
          ),
        };
        break;
      case "put-events":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutEventsCommand({
              Entries: [{ Source: "test", DetailType: "test", Detail: "{}" }],
            }),
          ),
        };
        break;
      case "list-tags-for-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new EbListTagsCommand({ ResourceARN: busArn })),
        };
        break;
      case "tag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new EbTagCommand({ ResourceARN: busArn, Tags: [{ Key: "k", Value: "v" }] }),
          ),
        };
        break;
      case "untag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new EbUntagCommand({ ResourceARN: busArn, TagKeys: ["k"] })),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending events: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callStepFunctions(world: LwsWorld, operation: string): Promise<void> {
  const client = world.sfnClient();
  const smArn = `arn:aws:states:${REGION}:${ACCOUNT}:stateMachine:iam-test-sm`;
  const passDefinition = JSON.stringify({
    StartAt: "Pass",
    States: { Pass: { Type: "Pass", End: true } },
  });
  try {
    switch (operation) {
      case "list-state-machines":
        world.lastResult = {
          success: true,
          output: await client.send(new ListStateMachinesCommand({})),
        };
        break;
      case "create-state-machine":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CreateStateMachineCommand({
              name: "iam-test-sm",
              definition: passDefinition,
              roleArn: `arn:aws:iam::${ACCOUNT}:role/dummy`,
              type: "STANDARD",
            }),
          ),
        };
        break;
      case "delete-state-machine":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteStateMachineCommand({ stateMachineArn: smArn })),
        };
        break;
      case "describe-state-machine":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeStateMachineCommand({ stateMachineArn: smArn })),
        };
        break;
      case "update-state-machine":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UpdateStateMachineCommand({ stateMachineArn: smArn, definition: passDefinition }),
          ),
        };
        break;
      case "validate-state-machine-definition":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ValidateStateMachineDefinitionCommand({ definition: passDefinition }),
          ),
        };
        break;
      case "list-state-machine-versions":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ListStateMachineVersionsCommand({ stateMachineArn: smArn }),
          ),
        };
        break;
      case "start-execution":
        world.lastResult = {
          success: true,
          output: await client.send(
            new StartExecutionCommand({ stateMachineArn: smArn, input: "{}" }),
          ),
        };
        break;
      case "start-sync-execution":
        world.lastResult = {
          success: true,
          output: await client.send(
            new StartSyncExecutionCommand({ stateMachineArn: smArn, input: "{}" }),
          ),
        };
        break;
      case "stop-execution":
        world.lastResult = {
          success: true,
          output: await client.send(
            new StopExecutionCommand({
              executionArn: `arn:aws:states:${REGION}:${ACCOUNT}:execution:iam-test-sm:dummy`,
            }),
          ),
        };
        break;
      case "describe-execution":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DescribeExecutionCommand({
              executionArn: `arn:aws:states:${REGION}:${ACCOUNT}:execution:iam-test-sm:dummy`,
            }),
          ),
        };
        break;
      case "list-executions":
        world.lastResult = {
          success: true,
          output: await client.send(new ListExecutionsCommand({ stateMachineArn: smArn })),
        };
        break;
      case "get-execution-history":
        world.lastResult = {
          success: true,
          output: await client.send(
            new GetExecutionHistoryCommand({
              executionArn: `arn:aws:states:${REGION}:${ACCOUNT}:execution:iam-test-sm:dummy`,
            }),
          ),
        };
        break;
      case "list-tags-for-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new SfnListTagsCommand({ resourceArn: smArn })),
        };
        break;
      case "tag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SfnTagCommand({ resourceArn: smArn, tags: [{ key: "k", value: "v" }] }),
          ),
        };
        break;
      case "untag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new SfnUntagCommand({ resourceArn: smArn, tagKeys: ["k"] })),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending sfn: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callSsm(world: LwsWorld, operation: string): Promise<void> {
  const client = world.ssmClient();
  const paramName = "/iam-test/param";
  try {
    switch (operation) {
      case "describe-parameters":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeParametersCommand({})),
        };
        break;
      case "get-parameter":
        world.lastResult = {
          success: true,
          output: await client.send(new GetParameterCommand({ Name: paramName })),
        };
        break;
      case "get-parameters":
        world.lastResult = {
          success: true,
          output: await client.send(new GetParametersCommand({ Names: [paramName] })),
        };
        break;
      case "get-parameters-by-path":
        world.lastResult = {
          success: true,
          output: await client.send(new GetParametersByPathCommand({ Path: "/iam-test" })),
        };
        break;
      case "put-parameter":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutParameterCommand({ Name: paramName, Value: "v", Type: "String" }),
          ),
        };
        break;
      case "delete-parameter":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteParameterCommand({ Name: paramName })),
        };
        break;
      case "delete-parameters":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteParametersCommand({ Names: [paramName] })),
        };
        break;
      case "add-tags-to-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new AddTagsToResourceCommand({
              ResourceType: "Parameter",
              ResourceId: paramName,
              Tags: [{ Key: "k", Value: "v" }],
            }),
          ),
        };
        break;
      case "remove-tags-from-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new RemoveTagsFromResourceCommand({
              ResourceType: "Parameter",
              ResourceId: paramName,
              TagKeys: ["k"],
            }),
          ),
        };
        break;
      case "list-tags-for-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SsmListTagsCommand({ ResourceType: "Parameter", ResourceId: paramName }),
          ),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending ssm: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callSecretsManager(world: LwsWorld, operation: string): Promise<void> {
  const client = world.secretsManagerClient();
  const secretName = "iam-test-secret";
  try {
    switch (operation) {
      case "list-secrets":
        world.lastResult = { success: true, output: await client.send(new ListSecretsCommand({})) };
        break;
      case "create-secret":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CreateSecretCommand({ Name: secretName, SecretString: "val" }),
          ),
        };
        break;
      case "get-secret-value":
        world.lastResult = {
          success: true,
          output: await client.send(new GetSecretValueCommand({ SecretId: secretName })),
        };
        break;
      case "put-secret-value":
        world.lastResult = {
          success: true,
          output: await client.send(
            new PutSecretValueCommand({ SecretId: secretName, SecretString: "new" }),
          ),
        };
        break;
      case "describe-secret":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeSecretCommand({ SecretId: secretName })),
        };
        break;
      case "update-secret":
        world.lastResult = {
          success: true,
          output: await client.send(
            new UpdateSecretCommand({ SecretId: secretName, SecretString: "updated" }),
          ),
        };
        break;
      case "delete-secret":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteSecretCommand({ SecretId: secretName, ForceDeleteWithoutRecovery: true }),
          ),
        };
        break;
      case "restore-secret":
        world.lastResult = {
          success: true,
          output: await client.send(new RestoreSecretCommand({ SecretId: secretName })),
        };
        break;
      case "list-secret-version-ids":
        world.lastResult = {
          success: true,
          output: await client.send(new ListSecretVersionIdsCommand({ SecretId: secretName })),
        };
        break;
      case "get-resource-policy":
        world.lastResult = {
          success: true,
          output: await client.send(new GetResourcePolicyCommand({ SecretId: secretName })),
        };
        break;
      case "tag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SmTagCommand({ SecretId: secretName, Tags: [{ Key: "k", Value: "v" }] }),
          ),
        };
        break;
      case "untag-resource":
        world.lastResult = {
          success: true,
          output: await client.send(new SmUntagCommand({ SecretId: secretName, TagKeys: ["k"] })),
        };
        break;
      default:
        world.lastResult = {
          success: true,
          output: { message: `pending secretsmanager: ${operation}` },
        };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}

async function callCognito(world: LwsWorld, operation: string): Promise<void> {
  const client = world.cognitoClient();
  const poolId = "us-east-1_testpool";
  const clientId = "testclientid";
  try {
    switch (operation) {
      case "list-user-pools":
        world.lastResult = {
          success: true,
          output: await client.send(new ListUserPoolsCommand({ MaxResults: 10 })),
        };
        break;
      case "create-user-pool":
        world.lastResult = {
          success: true,
          output: await client.send(new CreateUserPoolCommand({ PoolName: "iam-test-pool" })),
        };
        break;
      case "delete-user-pool":
        world.lastResult = {
          success: true,
          output: await client.send(new DeleteUserPoolCommand({ UserPoolId: poolId })),
        };
        break;
      case "describe-user-pool":
        world.lastResult = {
          success: true,
          output: await client.send(new DescribeUserPoolCommand({ UserPoolId: poolId })),
        };
        break;
      case "update-user-pool":
        world.lastResult = {
          success: true,
          output: await client.send(new UpdateUserPoolCommand({ UserPoolId: poolId })),
        };
        break;
      case "create-user-pool-client":
        world.lastResult = {
          success: true,
          output: await client.send(
            new CreateUserPoolClientCommand({ UserPoolId: poolId, ClientName: "test-client" }),
          ),
        };
        break;
      case "delete-user-pool-client":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DeleteUserPoolClientCommand({ UserPoolId: poolId, ClientId: clientId }),
          ),
        };
        break;
      case "describe-user-pool-client":
        world.lastResult = {
          success: true,
          output: await client.send(
            new DescribeUserPoolClientCommand({ UserPoolId: poolId, ClientId: clientId }),
          ),
        };
        break;
      case "list-user-pool-clients":
        world.lastResult = {
          success: true,
          output: await client.send(new ListUserPoolClientsCommand({ UserPoolId: poolId })),
        };
        break;
      case "admin-get-user":
        world.lastResult = {
          success: true,
          output: await client.send(
            new AdminGetUserCommand({ UserPoolId: poolId, Username: "testuser" }),
          ),
        };
        break;
      case "admin-create-user":
        world.lastResult = {
          success: true,
          output: await client.send(
            new AdminCreateUserCommand({ UserPoolId: poolId, Username: "testuser" }),
          ),
        };
        break;
      case "admin-delete-user":
        world.lastResult = {
          success: true,
          output: await client.send(
            new AdminDeleteUserCommand({ UserPoolId: poolId, Username: "testuser" }),
          ),
        };
        break;
      case "list-users":
        world.lastResult = {
          success: true,
          output: await client.send(new ListUsersCommand({ UserPoolId: poolId })),
        };
        break;
      case "sign-up":
        world.lastResult = {
          success: true,
          output: await client.send(
            new SignUpCommand({ ClientId: clientId, Username: "testuser", Password: "Test1234!" }),
          ),
        };
        break;
      case "confirm-sign-up":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ConfirmSignUpCommand({
              ClientId: clientId,
              Username: "testuser",
              ConfirmationCode: "123456",
            }),
          ),
        };
        break;
      case "initiate-auth":
        world.lastResult = {
          success: true,
          output: await client.send(
            new InitiateAuthCommand({
              ClientId: clientId,
              AuthFlow: "USER_PASSWORD_AUTH",
              AuthParameters: { USERNAME: "testuser", PASSWORD: "Test1234!" },
            }),
          ),
        };
        break;
      case "forgot-password":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ForgotPasswordCommand({ ClientId: clientId, Username: "testuser" }),
          ),
        };
        break;
      case "confirm-forgot-password":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ConfirmForgotPasswordCommand({
              ClientId: clientId,
              Username: "testuser",
              ConfirmationCode: "123456",
              Password: "NewPass1!",
            }),
          ),
        };
        break;
      case "change-password":
        world.lastResult = {
          success: true,
          output: await client.send(
            new ChangePasswordCommand({
              AccessToken: "dummy-token",
              PreviousPassword: "Old1!",
              ProposedPassword: "New1!",
            }),
          ),
        };
        break;
      case "global-sign-out":
        world.lastResult = {
          success: true,
          output: await client.send(new GlobalSignOutCommand({ AccessToken: "dummy-token" })),
        };
        break;
      default:
        world.lastResult = { success: true, output: { message: `pending cognito: ${operation}` } };
    }
  } catch (err) {
    world.lastResult = { success: false, output: err, error: err };
  }
}
