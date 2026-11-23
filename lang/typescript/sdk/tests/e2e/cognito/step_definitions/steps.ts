import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateUserPoolCommand,
  ListUserPoolsCommand,
  CreateUserPoolClientCommand,
  AdminCreateUserCommand,
  AdminGetUserCommand,
  InitiateAuthCommand,
} from "@aws-sdk/client-cognito-identity-provider";
import type { CognitoWorld } from "../support/world.js";
import { TEST_POOL_NAME, TEST_USERNAME, TEST_PASSWORD } from "../support/world.js";

Given("the cognito system is initialized", function (this: CognitoWorld) {
  // Session started in BeforeAll
});

Given('the "cognito" "user pool" did not already exist', function (this: CognitoWorld) {
  // Reset in Before hook clears dynamic pools
});

Given('a "cognito" "user pool" existed', async function (this: CognitoWorld) {
  const result = await this.cognitoClient.send(new CreateUserPoolCommand({ PoolName: TEST_POOL_NAME }));
  this.poolId = result.UserPool?.Id ?? "";
});

Given('a "cognito" "app client" existed', async function (this: CognitoWorld) {
  const result = await this.cognitoClient.send(new CreateUserPoolClientCommand({
    UserPoolId: this.poolId,
    ClientName: "e2e-client",
  }));
  this.clientId = result.UserPoolClient?.ClientId ?? "";
});

Given('a "cognito" "user" existed in the pool', async function (this: CognitoWorld) {
  await this.cognitoClient.send(new AdminCreateUserCommand({
    UserPoolId: this.poolId,
    Username: TEST_USERNAME,
    TemporaryPassword: TEST_PASSWORD,
  }));
});

When('a "cognito" "user pool" is created', async function (this: CognitoWorld) {
  try {
    const result = await this.cognitoClient.send(new CreateUserPoolCommand({ PoolName: TEST_POOL_NAME }));
    this.poolId = result.UserPool?.Id ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "cognito" "user" is created in the pool', async function (this: CognitoWorld) {
  try {
    this.result = await this.cognitoClient.send(new AdminCreateUserCommand({
      UserPoolId: this.poolId,
      Username: TEST_USERNAME,
      TemporaryPassword: TEST_PASSWORD,
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "cognito" "user" authenticates', async function (this: CognitoWorld) {
  try {
    const result = await this.cognitoClient.send(new InitiateAuthCommand({
      ClientId: this.clientId,
      AuthFlow: "USER_PASSWORD_AUTH",
      AuthParameters: { USERNAME: TEST_USERNAME, PASSWORD: TEST_PASSWORD },
    }));
    this.accessToken = result.AuthenticationResult?.AccessToken ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "cognito" "user pool" will exist', async function (this: CognitoWorld) {
  const result = await this.cognitoClient.send(new ListUserPoolsCommand({ MaxResults: 60 }));
  const names = result.UserPools?.map((p) => p.Name) ?? [];
  if (!names.includes(TEST_POOL_NAME)) {
    throw new Error(`Expected pool '${TEST_POOL_NAME}' to exist but it was not found`);
  }
});

Then('the "cognito" "user" will exist in the pool', async function (this: CognitoWorld) {
  const result = await this.cognitoClient.send(new AdminGetUserCommand({
    UserPoolId: this.poolId,
    Username: TEST_USERNAME,
  }));
  if (result.Username !== TEST_USERNAME) {
    throw new Error(`Expected user '${TEST_USERNAME}' but got '${result.Username ?? "(none)"}'`);
  }
});

Then("the authentication result will contain an access token", function (this: CognitoWorld) {
  if (this.error !== null) throw this.error;
  if (!this.accessToken) {
    throw new Error("Expected an AccessToken but got none");
  }
});
