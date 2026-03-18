/** SSM step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  PutParameterCommand,
  GetParameterCommand,
  GetParametersCommand,
  GetParametersByPathCommand,
  DeleteParameterCommand,
  DeleteParametersCommand,
  DescribeParametersCommand,
  AddTagsToResourceCommand,
  RemoveTagsFromResourceCommand,
  ListTagsForResourceCommand,
} from "@aws-sdk/client-ssm";
import type { LwsWorld } from "../support/world";

async function putParameter(
  world: LwsWorld,
  name: string,
  value: string,
  type: string,
): Promise<void> {
  const client = world.ssmClient();
  await client.send(
    new PutParameterCommand({
      Name: name,
      Value: value,
      Type: type as "String" | "SecureString" | "StringList",
    }),
  );
}

// --- Given -----------------------------------------------------------------

Given(
  "a parameter {string} was created with value {string} and type {string}",
  async function (this: LwsWorld, name: string, value: string, type: string) {
    await putParameter(this, name, value, type);
  },
);

Given(
  "tags [\\{{string}: {string}, {string}: {string}}] were added to parameter {string}",
  async function (
    this: LwsWorld,
    _k1: string,
    _v1: string,
    _k2: string,
    _v2: string,
    name: string,
  ) {
    const client = this.ssmClient();
    await client.send(
      new AddTagsToResourceCommand({
        ResourceType: "Parameter",
        ResourceId: name,
        Tags: [{ Key: "env", Value: "test" }],
      }),
    );
  },
);

Given(
  "tags [{string}] were added to parameter {string}",
  async function (this: LwsWorld, _tagsStr: string, name: string) {
    const client = this.ssmClient();
    await client.send(
      new AddTagsToResourceCommand({
        ResourceType: "Parameter",
        ResourceId: name,
        Tags: [{ Key: "env", Value: "test" }],
      }),
    );
  },
);

// --- When ------------------------------------------------------------------

When(
  "I put parameter {string} with value {string} and type {string}",
  async function (this: LwsWorld, name: string, value: string, type: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new PutParameterCommand({
          Name: name,
          Value: value,
          Type: type as "String" | "SecureString" | "StringList",
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I put parameter {string} with value {string} and type {string} and description {string}",
  async function (this: LwsWorld, name: string, value: string, type: string, description: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new PutParameterCommand({
          Name: name,
          Value: value,
          Type: type as "String" | "SecureString" | "StringList",
          Description: description,
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I put parameter {string} with value {string} and type {string} with overwrite",
  async function (this: LwsWorld, name: string, value: string, type: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new PutParameterCommand({
          Name: name,
          Value: value,
          Type: type as "String" | "SecureString" | "StringList",
          Overwrite: true,
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I get parameter {string}", async function (this: LwsWorld, name: string) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new GetParameterCommand({ Name: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I get parameters [{string}, {string}]",
  async function (this: LwsWorld, name1: string, name2: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(new GetParametersCommand({ Names: [name1, name2] }));
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I get parameters {string}", async function (this: LwsWorld, namesJson: string) {
  const client = this.ssmClient();
  const names = JSON.parse(namesJson) as string[];
  try {
    const result = await client.send(new GetParametersCommand({ Names: names }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I get parameters by path {string}", async function (this: LwsWorld, path: string) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new GetParametersByPathCommand({ Path: path }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete parameter {string}", async function (this: LwsWorld, name: string) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DeleteParameterCommand({ Name: name }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete parameters [{string}]", async function (this: LwsWorld, namesStr: string) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DeleteParametersCommand({ Names: [namesStr] }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete parameters {string}", async function (this: LwsWorld, namesJson: string) {
  const client = this.ssmClient();
  const names = JSON.parse(namesJson) as string[];
  try {
    const result = await client.send(new DeleteParametersCommand({ Names: names }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe parameters", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DescribeParametersCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I add tags [\\{{string}: {string}, {string}: {string}}] to parameter {string}",
  async function (
    this: LwsWorld,
    _k1: string,
    _v1: string,
    _k2: string,
    _v2: string,
    name: string,
  ) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new AddTagsToResourceCommand({
          ResourceType: "Parameter",
          ResourceId: name,
          Tags: [{ Key: "env", Value: "test" }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I add tags [{string}] to parameter {string}",
  async function (this: LwsWorld, _tagsStr: string, name: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new AddTagsToResourceCommand({
          ResourceType: "Parameter",
          ResourceId: name,
          Tags: [{ Key: "env", Value: "test" }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I remove tag keys [{string}] from parameter {string}",
  async function (this: LwsWorld, _tagKeysStr: string, name: string) {
    const client = this.ssmClient();
    try {
      const result = await client.send(
        new RemoveTagsFromResourceCommand({
          ResourceType: "Parameter",
          ResourceId: name,
          TagKeys: ["env"],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I remove tag keys {string} from parameter {string}",
  async function (this: LwsWorld, tagKeysJson: string, name: string) {
    const client = this.ssmClient();
    const tagKeys = JSON.parse(tagKeysJson) as string[];
    try {
      const result = await client.send(
        new RemoveTagsFromResourceCommand({
          ResourceType: "Parameter",
          ResourceId: name,
          TagKeys: tagKeys,
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I list tags for parameter {string}", async function (this: LwsWorld, name: string) {
  const client = this.ssmClient();
  try {
    const result = await client.send(
      new ListTagsForResourceCommand({ ResourceType: "Parameter", ResourceId: name }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variant
When("I describe SSM parameters with timing", async function (this: LwsWorld) {
  const client = this.ssmClient();
  const start = Date.now();
  try {
    const result = await client.send(new DescribeParametersCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I describe SSM parameters", async function (this: LwsWorld) {
  const client = this.ssmClient();
  try {
    const result = await client.send(new DescribeParametersCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then(
  "parameter {string} will have value {string}",
  async function (this: LwsWorld, name: string, expectedValue: string) {
    const client = this.ssmClient();
    const result = await client.send(new GetParameterCommand({ Name: name }));
    const actualValue = result.Parameter?.Value;
    assert.strictEqual(actualValue, expectedValue);
  },
);

Then("the parameter list will include {string}", function (this: LwsWorld, expectedName: string) {
  const output = this.lastResult.output as {
    Parameters?: Array<{ Name?: string }>;
  };
  const names = (output?.Parameters ?? []).map((p) => p.Name ?? "");
  assert.ok(
    names.includes(expectedName),
    `Expected parameter list to include "${expectedName}" but got: ${names.join(", ")}`,
  );
});

Then(
  "parameter {string} will not appear in describe-parameters",
  async function (this: LwsWorld, name: string) {
    const client = this.ssmClient();
    const result = await client.send(new DescribeParametersCommand({}));
    const names = (result.Parameters ?? []).map((p) => p.Name ?? "");
    assert.ok(!names.includes(name), `Expected parameter "${name}" to not exist`);
  },
);

Then(
  "the output will contain parameter value {string}",
  function (this: LwsWorld, expectedValue: string) {
    const output = this.lastResult.output as { Parameter?: { Value?: string } };
    const actualValue = output?.Parameter?.Value;
    assert.strictEqual(actualValue, expectedValue);
  },
);
