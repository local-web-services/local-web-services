import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateSecretCommand,
  GetSecretValueCommand,
  DeleteSecretCommand,
} from "@aws-sdk/client-secrets-manager";
import type { SecretsWorld } from "../support/world.js";
import { TEST_SECRET_NAME, TEST_SECRET_VALUE } from "../support/world.js";

Given("the secrets system is initialized", async function (this: SecretsWorld) {
  // Session started in BeforeAll
});

Given('the "secrets" "secret" already exists', async function (this: SecretsWorld) {
  await this.secretsClient.send(
    new CreateSecretCommand({ Name: TEST_SECRET_NAME, SecretString: TEST_SECRET_VALUE }),
  );
});

Given('the "secrets" "secret" does not exist', async function (this: SecretsWorld) {
  // After reset(), dynamic secrets are cleared
});

When('a "secrets" "secret" is created', async function (this: SecretsWorld) {
  try {
    this.result = await this.secretsClient.send(
      new CreateSecretCommand({ Name: TEST_SECRET_NAME, SecretString: TEST_SECRET_VALUE }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "secrets" "secret" value is retrieved', async function (this: SecretsWorld) {
  try {
    this.result = await this.secretsClient.send(
      new GetSecretValueCommand({ SecretId: TEST_SECRET_NAME }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "secrets" "secret" is deleted', async function (this: SecretsWorld) {
  try {
    this.result = await this.secretsClient.send(
      new DeleteSecretCommand({ SecretId: TEST_SECRET_NAME, ForceDeleteWithoutRecovery: true }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "secrets" "secret" will exist', async function (this: SecretsWorld) {
  const getResult = await this.secretsClient.send(
    new GetSecretValueCommand({ SecretId: TEST_SECRET_NAME }),
  );
  const expectedValue = TEST_SECRET_VALUE;
  const actualValue = getResult.SecretString;
  if (actualValue !== expectedValue) {
    throw new Error(`Expected secret value '${expectedValue}' but got '${actualValue}'`);
  }
});

Then('the "secrets" "secret" value will be returned', function (this: SecretsWorld) {
  const expectedValue = TEST_SECRET_VALUE;
  const actualValue = (this.result as { SecretString?: string } | null)?.SecretString;
  if (actualValue !== expectedValue) {
    throw new Error(`Expected '${expectedValue}' but got '${actualValue}'`);
  }
});

Then('the "secrets" "secret" will not exist', async function (this: SecretsWorld) {
  let actualError: Error | null = null;
  try {
    await this.secretsClient.send(new GetSecretValueCommand({ SecretId: TEST_SECRET_NAME }));
  } catch (err) {
    actualError = err instanceof Error ? err : new Error(String(err));
  }
  if (actualError === null) {
    throw new Error("Expected secret to not exist but GetSecretValue succeeded");
  }
});

Then("the secrets operation is rejected", function (this: SecretsWorld) {
  if (this.error === null) {
    throw new Error("Expected an error but none was thrown");
  }
});
