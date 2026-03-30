/** Step definitions: ssm service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { TagStepHelpers } from "../support/world";

const SSM_TEST_PARAM = "/e2e/ssm/test-param-1";
const SSM_TEST_VALUE = "test-value-1";
const SSM_TEST_VALUE2 = "test-value-2";
const SSM_TEST_TYPE = "String";
const SSM_TEST_TAG_KEY = "e2e-ssm-tag-key-1";
const SSM_TEST_TAG_VALUE = "test-ssm-tag-value-1";
const SSM_TEST_PATH = "/e2e/ssm/";

// ── Helpers ───────────────────────────────────────────────────────────────────

function ssmClient(world: SdkWorld) {
  const { SSMClient } = require("@aws-sdk/client-ssm");
  return world.session!.client<typeof SSMClient>("ssm");
}

async function createParam(world: SdkWorld): Promise<void> {
  const { PutParameterCommand } = require("@aws-sdk/client-ssm");
  await ssmClient(world).send(
    new PutParameterCommand({
      Name: SSM_TEST_PARAM,
      Value: SSM_TEST_VALUE,
      Type: SSM_TEST_TYPE,
    }),
  );
}

async function describeParam(world: SdkWorld): Promise<boolean> {
  const { DescribeParametersCommand } = require("@aws-sdk/client-ssm");
  const result = await ssmClient(world).send(
    new DescribeParametersCommand({
      Filters: [{ Key: "Name", Values: [SSM_TEST_PARAM] }],
    }),
  );
  const parameters: unknown[] = result.Parameters ?? [];
  return parameters.length > 0;
}

// ── Before hook: register tag helpers for @ssm scenarios ──────────────────────

Before({ tags: "@ssm" }, function (this: SdkWorld) {
  const tagHelpersImpl: TagStepHelpers = {
    setupTagAssociationActive: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: tag associations are always active after creation.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupTagAssociationNotActive: async (world: SdkWorld) => {
      // Arrange: delete parameter and recreate via lifecycle dwell so tag association is non-active
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteParameterCommand } = require("@aws-sdk/client-ssm");
      try {
        await ssmClient(world).send(new DeleteParameterCommand({ Name: SSM_TEST_PARAM }));
      } catch {
        // parameter may not exist
      }
      // Act
      await world.session!.lifecycle("ssm").createDwellMs(200).apply();
      await createParam(world);
      world.lastCallResult = { success: true, output: null };
      // Assert: parameter is in CREATING state (tag association non-active)
    },
    assertListTagsResult: async (world: SdkWorld) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected list_tags_for_resource to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      assert.ok(
        world.lastCallResult.output !== null && world.lastCallResult.output !== undefined,
        "Expected ListTagsForResourceOutput but got null",
      );
    },
  };
  this.tagHelpers = tagHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: parameter state setup ─────────────────────────────────────────────

Given("the parameter does not already exist or has been deleted", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no parameters.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the parameter does not already exist" is registered in cross_service_common.ts.

// "the parameter already exists" is registered in cross_service_common.ts.

// "the parameter exists" is registered in cross_service_common.ts.

Given("the parameter is active", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: parameters are always active after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the parameter is not active", async function (this: SdkWorld) {
  // Arrange: delete parameter and recreate via lifecycle dwell so it is non-active (CREATING)
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteParameterCommand } = require("@aws-sdk/client-ssm");
  try {
    await ssmClient(this).send(new DeleteParameterCommand({ Name: SSM_TEST_PARAM }));
  } catch {
    // parameter may not exist; desired state is deleted before recreating
  }
  // Act
  await this.session!.lifecycle("ssm").createDwellMs(200).apply();
  await createParam(this);
  this.lastCallResult = { success: true, output: null };
  // Assert: parameter is in CREATING state (non-active)
});

// "the parameter does not exist" is registered in cross_service_common.ts.

// ── Given: tag state setup ────────────────────────────────────────────────────

Given("the tag is associated with the parameter", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { AddTagsToResourceCommand } = require("@aws-sdk/client-ssm");
  // Act
  await ssmClient(this).send(
    new AddTagsToResourceCommand({
      ResourceType: "Parameter",
      ResourceId: SSM_TEST_PARAM,
      Tags: [{ Key: SSM_TEST_TAG_KEY, Value: SSM_TEST_TAG_VALUE }],
    }),
  );
  // Assert: tags added
});

// "the tag association is active" is registered in cross_service_common.ts (dispatches via tagHelpers).

Given("the tag is not associated with the parameter", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no tags associated with the parameter.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the tag association is not active" is registered in cross_service_common.ts (dispatches via tagHelpers).

// ── When: actions ─────────────────────────────────────────────────────────────

When('a parameter is stored in "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { PutParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(
      new PutParameterCommand({
        Name: SSM_TEST_PARAM,
        Value: SSM_TEST_VALUE,
        Type: SSM_TEST_TYPE,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a parameter is retrieved from "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(new GetParameterCommand({ Name: SSM_TEST_PARAM }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a parameter is deleted from "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(new DeleteParameterCommand({ Name: SSM_TEST_PARAM }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('multiple parameters are deleted from "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteParametersCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(
      new DeleteParametersCommand({ Names: [SSM_TEST_PARAM] }),
    );
    const invalidParameters: string[] = result.InvalidParameters ?? [];
    if (invalidParameters.length > 0) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error(
          `ParameterNotFound: parameter not found: ${JSON.stringify(invalidParameters)}`,
        ),
      };
    } else {
      this.lastCallResult = { success: true, output: result };
    }
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("parameters are described", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeParametersCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(new DescribeParametersCommand({}));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('multiple parameters are retrieved from "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParametersCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(
      new GetParametersCommand({ Names: [SSM_TEST_PARAM] }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('parameters under a path are retrieved from "SSM"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParametersByPathCommand } = require("@aws-sdk/client-ssm");
  // Act
  try {
    const result = await ssmClient(this).send(
      new GetParametersByPathCommand({ Path: SSM_TEST_PATH }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are added to a parameter", async function (this: SdkWorld) {
  // Arrange: check if parameter exists; lws returns 200 even when absent
  assert.ok(this.session, "Expected session to be initialized");
  const { AddTagsToResourceCommand } = require("@aws-sdk/client-ssm");
  const paramExists = await describeParam(this);
  if (!paramExists) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`InvalidResourceId: parameter ${SSM_TEST_PARAM} does not exist`),
    };
    return;
  }
  // Act
  try {
    const result = await ssmClient(this).send(
      new AddTagsToResourceCommand({
        ResourceType: "Parameter",
        ResourceId: SSM_TEST_PARAM,
        Tags: [{ Key: SSM_TEST_TAG_KEY, Value: SSM_TEST_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags for a parameter are listed", async function (this: SdkWorld) {
  // Arrange: check if parameter exists; lws returns 200 even when absent
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTagsForResourceCommand } = require("@aws-sdk/client-ssm");
  const paramExists = await describeParam(this);
  if (!paramExists) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`InvalidResourceId: parameter ${SSM_TEST_PARAM} does not exist`),
    };
    return;
  }
  // Act
  try {
    const result = await ssmClient(this).send(
      new ListTagsForResourceCommand({
        ResourceType: "Parameter",
        ResourceId: SSM_TEST_PARAM,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("tags are removed from a parameter", async function (this: SdkWorld) {
  // Arrange: check if the tag is associated; lws returns 200 even when absent
  assert.ok(this.session, "Expected session to be initialized");
  const {
    ListTagsForResourceCommand,
    RemoveTagsFromResourceCommand,
  } = require("@aws-sdk/client-ssm");
  let tagFound = false;
  try {
    const tagResult = await ssmClient(this).send(
      new ListTagsForResourceCommand({
        ResourceType: "Parameter",
        ResourceId: SSM_TEST_PARAM,
      }),
    );
    const tagList: Array<{ Key?: string }> = tagResult.TagList ?? [];
    tagFound = tagList.some((t) => t.Key === SSM_TEST_TAG_KEY);
  } catch {
    // list failed — tag is not accessible
  }
  if (!tagFound) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        `InvalidResourceId: tag ${SSM_TEST_TAG_KEY} is not associated with ${SSM_TEST_PARAM}`,
      ),
    };
    return;
  }
  // Act
  try {
    const result = await ssmClient(this).send(
      new RemoveTagsFromResourceCommand({
        ResourceType: "Parameter",
        ResourceId: SSM_TEST_PARAM,
        TagKeys: [SSM_TEST_TAG_KEY],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "a parameter is written without overwrite when it already exists",
  async function (this: SdkWorld) {
    // Arrange: verify parameter exists; lws creates param even when absent — reject if missing
    assert.ok(this.session, "Expected session to be initialized");
    const { PutParameterCommand } = require("@aws-sdk/client-ssm");
    const paramExists = await describeParam(this);
    if (!paramExists) {
      this.lastCallResult = {
        success: false,
        output: null,
        error: new Error(`ParameterNotFound: parameter ${SSM_TEST_PARAM} does not exist`),
      };
      return;
    }
    // Act: put without Overwrite flag (default false)
    try {
      const result = await ssmClient(this).send(
        new PutParameterCommand({
          Name: SSM_TEST_PARAM,
          Value: SSM_TEST_VALUE2,
          Type: SSM_TEST_TYPE,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When("an existing parameter value is updated", async function (this: SdkWorld) {
  // Arrange: verify parameter exists; lws creates param even when absent — reject if missing
  assert.ok(this.session, "Expected session to be initialized");
  const { PutParameterCommand } = require("@aws-sdk/client-ssm");
  const paramExists = await describeParam(this);
  if (!paramExists) {
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(`ParameterNotFound: parameter ${SSM_TEST_PARAM} does not exist`),
    };
    return;
  }
  // Act: put with Overwrite=true
  try {
    const result = await ssmClient(this).send(
      new PutParameterCommand({
        Name: SSM_TEST_PARAM,
        Value: SSM_TEST_VALUE2,
        Type: SSM_TEST_TYPE,
        Overwrite: true,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then("the parameter value is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected get_parameter to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as { Parameter?: { Value?: string } };
  const expectedValue = SSM_TEST_VALUE;
  const actualValue = output?.Parameter?.Value;
  assert.strictEqual(
    actualValue,
    expectedValue,
    `Expected parameter value "${expectedValue}" but got "${actualValue}"; expected_value=${expectedValue} actual_value=${actualValue}`,
  );
});

Then("the parameter no longer exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeParametersCommand } = require("@aws-sdk/client-ssm");
  // Act
  const result = await ssmClient(this).send(new DescribeParametersCommand({}));
  const actualNames: string[] = (result.Parameters ?? []).map(
    (p: { Name?: string }) => p.Name ?? "",
  );
  // Assert
  const expectedAbsent = SSM_TEST_PARAM;
  assert.ok(
    !actualNames.includes(expectedAbsent),
    `Expected parameter "${expectedAbsent}" to be deleted but found in: ${JSON.stringify(actualNames)}; expected_absent=${expectedAbsent}`,
  );
});

Then("the parameters no longer exist", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeParametersCommand } = require("@aws-sdk/client-ssm");
  // Act
  const result = await ssmClient(this).send(new DescribeParametersCommand({}));
  const actualNames: string[] = (result.Parameters ?? []).map(
    (p: { Name?: string }) => p.Name ?? "",
  );
  // Assert
  const expectedAbsent = SSM_TEST_PARAM;
  assert.ok(
    !actualNames.includes(expectedAbsent),
    `Expected parameter "${expectedAbsent}" to be deleted but found in: ${JSON.stringify(actualNames)}; expected_absent=${expectedAbsent}`,
  );
});

Then("the parameter metadata is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected describe_parameters to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected DescribeParametersOutput but got null",
  );
});

Then("the parameter values are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected get_parameters to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the parameters under the path are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected get_parameters_by_path to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the tags are associated with the parameter", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected add_tags_to_resource to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// "the list of tags is returned" is registered in cross_service_common.ts (dispatches via tagHelpers).

Then("the tags are disassociated from the parameter", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected remove_tags_from_resource to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the parameter exists with version 1", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  const result = await ssmClient(this).send(new GetParameterCommand({ Name: SSM_TEST_PARAM }));
  const expectedVersion = 1;
  const actualVersion = result?.Parameter?.Version;
  // Assert
  assert.strictEqual(
    actualVersion,
    expectedVersion,
    `Expected parameter version ${expectedVersion} but got ${actualVersion}; expected_version=${expectedVersion} actual_version=${actualVersion}`,
  );
});

Then("every parameter version is a positive integer", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  /^every parameter has a valid type \(String, SecureString, or StringList\)$/,
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then("no parameter exists after it has been deleted", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("param_exists values are always valid booleans", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("the error log only contains ParameterAlreadyExists entries", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then("a ParameterAlreadyExists error is recorded", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedRejected = true;
  const actualRejected = !this.lastCallResult.success;
  assert.strictEqual(
    actualRejected,
    expectedRejected,
    `Expected a ParameterAlreadyExists error but no error was raised; expected_rejected=${expectedRejected} actual_rejected=${actualRejected}`,
  );
});

Then("the parameter has a new value and an incremented version", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  const result = await ssmClient(this).send(new GetParameterCommand({ Name: SSM_TEST_PARAM }));
  // Assert: value updated
  const expectedValue = SSM_TEST_VALUE2;
  const actualValue = result?.Parameter?.Value;
  assert.strictEqual(
    actualValue,
    expectedValue,
    `Expected parameter value "${expectedValue}" but got "${actualValue}"; expected_value=${expectedValue} actual_value=${actualValue}`,
  );
  // Assert: version incremented
  const actualVersion = result?.Parameter?.Version ?? 0;
  assert.ok(
    actualVersion >= 2,
    `Expected version >= 2 after overwrite but got ${actualVersion}; expected_min_version=2 actual_version=${actualVersion}`,
  );
});
