import { Given, When, Then } from "@cucumber/cucumber";
import {
  PutParameterCommand,
  GetParameterCommand,
  DeleteParameterCommand,
} from "@aws-sdk/client-ssm";
import type { SsmWorld } from "../support/world.js";
import { TEST_PARAM_NAME, TEST_PARAM_VALUE } from "../support/world.js";

Given("the ssm system is initialized", async function (this: SsmWorld) {
  // Session started in BeforeAll
});

Given('the "ssm" "parameter" exists', async function (this: SsmWorld) {
  await this.ssmClient.send(
    new PutParameterCommand({ Name: TEST_PARAM_NAME, Value: TEST_PARAM_VALUE, Type: "String" }),
  );
});

Given('the "ssm" "parameter" does not exist', async function (this: SsmWorld) {
  // After reset(), dynamic parameters are cleared
});

When('a "ssm" "parameter" is stored', async function (this: SsmWorld) {
  try {
    this.result = await this.ssmClient.send(
      new PutParameterCommand({ Name: TEST_PARAM_NAME, Value: TEST_PARAM_VALUE, Type: "String" }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "ssm" "parameter" is retrieved', async function (this: SsmWorld) {
  try {
    this.result = await this.ssmClient.send(
      new GetParameterCommand({ Name: TEST_PARAM_NAME }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('a "ssm" "parameter" is deleted', async function (this: SsmWorld) {
  try {
    this.result = await this.ssmClient.send(
      new DeleteParameterCommand({ Name: TEST_PARAM_NAME }),
    );
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "ssm" "parameter" will exist', async function (this: SsmWorld) {
  const getResult = await this.ssmClient.send(
    new GetParameterCommand({ Name: TEST_PARAM_NAME }),
  );
  const expectedValue = TEST_PARAM_VALUE;
  const actualValue = getResult.Parameter?.Value;
  if (actualValue !== expectedValue) {
    throw new Error(`Expected parameter value '${expectedValue}' but got '${actualValue}'`);
  }
});

Then('the "ssm" "parameter" value will be returned', function (this: SsmWorld) {
  const expectedValue = TEST_PARAM_VALUE;
  const actualValue = (this.result as { Parameter?: { Value?: string } } | null)?.Parameter?.Value;
  if (actualValue !== expectedValue) {
    throw new Error(`Expected '${expectedValue}' but got '${actualValue}'`);
  }
});

Then('the "ssm" "parameter" will not exist', async function (this: SsmWorld) {
  let actualError: Error | null = null;
  try {
    await this.ssmClient.send(new GetParameterCommand({ Name: TEST_PARAM_NAME }));
  } catch (err) {
    actualError = err instanceof Error ? err : new Error(String(err));
  }
  if (actualError === null) {
    throw new Error("Expected parameter to not exist but GetParameter succeeded");
  }
});

Then("the ssm operation is rejected", function (this: SsmWorld) {
  if (this.error === null) {
    throw new Error("Expected an error but none was thrown");
  }
});
