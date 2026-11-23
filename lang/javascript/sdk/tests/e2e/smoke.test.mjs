import { LwsSession, SqsQueue, DynamoTable, CognitoUserPool, LambdaFunction } from "../../dist/index.js";
import { SQSClient, SendMessageCommand, ReceiveMessageCommand } from "@aws-sdk/client-sqs";
import { DynamoDBClient, PutItemCommand, GetItemCommand } from "@aws-sdk/client-dynamodb";
import { CognitoIdentityProviderClient, CreateUserPoolCommand, AdminCreateUserCommand, CreateUserPoolClientCommand, InitiateAuthCommand } from "@aws-sdk/client-cognito-identity-provider";
import { LambdaClient, CreateFunctionCommand, ListFunctionsCommand } from "@aws-sdk/client-lambda";
import assert from "assert";

async function testSqs() {
  const session = new LwsSession(new SqsQueue("smoke-queue"));
  await session.start();
  try {
    const cfg = session.clientConfig("sqs");
    const client = new SQSClient(cfg);
    const queueUrl = session.queueUrl("smoke-queue");
    await client.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "hello" }));
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
    );
    assert.strictEqual(result.Messages?.length, 1);
    assert.strictEqual(result.Messages[0].Body, "hello");
    console.log("✓ SQS smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testDynamoDB() {
  const session = new LwsSession(new DynamoTable("smoke-table", "pk"));
  await session.start();
  try {
    const cfg = session.clientConfig("dynamodb");
    const client = new DynamoDBClient(cfg);
    await client.send(
      new PutItemCommand({
        TableName: "smoke-table",
        Item: { pk: { S: "test-key" }, value: { S: "test-value" } },
      }),
    );
    const result = await client.send(
      new GetItemCommand({
        TableName: "smoke-table",
        Key: { pk: { S: "test-key" } },
      }),
    );
    assert.strictEqual(result.Item?.value?.S, "test-value");
    console.log("✓ DynamoDB smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testCognito() {
  const session = new LwsSession(new CognitoUserPool("smoke-pool"));
  await session.start();
  try {
    const cfg = session.clientConfig("cognito-idp");
    const client = new CognitoIdentityProviderClient(cfg);
    const pool = await client.send(new CreateUserPoolCommand({ PoolName: "cognito-smoke-pool" }));
    const poolId = pool.UserPool?.Id;
    assert.ok(typeof poolId === "string", "Expected poolId to be a string");
    const clientResult = await client.send(
      new CreateUserPoolClientCommand({ UserPoolId: poolId, ClientName: "smoke-client" }),
    );
    const clientId = clientResult.UserPoolClient?.ClientId;
    assert.ok(typeof clientId === "string", "Expected clientId to be a string");
    await client.send(
      new AdminCreateUserCommand({ UserPoolId: poolId, Username: "smoke-user", TemporaryPassword: "Pass1!" }),
    );
    const auth = await client.send(
      new InitiateAuthCommand({
        ClientId: clientId,
        AuthFlow: "USER_PASSWORD_AUTH",
        AuthParameters: { USERNAME: "smoke-user", PASSWORD: "Pass1!" },
      }),
    );
    assert.ok(typeof auth.AuthenticationResult?.AccessToken === "string", "Expected AccessToken");
    console.log("✓ Cognito smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testLambda() {
  const session = new LwsSession(new LambdaFunction("smoke-fn", "index.handler"));
  await session.start();
  try {
    const cfg = session.clientConfig("lambda");
    const client = new LambdaClient(cfg);
    const dummyZip = Buffer.from("UEsFBgAAAAAAAAAAAAAAAAAAAAAAAA==", "base64");
    await client.send(
      new CreateFunctionCommand({
        FunctionName: "esm-smoke-fn",
        Handler: "index.handler",
        Runtime: "nodejs20.x",
        Role: "arn:aws:iam::000000000000:role/lambda-role",
        Code: { ZipFile: dummyZip },
      }),
    );
    const list = await client.send(new ListFunctionsCommand({}));
    const names = list.Functions?.map((f) => f.FunctionName) ?? [];
    assert.ok(names.includes("esm-smoke-fn"), "Expected esm-smoke-fn in function list");
    console.log("✓ Lambda smoke test passed");
  } finally {
    await session.stop();
  }
}

await testSqs();
await testDynamoDB();
await testCognito();
await testLambda();
console.log("All ESM smoke tests passed");
