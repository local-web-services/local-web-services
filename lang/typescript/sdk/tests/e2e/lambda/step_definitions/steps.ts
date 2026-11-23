import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateFunctionCommand,
  DeleteFunctionCommand,
  ListFunctionsCommand,
  InvokeCommand,
} from "@aws-sdk/client-lambda";
import type { LambdaWorld } from "../support/world.js";
import { TEST_FUNCTION_NAME } from "../support/world.js";

const DUMMY_ZIP = Buffer.from("UEsFBgAAAAAAAAAAAAAAAAAAAAAAAA==", "base64");

Given("the lambda system is initialized", function (this: LambdaWorld) {
  // Session started in BeforeAll
});

Given('the "lambda" "function" did not already exist', function (this: LambdaWorld) {
  // Reset in Before hook clears dynamic functions
});

Given('a "lambda" "function" existed', async function (this: LambdaWorld) {
  const result = await this.lambdaClient.send(new CreateFunctionCommand({
    FunctionName: TEST_FUNCTION_NAME,
    Handler: "index.handler",
    Runtime: "nodejs20.x",
    Role: "arn:aws:iam::000000000000:role/lambda-role",
    Code: { ZipFile: DUMMY_ZIP },
  }));
  this.functionArn = result.FunctionArn ?? "";
});

When('a "lambda" "function" is created', async function (this: LambdaWorld) {
  try {
    const result = await this.lambdaClient.send(new CreateFunctionCommand({
      FunctionName: TEST_FUNCTION_NAME,
      Handler: "index.handler",
      Runtime: "nodejs20.x",
      Role: "arn:aws:iam::000000000000:role/lambda-role",
      Code: { ZipFile: DUMMY_ZIP },
    }));
    this.functionArn = result.FunctionArn ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "lambda" "function" is deleted', async function (this: LambdaWorld) {
  try {
    this.result = await this.lambdaClient.send(new DeleteFunctionCommand({
      FunctionName: TEST_FUNCTION_NAME,
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "lambda" "function" is invoked', async function (this: LambdaWorld) {
  try {
    this.result = await this.lambdaClient.send(new InvokeCommand({
      FunctionName: TEST_FUNCTION_NAME,
      Payload: Buffer.from(JSON.stringify({ key: "value" })),
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "lambda" "function" will exist', async function (this: LambdaWorld) {
  const result = await this.lambdaClient.send(new ListFunctionsCommand({}));
  const names = result.Functions?.map((f) => f.FunctionName) ?? [];
  if (!names.includes(TEST_FUNCTION_NAME)) {
    throw new Error(`Expected function '${TEST_FUNCTION_NAME}' to exist but it was not found`);
  }
});

Then('the "lambda" "function" will not exist', async function (this: LambdaWorld) {
  const result = await this.lambdaClient.send(new ListFunctionsCommand({}));
  const names = result.Functions?.map((f) => f.FunctionName) ?? [];
  if (names.includes(TEST_FUNCTION_NAME)) {
    throw new Error(`Expected function '${TEST_FUNCTION_NAME}' to not exist but it was found`);
  }
});

Then("the invocation will succeed", function (this: LambdaWorld) {
  if (this.error !== null) throw this.error;
  const statusCode = (this.result as { StatusCode?: number })?.StatusCode;
  if (statusCode !== 200) {
    throw new Error(`Expected invocation StatusCode 200 but got ${statusCode ?? "(none)"}`);
  }
});
