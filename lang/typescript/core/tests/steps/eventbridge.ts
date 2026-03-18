/** EventBridge step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateEventBusCommand,
  DeleteEventBusCommand,
  ListEventBusesCommand,
  DescribeEventBusCommand,
  PutRuleCommand,
  DeleteRuleCommand,
  DescribeRuleCommand,
  ListRulesCommand,
  EnableRuleCommand,
  DisableRuleCommand,
  PutTargetsCommand,
  RemoveTargetsCommand,
  ListTargetsByRuleCommand,
  PutEventsCommand,
  TagResourceCommand,
  UntagResourceCommand,
  ListTagsForResourceCommand,
} from "@aws-sdk/client-eventbridge";
import type { LwsWorld } from "../support/world";

const ACCOUNT = "000000000000";
const REGION = "us-east-1";

function busArn(busName: string): string {
  return `arn:aws:events:${REGION}:${ACCOUNT}:event-bus/${busName}`;
}

async function createEventBus(world: LwsWorld, busName: string): Promise<void> {
  const client = world.eventbridgeClient();
  await client.send(new CreateEventBusCommand({ Name: busName }));
}

async function createRule(world: LwsWorld, ruleName: string, busName: string): Promise<void> {
  const client = world.eventbridgeClient();
  await client.send(
    new PutRuleCommand({
      Name: ruleName,
      EventBusName: busName,
      ScheduleExpression: "rate(1 day)",
      State: "ENABLED",
    }),
  );
}

// --- Given -----------------------------------------------------------------

Given("an event bus {string} was created", async function (this: LwsWorld, busName: string) {
  await createEventBus(this, busName);
});

Given(
  "a rule {string} was created on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    if (busName !== "default") {
      await createEventBus(this, busName);
    }
    await createRule(this, ruleName, busName);
  },
);

Given(
  "targets were added to rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    await client.send(
      new PutTargetsCommand({
        Rule: ruleName,
        EventBusName: busName,
        Targets: [{ Id: "target1", Arn: `arn:aws:sqs:${REGION}:${ACCOUNT}:dummy-queue` }],
      }),
    );
  },
);

Given("resource {string} was tagged", async function (this: LwsWorld, resourceArn: string) {
  const client = this.eventbridgeClient();
  await client.send(
    new TagResourceCommand({ ResourceARN: resourceArn, Tags: [{ Key: "env", Value: "test" }] }),
  );
});

// --- When ------------------------------------------------------------------

When("I create event bus {string}", async function (this: LwsWorld, busName: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new CreateEventBusCommand({ Name: busName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete event bus {string}", async function (this: LwsWorld, busName: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new DeleteEventBusCommand({ Name: busName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list event buses", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new ListEventBusesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe event bus {string}", async function (this: LwsWorld, busName: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new DescribeEventBusCommand({ Name: busName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I put rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new PutRuleCommand({
          Name: ruleName,
          EventBusName: busName,
          ScheduleExpression: "rate(1 day)",
          State: "ENABLED",
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I delete rule {string}", async function (this: LwsWorld, ruleName: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new DeleteRuleCommand({ Name: ruleName, EventBusName: "default" }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I describe rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new DescribeRuleCommand({ Name: ruleName, EventBusName: busName }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I list rules on event bus {string}", async function (this: LwsWorld, busName: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new ListRulesCommand({ EventBusName: busName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I enable rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new EnableRuleCommand({ Name: ruleName, EventBusName: busName }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I disable rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new DisableRuleCommand({ Name: ruleName, EventBusName: busName }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I put targets on rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new PutTargetsCommand({
          Rule: ruleName,
          EventBusName: busName,
          Targets: [{ Id: "target1", Arn: `arn:aws:sqs:${REGION}:${ACCOUNT}:dummy-queue` }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I remove targets from rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new RemoveTargetsCommand({ Rule: ruleName, EventBusName: busName, Ids: ["target1"] }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I list targets by rule {string} on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    try {
      const result = await client.send(
        new ListTargetsByRuleCommand({ Rule: ruleName, EventBusName: busName }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I put events to the default bus", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new PutEventsCommand({
        Entries: [
          {
            Source: "e2e.test",
            DetailType: "TestEvent",
            Detail: JSON.stringify({ message: "hello" }),
          },
        ],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I tag resource {string}", async function (this: LwsWorld, resourceArn: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new TagResourceCommand({
        ResourceARN: resourceArn,
        Tags: [{ Key: "env", Value: "test" }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I untag resource {string}", async function (this: LwsWorld, resourceArn: string) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(
      new UntagResourceCommand({ ResourceARN: resourceArn, TagKeys: ["env"] }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Note: "I list tags for resource {string}" is handled in sns.ts for shared routing

// Timed variant
When("I list EventBridge event buses with timing", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListEventBusesCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list EventBridge event buses", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    const result = await client.send(new ListEventBusesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// --- Then ------------------------------------------------------------------

Then(
  "event bus {string} will appear in list-event-buses",
  async function (this: LwsWorld, busName: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(new ListEventBusesCommand({}));
    const names = (result.EventBuses ?? []).map((b) => b.Name ?? "");
    assert.ok(names.includes(busName), `Expected event bus "${busName}" in list`);
  },
);

Then(
  "event bus {string} will not appear in list-event-buses",
  async function (this: LwsWorld, busName: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(new ListEventBusesCommand({}));
    const names = (result.EventBuses ?? []).map((b) => b.Name ?? "");
    assert.ok(!names.includes(busName), `Expected event bus "${busName}" to not be in list`);
  },
);

Then("the output will contain event bus {string}", function (this: LwsWorld, busName: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(actualOutput.includes(busName), `Expected output to contain "${busName}"`);
});

Then(
  "rule {string} will appear in list-rules on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(new ListRulesCommand({ EventBusName: busName }));
    const names = (result.Rules ?? []).map((r) => r.Name ?? "");
    assert.ok(names.includes(ruleName), `Expected rule "${ruleName}" in list`);
  },
);

Then(
  "rule {string} will not appear in list-rules on event bus {string}",
  async function (this: LwsWorld, ruleName: string, busName: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(new ListRulesCommand({ EventBusName: busName }));
    const names = (result.Rules ?? []).map((r) => r.Name ?? "");
    assert.ok(!names.includes(ruleName), `Expected rule "${ruleName}" to not be in list`);
  },
);

Then(
  "rule {string} will have state {string}",
  async function (this: LwsWorld, ruleName: string, expectedState: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(
      new DescribeRuleCommand({ Name: ruleName, EventBusName: "default" }),
    );
    assert.strictEqual(result.State, expectedState);
  },
);

Then("the output will contain a Rules key", function (this: LwsWorld) {
  const output = this.lastResult.output as { Rules?: unknown[] };
  assert.ok(output?.Rules !== undefined, "Expected Rules in output");
});

Then("the failed entry count will be {int}", function (this: LwsWorld, expectedCount: number) {
  const output = this.lastResult.output as { FailedEntryCount?: number };
  assert.strictEqual(output?.FailedEntryCount ?? 0, expectedCount);
});

Then(
  "rule {string} will have a target in list-targets-by-rule",
  async function (this: LwsWorld, ruleName: string) {
    const client = this.eventbridgeClient();
    const result = await client.send(
      new ListTargetsByRuleCommand({ Rule: ruleName, EventBusName: "default" }),
    );
    assert.ok((result.Targets ?? []).length > 0, "Expected at least one target");
  },
);

Then("rule {string} will have no targets", async function (this: LwsWorld, ruleName: string) {
  const client = this.eventbridgeClient();
  const result = await client.send(
    new ListTargetsByRuleCommand({ Rule: ruleName, EventBusName: "default" }),
  );
  assert.strictEqual((result.Targets ?? []).length, 0, "Expected no targets");
});

Then(
  "event bus {string} will have tag {string} with value {string}",
  async function (this: LwsWorld, busName: string, tagKey: string, expectedValue: string) {
    const client = this.eventbridgeClient();
    const arn = busArn(busName);
    const result = await client.send(new ListTagsForResourceCommand({ ResourceARN: arn }));
    const tagsRaw = result.Tags ?? {};
    const tagMap: Record<string, string> = {};
    if (Array.isArray(tagsRaw)) {
      for (const t of tagsRaw as Array<{ Key?: string; Value?: string }>) {
        if (t.Key) tagMap[t.Key] = t.Value ?? "";
      }
    } else {
      Object.assign(tagMap, tagsRaw);
    }
    assert.strictEqual(tagMap[tagKey], expectedValue);
  },
);

Then(
  "event bus {string} will not have tag {string}",
  async function (this: LwsWorld, busName: string, tagKey: string) {
    const client = this.eventbridgeClient();
    const arn = busArn(busName);
    const result = await client.send(new ListTagsForResourceCommand({ ResourceARN: arn }));
    const tagsRaw = result.Tags ?? {};
    const tagMap: Record<string, string> = {};
    if (Array.isArray(tagsRaw)) {
      for (const t of tagsRaw as Array<{ Key?: string; Value?: string }>) {
        if (t.Key) tagMap[t.Key] = t.Value ?? "";
      }
    } else {
      Object.assign(tagMap, tagsRaw);
    }
    assert.ok(!tagMap[tagKey], `Expected tag "${tagKey}" to not exist`);
  },
);
