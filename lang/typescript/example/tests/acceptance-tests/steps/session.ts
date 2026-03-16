import { Given } from '@cucumber/cucumber';
import { LwsSession } from 'local-web-services-typescript-sdk';
import {
  SFNClient,
  ListStateMachinesCommand,
  CreateStateMachineCommand,
  StateMachineType,
} from '@aws-sdk/client-sfn';
import {
  DynamoDBClient,
  CreateTableCommand,
  BillingMode,
  KeyType,
  ScalarAttributeType,
} from '@aws-sdk/client-dynamodb';
import { SQSClient, CreateQueueCommand } from '@aws-sdk/client-sqs';
import { OrderWorld } from '../support/world';

const ORDER_PROCESSOR_DEFINITION = JSON.stringify({
  Comment: 'Simple order processor — passes input through as output',
  StartAt: 'ProcessOrder',
  States: {
    ProcessOrder: { Type: 'Pass', End: true },
  },
});

Given('an OrderProcessor state machine is running', async function (this: OrderWorld) {
  this.sfnClient = this.session!.client<SFNClient>('stepfunctions');
  await this.sfnClient.send(new CreateStateMachineCommand({
    name: 'OrderProcessor',
    definition: ORDER_PROCESSOR_DEFINITION,
    roleArn: 'arn:aws:iam::000000000000:role/StepFunctionsRole',
    type: StateMachineType.STANDARD,
  }));
  const { stateMachines } = await this.sfnClient.send(new ListStateMachinesCommand({}));
  this.stateMachineArn = stateMachines![0].stateMachineArn!;
});

Given('no state machines are configured', async function (this: OrderWorld) {
  this.sfnClient = this.session!.client<SFNClient>('stepfunctions');
});

Given('a session started from the {string} HCL directory', async function (this: OrderWorld, dir: string) {
  this.session = await LwsSession.fromHcl(dir);
  this.sfnClient = this.session.client<SFNClient>('stepfunctions');
  const { stateMachines } = await this.sfnClient.send(new ListStateMachinesCommand({}));
  this.stateMachineArn = stateMachines![0].stateMachineArn!;
});

Given('a DynamoDB table {string} with partition key {string}', async function (this: OrderWorld, name: string, partitionKey: string) {
  const ddbClient = this.session!.client<DynamoDBClient>('dynamodb');
  await ddbClient.send(new CreateTableCommand({
    TableName: name,
    KeySchema: [{ AttributeName: partitionKey, KeyType: KeyType.HASH }],
    AttributeDefinitions: [{ AttributeName: partitionKey, AttributeType: ScalarAttributeType.S }],
    BillingMode: BillingMode.PAY_PER_REQUEST,
  }));
  this.ddbHelper = this.session!.dynamodb(name);
});

Given('an SQS queue named {string}', async function (this: OrderWorld, name: string) {
  const sqsClient = this.session!.client<SQSClient>('sqs');
  await sqsClient.send(new CreateQueueCommand({ QueueName: name }));
  this.sqsHelper = this.session!.sqs(name);
});
