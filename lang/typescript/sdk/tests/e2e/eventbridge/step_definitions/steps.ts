import { Given, When, Then } from "@cucumber/cucumber";
import {
  CreateEventBusCommand,
  DeleteEventBusCommand,
  ListEventBusesCommand,
  PutEventsCommand,
  PutRuleCommand,
  ListRulesCommand,
} from "@aws-sdk/client-eventbridge";
import type { EventBridgeWorld } from "../support/world.js";
import { TEST_BUS, TEST_SOURCE, TEST_DETAIL_TYPE, TEST_RULE } from "../support/world.js";

Given("the eventbridge system is initialized", function (this: EventBridgeWorld) {
  // Session started in BeforeAll
});

Given('the "eventbridge" "event bus" did not already exist', function (this: EventBridgeWorld) {
  // Bus not created — it was reset in Before hook
});

Given('the "eventbridge" "event bus" already existed', async function (this: EventBridgeWorld) {
  const result = await this.ebClient.send(new CreateEventBusCommand({ Name: TEST_BUS }));
  this.busArn = result.EventBusArn ?? "";
});

Given('the "eventbridge" "event bus" existed', async function (this: EventBridgeWorld) {
  const result = await this.ebClient.send(new CreateEventBusCommand({ Name: TEST_BUS }));
  this.busArn = result.EventBusArn ?? "";
});

When('an "eventbridge" "event bus" is created', async function (this: EventBridgeWorld) {
  try {
    const result = await this.ebClient.send(new CreateEventBusCommand({ Name: TEST_BUS }));
    this.busArn = result.EventBusArn ?? "";
    this.result = result;
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('an "eventbridge" "event bus" is deleted', async function (this: EventBridgeWorld) {
  try {
    this.result = await this.ebClient.send(new DeleteEventBusCommand({ Name: TEST_BUS }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('"eventbridge" "event"s are published to the "eventbridge" "event bus"', async function (this: EventBridgeWorld) {
  try {
    this.result = await this.ebClient.send(new PutEventsCommand({
      Entries: [{
        EventBusName: TEST_BUS,
        Source: TEST_SOURCE,
        DetailType: TEST_DETAIL_TYPE,
        Detail: JSON.stringify({ test: true }),
      }],
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

When('an "eventbridge" "rule" is created on the "eventbridge" "event bus"', async function (this: EventBridgeWorld) {
  try {
    this.result = await this.ebClient.send(new PutRuleCommand({
      Name: TEST_RULE,
      EventBusName: TEST_BUS,
      EventPattern: JSON.stringify({ source: [TEST_SOURCE] }),
      State: "ENABLED",
    }));
  } catch (err) {
    this.error = err instanceof Error ? err : new Error(String(err));
  }
});

Then('the "eventbridge" "event bus" will exist', async function (this: EventBridgeWorld) {
  const listResult = await this.ebClient.send(new ListEventBusesCommand({}));
  const expectedBusName = TEST_BUS;
  const actualBuses = listResult.EventBuses ?? [];
  const found = actualBuses.some((b) => b.Name === expectedBusName);
  if (!found) throw new Error(`Expected to find bus '${expectedBusName}' but it was absent`);
});

Then('the "eventbridge" "event bus" will not exist', async function (this: EventBridgeWorld) {
  const listResult = await this.ebClient.send(new ListEventBusesCommand({}));
  const expectedAbsentBus = TEST_BUS;
  const actualBuses = listResult.EventBuses ?? [];
  const found = actualBuses.some((b) => b.Name === expectedAbsentBus);
  if (found) throw new Error(`Expected bus '${expectedAbsentBus}' to not exist but it was found`);
});

Then('the "eventbridge" "event"s will be accepted', function (this: EventBridgeWorld) {
  const actualResult = this.result as { FailedEntryCount?: number } | null;
  const expectedFailedCount = 0;
  if ((actualResult?.FailedEntryCount ?? -1) !== expectedFailedCount) {
    throw new Error(`Expected FailedEntryCount to be ${expectedFailedCount}`);
  }
});

Then('the "eventbridge" "rule" will exist on the "eventbridge" "event bus"', async function (this: EventBridgeWorld) {
  const listResult = await this.ebClient.send(new ListRulesCommand({ EventBusName: TEST_BUS }));
  const expectedRuleName = TEST_RULE;
  const actualRules = listResult.Rules ?? [];
  const found = actualRules.some((r) => r.Name === expectedRuleName);
  if (!found) throw new Error(`Expected to find rule '${expectedRuleName}' but it was absent`);
});

Then("the eventbridge operation is rejected", function (this: EventBridgeWorld) {
  if (this.error === null) throw new Error("Expected an error but no error was thrown");
});
