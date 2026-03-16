'use strict';

/**
 * Step definitions for session setup — creating state machines and resources.
 */

const { Given } = require('@cucumber/cucumber');
const fs = require('fs');
const path = require('path');

Given('an OrderProcessor state machine is running', { timeout: 15000 }, async function () {
  const { CreateStateMachineCommand, ListStateMachinesCommand } = require('@aws-sdk/client-sfn');

  this.sfnClient = this.createSFNClient();

  const definition = JSON.stringify({
    Comment: 'Simple order processor — passes input through as output',
    StartAt: 'ProcessOrder',
    States: {
      ProcessOrder: { Type: 'Pass', End: true },
    },
  });

  const defaultArn = 'arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor';

  try {
    const result = await this.sfnClient.send(new CreateStateMachineCommand({
      name: 'OrderProcessor',
      definition,
      roleArn: 'arn:aws:iam::000000000000:role/StepFunctionsRole',
      type: 'STANDARD',
    }));
    this.stateMachineArn = result.stateMachineArn;
  } catch (err) {
    if (err.name === 'StateMachineAlreadyExists' || (err.message || '').includes('already exists')) {
      try {
        const list = await this.sfnClient.send(new ListStateMachinesCommand({}));
        const found = (list.stateMachines || []).find((m) => m.name === 'OrderProcessor');
        this.stateMachineArn = found ? found.stateMachineArn : defaultArn;
      } catch (_) {
        this.stateMachineArn = defaultArn;
      }
    } else {
      throw err;
    }
  }
});

Given('no state machines are configured', { timeout: 15000 }, async function () {
  // Just ensure the SFN client is ready; no state machine is created.
  this.sfnClient = this.createSFNClient();
  this.stateMachineArn = null;
});

Given('a session started from the {string} HCL directory', { timeout: 15000 }, async function (hclDir) {
  const { CreateStateMachineCommand } = require('@aws-sdk/client-sfn');

  this.sfnClient = this.createSFNClient();

  // Resolve path relative to the example project root.
  const projectRoot = path.resolve(__dirname, '..', '..', '..');
  const terraformDir = path.join(projectRoot, hclDir);

  // Read all .tf files and extract state machine definitions.
  const tfFiles = fs.readdirSync(terraformDir).filter((f) => f.endsWith('.tf'));
  let stateMachineName = null;
  let stateMachineDefinition = null;
  let roleArn = 'arn:aws:iam::000000000000:role/StepFunctionsRole';

  for (const tfFile of tfFiles) {
    const content = fs.readFileSync(path.join(terraformDir, tfFile), 'utf8');

    // Extract state machine name.
    const nameMatch = content.match(/name\s*=\s*"([^"]+)"/);
    if (nameMatch) {
      stateMachineName = nameMatch[1];
    }

    // Extract role ARN if present.
    const roleMatch = content.match(/role_arn\s*=\s*"([^"]+)"/);
    if (roleMatch) {
      roleArn = roleMatch[1];
    }

    // Extract definition from heredoc (<<EOF...EOF or <<-EOF...EOF).
    const heredocMatch = content.match(/definition\s*=\s*<<-?EOF\s*([\s\S]*?)\s*EOF/);
    if (heredocMatch) {
      stateMachineDefinition = heredocMatch[1].trim();
    }
  }

  if (!stateMachineName || !stateMachineDefinition) {
    throw new Error(`Could not parse state machine name/definition from HCL directory: ${terraformDir}`);
  }

  // Validate the definition is parseable JSON.
  try {
    JSON.parse(stateMachineDefinition);
  } catch (e) {
    throw new Error(`State machine definition from HCL is not valid JSON: ${e.message}`);
  }

  const defaultArn = `arn:aws:states:us-east-1:000000000000:stateMachine:${stateMachineName}`;

  try {
    const result = await this.sfnClient.send(new CreateStateMachineCommand({
      name: stateMachineName,
      definition: stateMachineDefinition,
      roleArn,
      type: 'STANDARD',
    }));
    this.stateMachineArn = result.stateMachineArn;
  } catch (err) {
    if (err.name === 'StateMachineAlreadyExists' || (err.message || '').includes('already exists')) {
      this.stateMachineArn = defaultArn;
    } else {
      throw err;
    }
  }
});

Given('a DynamoDB table {string} with partition key {string}', { timeout: 15000 }, async function (tableName, partitionKey) {
  const { CreateTableCommand } = require('@aws-sdk/client-dynamodb');
  const { DynamoDBHelper } = require('local-web-services-javascript-sdk/src/resources/dynamodb');

  const ddbClient = this.createDynamoDBClient();

  try {
    await ddbClient.send(new CreateTableCommand({
      TableName: tableName,
      KeySchema: [{ AttributeName: partitionKey, KeyType: 'HASH' }],
      AttributeDefinitions: [{ AttributeName: partitionKey, AttributeType: 'S' }],
      BillingMode: 'PAY_PER_REQUEST',
    }));
  } catch (err) {
    if (!(err.name === 'ResourceInUseException' || (err.message || '').includes('already exists'))) {
      throw err;
    }
  }

  this.ddbHelper = new DynamoDBHelper(tableName, ddbClient);
});

Given('an SQS queue named {string}', { timeout: 15000 }, async function (queueName) {
  const { CreateQueueCommand } = require('@aws-sdk/client-sqs');
  const { SQSHelper } = require('local-web-services-javascript-sdk/src/resources/sqs');

  const sqsClient = this.createSQSClient();

  try {
    await sqsClient.send(new CreateQueueCommand({ QueueName: queueName }));
  } catch (err) {
    if (!(err.name === 'QueueAlreadyExists' || (err.message || '').includes('already exists'))) {
      throw err;
    }
  }

  this.sqsHelper = new SQSHelper(queueName, sqsClient, this.sqsPort());
});
