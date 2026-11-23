"use strict";
const { LwsSession, SqsQueue, CognitoUserPool, LambdaFunction } = require("../../dist/index.cjs");
const { SQSClient, SendMessageCommand, ReceiveMessageCommand } = require("@aws-sdk/client-sqs");
const { CognitoIdentityProviderClient, CreateUserPoolCommand, AdminCreateUserCommand, CreateUserPoolClientCommand, InitiateAuthCommand } = require("@aws-sdk/client-cognito-identity-provider");
const { LambdaClient, CreateFunctionCommand, ListFunctionsCommand } = require("@aws-sdk/client-lambda");
const assert = require("assert");

async function testSqs() {
  const session = new LwsSession(new SqsQueue("cjs-smoke-queue"));
  await session.start();
  try {
    const cfg = session.clientConfig("sqs");
    const client = new SQSClient(cfg);
    const queueUrl = session.queueUrl("cjs-smoke-queue");
    await client.send(new SendMessageCommand({ QueueUrl: queueUrl, MessageBody: "cjs-hello" }));
    const result = await client.send(
      new ReceiveMessageCommand({ QueueUrl: queueUrl, MaxNumberOfMessages: 1 }),
    );
    assert.strictEqual(result.Messages?.length, 1);
    assert.strictEqual(result.Messages[0].Body, "cjs-hello");
    console.log("✓ CJS SQS smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testCognito() {
  const session = new LwsSession(new CognitoUserPool("cjs-smoke-pool"));
  await session.start();
  try {
    const cfg = session.clientConfig("cognito-idp");
    const client = new CognitoIdentityProviderClient(cfg);
    const pool = await client.send(new CreateUserPoolCommand({ PoolName: "cjs-cognito-pool" }));
    const poolId = pool.UserPool?.Id;
    assert.ok(typeof poolId === "string", "Expected poolId to be a string");
    const clientResult = await client.send(
      new CreateUserPoolClientCommand({ UserPoolId: poolId, ClientName: "cjs-client" }),
    );
    const clientId = clientResult.UserPoolClient?.ClientId;
    assert.ok(typeof clientId === "string", "Expected clientId to be a string");
    await client.send(
      new AdminCreateUserCommand({ UserPoolId: poolId, Username: "cjs-user", TemporaryPassword: "Pass1!" }),
    );
    const auth = await client.send(
      new InitiateAuthCommand({
        ClientId: clientId,
        AuthFlow: "USER_PASSWORD_AUTH",
        AuthParameters: { USERNAME: "cjs-user", PASSWORD: "Pass1!" },
      }),
    );
    assert.ok(typeof auth.AuthenticationResult?.AccessToken === "string", "Expected AccessToken");
    console.log("✓ CJS Cognito smoke test passed");
  } finally {
    await session.stop();
  }
}

async function testLambda() {
  const session = new LwsSession(new LambdaFunction("cjs-smoke-fn", "index.handler"));
  await session.start();
  try {
    const cfg = session.clientConfig("lambda");
    const client = new LambdaClient(cfg);
    const dummyZip = Buffer.from("UEsFBgAAAAAAAAAAAAAAAAAAAAAAAA==", "base64");
    await client.send(
      new CreateFunctionCommand({
        FunctionName: "cjs-lambda-fn",
        Handler: "index.handler",
        Runtime: "nodejs20.x",
        Role: "arn:aws:iam::000000000000:role/lambda-role",
        Code: { ZipFile: dummyZip },
      }),
    );
    const list = await client.send(new ListFunctionsCommand({}));
    const names = (list.Functions || []).map((f) => f.FunctionName);
    assert.ok(names.includes("cjs-lambda-fn"), "Expected cjs-lambda-fn in function list");
    console.log("✓ CJS Lambda smoke test passed");
  } finally {
    await session.stop();
  }
}

testSqs()
  .then(() => testCognito())
  .then(() => testLambda())
  .then(() => {
    console.log("All CJS smoke tests passed");
  });
