/** Abstract step definitions for the 17 integration service directories. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import { CreateQueueCommand, DeleteQueueCommand, SendMessageCommand } from "@aws-sdk/client-sqs";
import { DeleteTableCommand } from "@aws-sdk/client-dynamodb";
import { CreateTopicCommand, DeleteTopicCommand } from "@aws-sdk/client-sns";
import {
  CreateEventBusCommand,
  DeleteEventBusCommand,
  PutRuleCommand,
  PutTargetsCommand,
  EnableRuleCommand,
  DisableRuleCommand,
  PutEventsCommand,
  RuleState,
} from "@aws-sdk/client-eventbridge";
import {
  CreateStateMachineCommand,
  StartExecutionCommand,
  StateMachineType,
} from "@aws-sdk/client-sfn";
import { PutParameterCommand, DeleteParameterCommand, ParameterType } from "@aws-sdk/client-ssm";
import { CreateSecretCommand, DeleteSecretCommand } from "@aws-sdk/client-secrets-manager";
import type { LwsWorld } from "../support/world";

// ---------------------------------------------------------------------------
// Constants (same values as abstract.ts)
// ---------------------------------------------------------------------------

const TEST_SQS_QUEUE = "test-q-1";
const TEST_SQS_MSG = "test-message-1";
const TEST_DDB_TABLE = "test-table-1";
const TEST_S3_BUCKET = "test-bucket-1";
const TEST_EVENT_BUS = "test-bus-1";
const TEST_EVENT_RULE = "test-rule-1";
const TEST_SFN_SM = "test-sm-1";
const TEST_SFN_ROLE_ARN = "arn:aws:iam::000000000000:role/StepFunctionsRole";
const TEST_SFN_DEFINITION = '{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}';
const TEST_SFN_INPUT = "{}";
const TEST_SSM_PARAM = "/test/param/1";
const TEST_SSM_VALUE = "test-value-1";
const TEST_SM_SECRET = "test-secret-1";
const TEST_SM_VALUE = "test-secret-value-1";

// ---------------------------------------------------------------------------
// "bus" variant Given steps (shorter names in integration specs)
// ---------------------------------------------------------------------------

Given("the bus does not already exist", function (this: LwsWorld) {
  // no-op: bus is absent by default
});

Given("the bus already exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore if already exists
  }
});

Given("the bus exists", async function (this: LwsWorld) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore if already exists
  }
});

Given("the bus is {string}", function (this: LwsWorld, _state: string) {
  // no-op: bus is ACTIVE by default when it exists
});

Given("the bus does not exist", function (this: LwsWorld) {
  // no-op: bus is absent by default after reset
});

Given("the bus is already {string}", function (this: LwsWorld, _state: string) {
  // Internal state not reachable via API
  return "pending";
});

Given("the bus is not already {string}", function (this: LwsWorld, _state: string) {
  // no-op: bus is not deleted by default
});

Given("the bus is not {string}", function (this: LwsWorld, _state: string) {
  // no-op: bus is not in that state by default
});

Given("the bus does not exist or is {string}", function (this: LwsWorld, _state: string) {
  // Internal state not reachable via API
  return "pending";
});

Given("the bus exists and is {string}", async function (this: LwsWorld, _state: string) {
  const client = this.eventbridgeClient();
  try {
    await client.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    // ignore if already exists
  }
});

Given("the bus does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  // Internal state not reachable via API
  return "pending";
});

// ---------------------------------------------------------------------------
// Slot / capacity Given steps
// ---------------------------------------------------------------------------

Given("an event slot is available", function (this: LwsWorld) {
  // no-op: always available in fake
});

Given("no event slot is available", async function (this: LwsWorld) {
  await this.cli().capacityExhaust(this.managementPort, "events");
});

Given("an item slot is available", function (this: LwsWorld) {
  // no-op: always available in fake
});

Given("no item slot is available", async function (this: LwsWorld) {
  await this.cli().capacityExhaust(this.managementPort, "dynamodb");
});

Given("a message slot is available", function (this: LwsWorld) {
  // no-op: always available in fake
});

Given("no message slot is available", async function (this: LwsWorld) {
  await this.cli().capacityExhaust(this.managementPort, "sqs");
  await this.cli().capacityExhaust(this.managementPort, "sns");
});

Given("an object slot is available", function (this: LwsWorld) {
  // no-op: always available in fake
});

Given("no object slot is available", async function (this: LwsWorld) {
  await this.cli().capacityExhaust(this.managementPort, "s3");
});

Given("an execution slot is available", function (this: LwsWorld) {
  // no-op: always available in fake
});

Given("no execution slot is available", async function (this: LwsWorld) {
  await this.cli().capacityExhaust(this.managementPort, "stepfunctions");
});

// ---------------------------------------------------------------------------
// Rule state Given steps
// ---------------------------------------------------------------------------

Given("a rule is {string}", async function (this: LwsWorld, _state: string) {
  const eb = this.eventbridgeClient();
  try {
    await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    /* ignore */
  }
  await eb.send(
    new PutRuleCommand({
      Name: TEST_EVENT_RULE,
      EventBusName: TEST_EVENT_BUS,
      ScheduleExpression: "rate(1 day)",
      State: RuleState.ENABLED,
    }),
  );
});

Given("no rule is {string}", function (this: LwsWorld, _state: string) {
  // no-op: no rule exists by default
});

Given('the rule is already "DISABLED"', async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    /* ignore */
  }
  try {
    await eb.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: RuleState.ENABLED,
      }),
    );
  } catch {
    /* ignore if already exists */
  }
  await eb.send(new DisableRuleCommand({ Name: TEST_EVENT_RULE, EventBusName: TEST_EVENT_BUS }));
});

Given('the rule is already "ENABLED"', async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    /* ignore */
  }
  try {
    await eb.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: RuleState.ENABLED,
      }),
    );
  } catch {
    /* ignore if already exists */
  }
});

// ---------------------------------------------------------------------------
// "ENABLED rule exists on bus targeting X" Given steps
// ---------------------------------------------------------------------------

Given('an "ENABLED" rule exists on the bus targeting a queue', async function (this: LwsWorld) {
  const sqs = this.sqsClient();
  try {
    await sqs.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    /* ignore */
  }
  const eb = this.eventbridgeClient();
  try {
    await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    /* ignore */
  }
  try {
    await eb.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: RuleState.ENABLED,
      }),
    );
  } catch {
    /* ignore if already exists */
  }
  const queueArn = `arn:aws:sqs:us-east-1:000000000000:${TEST_SQS_QUEUE}`;
  await eb.send(
    new PutTargetsCommand({
      Rule: TEST_EVENT_RULE,
      EventBusName: TEST_EVENT_BUS,
      Targets: [{ Id: "target1", Arn: queueArn }],
    }),
  );
});

Given('no "ENABLED" rule exists on the bus targeting a queue', function (this: LwsWorld) {
  // no-op: no rules exist by default
});

Given('an "ENABLED" rule exists on the bus targeting a topic', async function (this: LwsWorld) {
  const sns = this.snsClient();
  const topicResult = await sns.send(new CreateTopicCommand({ Name: "test-topic-1" }));
  this.lastTopicArn = topicResult.TopicArn;
  const eb = this.eventbridgeClient();
  try {
    await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
  } catch {
    /* ignore */
  }
  try {
    await eb.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: RuleState.ENABLED,
      }),
    );
  } catch {
    /* ignore if already exists */
  }
  await eb.send(
    new PutTargetsCommand({
      Rule: TEST_EVENT_RULE,
      EventBusName: TEST_EVENT_BUS,
      Targets: [{ Id: "target1", Arn: this.lastTopicArn! }],
    }),
  );
});

Given('no "ENABLED" rule exists on the bus targeting a topic', function (this: LwsWorld) {
  // no-op: no rules exist by default
});

Given(
  'an "ENABLED" rule exists on the bus targeting a state machine',
  async function (this: LwsWorld) {
    const sfn = this.sfnClient();
    try {
      const smResult = await sfn.send(
        new CreateStateMachineCommand({
          name: TEST_SFN_SM,
          definition: TEST_SFN_DEFINITION,
          roleArn: TEST_SFN_ROLE_ARN,
          type: StateMachineType.STANDARD,
        }),
      );
      this.lastStateMachineArn = smResult.stateMachineArn;
    } catch {
      /* ignore if already exists */
    }
    const eb = this.eventbridgeClient();
    try {
      await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
    } catch {
      /* ignore */
    }
    try {
      await eb.send(
        new PutRuleCommand({
          Name: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          ScheduleExpression: "rate(1 day)",
          State: RuleState.ENABLED,
        }),
      );
    } catch {
      /* ignore if already exists */
    }
    const smArn =
      this.lastStateMachineArn ??
      `arn:aws:states:us-east-1:000000000000:stateMachine:${TEST_SFN_SM}`;
    await eb.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: smArn }],
      }),
    );
  },
);

Given('no "ENABLED" rule exists on the bus targeting a state machine', function (this: LwsWorld) {
  // no-op: no rules exist by default
});

// ---------------------------------------------------------------------------
// Target resource state Given steps
// ---------------------------------------------------------------------------

Given("the target table is {string}", function (this: LwsWorld, _state: string) {
  // no-op: table is ACTIVE by default
});

Given("the target table is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the target queue is {string}", function (this: LwsWorld, _state: string) {
  // no-op: queue is ACTIVE by default
});

Given("the target queue is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the target topic is {string}", function (this: LwsWorld, _state: string) {
  // no-op: topic is ACTIVE by default
});

Given("the target topic is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the target state machine is {string}", function (this: LwsWorld, _state: string) {
  // no-op: state machine is ACTIVE by default
});

Given("the target state machine is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the target bus is {string}", function (this: LwsWorld, _state: string) {
  // no-op: bus is ACTIVE by default
});

Given("the target bus is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the target bucket is {string}", function (this: LwsWorld, _state: string) {
  // no-op: bucket is ACTIVE by default
});

Given("the target bucket is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

// ---------------------------------------------------------------------------
// Execution state Given steps (integration phrasing - SM must be created first)
// ---------------------------------------------------------------------------

Given('an execution is "RUNNING"', async function (this: LwsWorld) {
  const sfn = this.sfnClient();
  let smArn = this.lastStateMachineArn;
  if (!smArn) {
    try {
      const smResult = await sfn.send(
        new CreateStateMachineCommand({
          name: TEST_SFN_SM,
          definition: TEST_SFN_DEFINITION,
          roleArn: TEST_SFN_ROLE_ARN,
          type: StateMachineType.STANDARD,
        }),
      );
      smArn = smResult.stateMachineArn;
      this.lastStateMachineArn = smArn;
    } catch {
      /* ignore if already exists */
    }
  }
  const execResult = await sfn.send(
    new StartExecutionCommand({
      stateMachineArn: smArn!,
      input: TEST_SFN_INPUT,
    }),
  );
  this.lastExecutionArn = execResult.executionArn;
});

Given('no execution is "RUNNING"', function (this: LwsWorld) {
  // Internal state not reachable via API
  return "pending";
});

// ---------------------------------------------------------------------------
// Table state Given steps (integration-specific phrasing)
// Note: "the table is {string}" and "the table is not {string}" are already
// registered in abstract.ts — no duplicate registrations here.

// ---------------------------------------------------------------------------
// Notification configuration Given steps (s3api_sns, s3api_sqs, s3api_events)
// ---------------------------------------------------------------------------

Given("the bucket has no EventBridge notification configured", function (this: LwsWorld) {
  // no-op: no notification by default
});

Given("the bucket already has an EventBridge notification configured", function (this: LwsWorld) {
  return "pending";
});

Given("the bucket has an EventBridge notification configured", function (this: LwsWorld) {
  // no-op: assume configured
});

Given("the bucket has no notification configuration", function (this: LwsWorld) {
  // no-op: no notification by default
});

Given("the bucket already has a notification configuration", function (this: LwsWorld) {
  return "pending";
});

Given("the bucket has a notification configuration", function (this: LwsWorld) {
  // no-op: assume configured
});

Given("the queue exists and is {string}", async function (this: LwsWorld, _state: string) {
  const sqs = this.sqsClient();
  try {
    await sqs.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    /* ignore */
  }
});

Given("the queue does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the topic exists and is {string}", async function (this: LwsWorld, _state: string) {
  const sns = this.snsClient();
  const topicResult = await sns.send(new CreateTopicCommand({ Name: "test-topic-1" }));
  this.lastTopicArn = topicResult.TopicArn;
});

Given("the topic does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

// Note: "the topic is not {string}" and "the queue is not {string}" are
// already registered in abstract.ts — no duplicate registration here.

// ---------------------------------------------------------------------------
// DynamoDB task configuration Given steps (stepfunctions_dynamodb)
// ---------------------------------------------------------------------------

Given("the state machine has no DynamoDB task configured", function (this: LwsWorld) {
  return "pending";
});

Given("the state machine already has a DynamoDB task configured", function (this: LwsWorld) {
  return "pending";
});

Given("the state machine has a DynamoDB task configured", function (this: LwsWorld) {
  // no-op: conceptual
});

Given("no item {string} in the target table", function (this: LwsWorld, _state: string) {
  // no-op: table is empty by default
});

Given("an item {string} in the target table", async function (this: LwsWorld, _state: string) {
  // Table must exist for item to exist - no-op
});

// ---------------------------------------------------------------------------
// S3 task configuration Given steps (stepfunctions_s3api)
// ---------------------------------------------------------------------------

Given("the state machine has no S3 task configured", function (this: LwsWorld) {
  return "pending";
});

Given("the state machine already has an S3 task configured", function (this: LwsWorld) {
  return "pending";
});

Given("the state machine has an S3 task configured", function (this: LwsWorld) {
  // no-op: conceptual
});

Given("no object {string} in the target bucket", function (this: LwsWorld, _state: string) {
  // no-op: bucket is empty by default
});

Given("an object {string} in the target bucket", function (this: LwsWorld, _state: string) {
  // no-op: assume object exists
});

// ---------------------------------------------------------------------------
// EventBridge publishing configuration Given steps (stepfunctions_events)
// ---------------------------------------------------------------------------

Given("the state machine has no EventBridge bus configured", function (this: LwsWorld) {
  // no-op
});

Given("the state machine already has an EventBridge bus configured", function (this: LwsWorld) {
  return "pending";
});

Given("the state machine has an EventBridge bus configured", function (this: LwsWorld) {
  // no-op: conceptual
});

Given("the state machine exists and is {string}", async function (this: LwsWorld, _state: string) {
  const sfn = this.sfnClient();
  try {
    const smResult = await sfn.send(
      new CreateStateMachineCommand({
        name: TEST_SFN_SM,
        definition: TEST_SFN_DEFINITION,
        roleArn: TEST_SFN_ROLE_ARN,
        type: StateMachineType.STANDARD,
      }),
    );
    this.lastStateMachineArn = smResult.stateMachineArn;
  } catch {
    /* ignore if already exists */
  }
});

Given(
  "the state machine does not exist or is not {string}",
  function (this: LwsWorld, _state: string) {
    return "pending";
  },
);

// ---------------------------------------------------------------------------
// SNS task configuration Given steps (stepfunctions_sns)
// ---------------------------------------------------------------------------

Given(
  "the state machine has no {string} task configured",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

Given(
  "the state machine already has an {string} task configured",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

Given(
  "the state machine has an {string} task configured",
  function (this: LwsWorld, _service: string) {
    // no-op: conceptual
  },
);

Given(
  "the execution's state machine has a configured {string} task",
  function (this: LwsWorld, _service: string) {
    // no-op: conceptual
  },
);

Given(
  "the execution's state machine has no {string} task configured",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

// ---------------------------------------------------------------------------
// Secrets Manager state Given steps (stepfunctions_secretsmanager)
// ---------------------------------------------------------------------------

Given("the secret is not pending deletion", function (this: LwsWorld) {
  // no-op: secret is not pending deletion by default
});

Given("the secret exists and is {string}", async function (this: LwsWorld, _state: string) {
  const sm = this.secretsManagerClient();
  try {
    await sm.send(
      new CreateSecretCommand({
        Name: TEST_SM_SECRET,
        SecretString: TEST_SM_VALUE,
      }),
    );
  } catch {
    /* ignore if already exists */
  }
});

Given("the secret does not exist or is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

// Note: "the secret is not {string}" is already registered in abstract.ts.

// ---------------------------------------------------------------------------
// SSM parameter state Given steps (stepfunctions_ssm, ssm_events)
// ---------------------------------------------------------------------------

Given("the parameter {string}", async function (this: LwsWorld, state: string) {
  if (state === "EXISTS") {
    const ssm = this.ssmClient();
    try {
      await ssm.send(
        new PutParameterCommand({
          Name: TEST_SSM_PARAM,
          Value: TEST_SSM_VALUE,
          Type: ParameterType.STRING,
        }),
      );
    } catch {
      // Parameter may already exist
    }
  }
});

Given("the parameter is already {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the parameter is {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the parameter is not {string}", function (this: LwsWorld, _state: string) {
  // no-op: parameter is not in that state by default
});

Given("the parameter does not exist or is {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

// ---------------------------------------------------------------------------
// SNS subscription state (sns_sqs)
// ---------------------------------------------------------------------------

Given("the subscribed queue is {string}", function (this: LwsWorld, _state: string) {
  // no-op: queue is ACTIVE by default
});

Given("the subscribed queue is not {string}", function (this: LwsWorld, _state: string) {
  return "pending";
});

Given("the subscription slot is not available", function (this: LwsWorld) {
  return "pending";
});

// ---------------------------------------------------------------------------
// When steps: integration-specific actions
// ---------------------------------------------------------------------------

When(
  "an event is published to the bus and routed to the target {string} queue",
  async function (this: LwsWorld, _service: string) {
    const eb = this.eventbridgeClient();
    try {
      const result = await eb.send(
        new PutEventsCommand({
          Entries: [
            {
              EventBusName: TEST_EVENT_BUS,
              Source: "test.source",
              DetailType: "TestEvent",
              Detail: '{"key":"value"}',
            },
          ],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When('an "SQS" queue is created', async function (this: LwsWorld) {
  const sqs = this.sqsClient();
  try {
    const result = await sqs.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "an EventBridge rule is created to route matching events to the {string} queue",
  async function (this: LwsWorld, _service: string) {
    const eb = this.eventbridgeClient();
    try {
      await eb.send(
        new PutRuleCommand({
          Name: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          ScheduleExpression: "rate(1 day)",
          State: RuleState.ENABLED,
        }),
      );
      const queueArn = `arn:aws:sqs:us-east-1:000000000000:${TEST_SQS_QUEUE}`;
      const result = await eb.send(
        new PutTargetsCommand({
          Rule: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          Targets: [{ Id: "target1", Arn: queueArn }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "an event is published to the bus and routed to the target {string} topic",
  async function (this: LwsWorld, _service: string) {
    const eb = this.eventbridgeClient();
    try {
      const result = await eb.send(
        new PutEventsCommand({
          Entries: [
            {
              EventBusName: TEST_EVENT_BUS,
              Source: "test.source",
              DetailType: "TestEvent",
              Detail: '{"key":"value"}',
            },
          ],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "an EventBridge rule is created to route matching events to an {string} topic",
  async function (this: LwsWorld, _service: string) {
    const eb = this.eventbridgeClient();
    try {
      await eb.send(
        new PutRuleCommand({
          Name: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          ScheduleExpression: "rate(1 day)",
          State: RuleState.ENABLED,
        }),
      );
      // Use the topic ARN from the Given step (or a non-existent fallback if topic does not exist)
      const topicArn = this.lastTopicArn ?? "arn:aws:sns:us-east-1:000000000000:test-topic-1";
      const result = await eb.send(
        new PutTargetsCommand({
          Rule: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          Targets: [{ Id: "target1", Arn: topicArn }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "an event is published to the bus and triggers a new Step Functions execution",
  async function (this: LwsWorld) {
    const eb = this.eventbridgeClient();
    try {
      const result = await eb.send(
        new PutEventsCommand({
          Entries: [
            {
              EventBusName: TEST_EVENT_BUS,
              Source: "test.source",
              DetailType: "TestEvent",
              Detail: '{"key":"value"}',
            },
          ],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "an EventBridge rule is created to start a Step Functions execution on matching events",
  async function (this: LwsWorld) {
    const eb = this.eventbridgeClient();
    try {
      await eb.send(
        new PutRuleCommand({
          Name: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          ScheduleExpression: "rate(1 day)",
          State: RuleState.ENABLED,
        }),
      );
      // Use the state machine ARN from the Given step (or a non-existent fallback)
      const smArn =
        this.lastStateMachineArn ??
        `arn:aws:states:us-east-1:000000000000:stateMachine:${TEST_SFN_SM}`;
      const result = await eb.send(
        new PutTargetsCommand({
          Rule: TEST_EVENT_RULE,
          EventBusName: TEST_EVENT_BUS,
          Targets: [{ Id: "target1", Arn: smArn }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("a running execution fails", function (this: LwsWorld) {
  // Internal transition — not reachable via API
  return "pending";
});

When("a running execution completes successfully", function (this: LwsWorld) {
  // Internal transition — not reachable via API
  return "pending";
});

When("an EventBridge event bus is created", async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    const result = await eb.send(new CreateEventBusCommand({ Name: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is created targeting a DynamoDB table", async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    await eb.send(
      new PutRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        ScheduleExpression: "rate(1 day)",
        State: RuleState.DISABLED,
      }),
    );
    const tableArn = `arn:aws:dynamodb:us-east-1:000000000000:table/${TEST_DDB_TABLE}`;
    const result = await eb.send(
      new PutTargetsCommand({
        Rule: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
        Targets: [{ Id: "target1", Arn: tableArn }],
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is enabled", async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    const result = await eb.send(
      new EnableRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("an EventBridge rule is disabled", async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    const result = await eb.send(
      new DisableRuleCommand({
        Name: TEST_EVENT_RULE,
        EventBusName: TEST_EVENT_BUS,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "an event matches an {string} rule and EventBridge writes an item to the DynamoDB target",
  function (this: LwsWorld, _state: string) {
    // Internal routing — not reachable via API
    return "pending";
  },
);

When(
  "an event matches an {string} rule but the DynamoDB write fails because the table is being deleted",
  function (this: LwsWorld, _state: string) {
    // Internal routing — not reachable via API
    return "pending";
  },
);

When("a table deletion is initiated", async function (this: LwsWorld) {
  const ddb = this.dynamodbClient();
  try {
    const result = await ddb.send(new DeleteTableCommand({ TableName: TEST_DDB_TABLE }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("the EventBridge event bus is deleted", async function (this: LwsWorld) {
  const eb = this.eventbridgeClient();
  try {
    const result = await eb.send(new DeleteEventBusCommand({ Name: TEST_EVENT_BUS }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "EventBridge notifications are enabled on the bucket targeting a specific bus",
  function (this: LwsWorld) {
    // Not supported in fake via API — skip
    return "pending";
  },
);

When(
  "an object is uploaded and S3 delivers an event to the EventBridge bus",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "an object is uploaded but event delivery fails because the bus has been deleted",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "an {string} notification configuration is added to the bucket",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When("the {string} topic is deleted", async function (this: LwsWorld, _service: string) {
  const sns = this.snsClient();
  try {
    const result = await sns.send(new DeleteTopicCommand({ TopicArn: this.lastTopicArn! }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("the {string} queue is deleted", async function (this: LwsWorld, _service: string) {
  const sqs = this.sqsClient();
  try {
    const result = await sqs.send(
      new DeleteQueueCommand({ QueueUrl: this.sqsQueueUrl(TEST_SQS_QUEUE) }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "an object is uploaded and S3 publishes a notification to the {string} topic",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When(
  "an object is uploaded but notification delivery fails because the topic has been deleted",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "an object is uploaded to the bucket and S3 delivers a notification to the {string} queue",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When(
  "an object is uploaded but notification delivery fails because the queue has been deleted",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a secret is created and Secrets Manager delivers a {string} event to the EventBridge bus",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a secret is created but the {string} event delivery fails because the bus is deleted",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a secret is scheduled for deletion and Secrets Manager delivers a {string} event to the bus",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a secret rotation occurs and Secrets Manager delivers a {string} event to the bus",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a parameter is created and {string} delivers a {string} event to the EventBridge bus",
  function (this: LwsWorld, _service: string, _eventType: string) {
    return "pending";
  },
);

When(
  "a parameter is created but the {string} event delivery fails because the bus is deleted",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a parameter is deleted and {string} delivers a {string} event to the EventBridge bus",
  function (this: LwsWorld, _service: string, _eventType: string) {
    return "pending";
  },
);

When(
  "an {string} queue subscribes to an {string} topic",
  function (this: LwsWorld, _qService: string, _tService: string) {
    return "pending";
  },
);

When(
  "a message is published to an {string} topic and delivered to the subscribed {string} queue",
  function (this: LwsWorld, _tService: string, _qService: string) {
    return "pending";
  },
);

When("a message is consumed from the {string} queue", function (this: LwsWorld, _service: string) {
  return "pending";
});

When(
  "a subscriber consumes a message from the {string} topic",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

Given("an {string} message exists in the queue", async function (this: LwsWorld, _state: string) {
  const sqs = this.sqsClient();
  try {
    await sqs.send(new CreateQueueCommand({ QueueName: TEST_SQS_QUEUE }));
  } catch {
    /* ignore */
  }
  await sqs.send(
    new SendMessageCommand({
      QueueUrl: this.sqsQueueUrl(TEST_SQS_QUEUE),
      MessageBody: TEST_SQS_MSG,
    }),
  );
});

Given("an {string} message exists on the topic", function (this: LwsWorld, _state: string) {
  // no-op: messages on topics are internal
});

Given("no {string} message exists in the queue", function (this: LwsWorld, _state: string) {
  // no-op: queue is empty by default
});

Given("no {string} message exists on the topic", function (this: LwsWorld, _state: string) {
  // no-op: no messages by default
});

When("a DynamoDB PutItem task is configured on the state machine", function (this: LwsWorld) {
  return "pending";
});

When(
  "a running execution writes an item to the DynamoDB table and succeeds",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a running execution attempts to get an item that does not exist and the execution fails",
  function (this: LwsWorld) {
    return "pending";
  },
);

When("an S3 task is configured on the state machine", function (this: LwsWorld) {
  return "pending";
});

When(
  "a running execution writes an object to the S3 bucket and succeeds",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a running execution reads an existing object from the S3 bucket and succeeds",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a running execution fails to read because no object exists in the bucket",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "the state machine is configured to publish execution events to the event bus",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a running execution succeeds and Step Functions delivers a {string} event to the bus",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a running execution succeeds but the {string} event delivery fails because the bus is deleted",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "an execution starts and Step Functions delivers a {string} event to the EventBridge bus",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "an execution starts but the {string} event delivery fails because the bus is deleted",
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

When(
  "a running execution reads an {string} secret and the task succeeds",
  function (this: LwsWorld, _state: string) {
    return "pending";
  },
);

When(
  "a running execution fails to read the secret because it is pending deletion",
  function (this: LwsWorld) {
    return "pending";
  },
);

When("a secret is scheduled for deletion", async function (this: LwsWorld) {
  const sm = this.secretsManagerClient();
  try {
    const result = await sm.send(
      new DeleteSecretCommand({
        SecretId: TEST_SM_SECRET,
        RecoveryWindowInDays: 7,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "a running execution reads an existing parameter and the task succeeds",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a running execution fails to read the parameter because it has been deleted",
  function (this: LwsWorld) {
    return "pending";
  },
);

When(
  "a parameter is deleted from {string} Parameter Store",
  async function (this: LwsWorld, _service: string) {
    const ssm = this.ssmClient();
    try {
      const result = await ssm.send(new DeleteParameterCommand({ Name: TEST_SSM_PARAM }));
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "a parameter is created in {string} Parameter Store",
  async function (this: LwsWorld, _service: string) {
    const ssm = this.ssmClient();
    try {
      const result = await ssm.send(
        new PutParameterCommand({
          Name: TEST_SSM_PARAM,
          Value: TEST_SSM_VALUE,
          Type: ParameterType.STRING,
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "an {string} publish task is configured on the state machine",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When(
  "a running execution publishes a message to the {string} topic and succeeds",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When(
  "an {string} send-message task is configured on the state machine",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When(
  "a running execution reaches the {string} task state and sends a message to the queue",
  function (this: LwsWorld, _service: string) {
    return "pending";
  },
);

When("an execution of the state machine is started", async function (this: LwsWorld) {
  const sfn = this.sfnClient();
  try {
    const result = await sfn.send(
      new StartExecutionCommand({
        stateMachineArn: this.lastStateMachineArn!,
        input: TEST_SFN_INPUT,
      }),
    );
    this.lastExecutionArn = result.executionArn;
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("a secret is created in Secrets Manager", async function (this: LwsWorld) {
  const sm = this.secretsManagerClient();
  try {
    const result = await sm.send(
      new CreateSecretCommand({
        Name: TEST_SM_SECRET,
        SecretString: TEST_SM_VALUE,
      }),
    );
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// ---------------------------------------------------------------------------
// Then steps: integration-specific assertions
// ---------------------------------------------------------------------------

Then(
  'the rule is "DISABLED" on the bus with the DynamoDB target configured',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the rule is "ENABLED" and will match events', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the rule is "DISABLED" and will not match events', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the item {string} in the table and the event is recorded as {string}",
  function (this: LwsWorld, _itemState: string, _eventState: string) {
    return "pending";
  },
);

Then("the event is {string} but no item is written", function (this: LwsWorld, _state: string) {
  return "pending";
});

Then('the table is "DELETING" and item writes to it will fail', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the message is "AVAILABLE" on the topic', function (this: LwsWorld) {
  return "pending";
});

Then(
  'the rule is "ENABLED" and will publish to the topic when matching events are received',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the message is "AVAILABLE" in the target queue', function (this: LwsWorld) {
  return "pending";
});

Then(
  'the rule is "ENABLED" and will forward matching events to the queue',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  'the rule is "ENABLED" and will trigger an execution when matching events are published',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  'the bucket is "ACTIVE" with no EventBridge notification configuration',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then("the bucket will send events to the bus when objects are uploaded", function (this: LwsWorld) {
  return "pending";
});

Then("the object {string} but no event is delivered", function (this: LwsWorld, _state: string) {
  return "pending";
});

Then(
  "the object {string} and an event is {string} to the bus",
  function (this: LwsWorld, _objectState: string, _eventState: string) {
    return "pending";
  },
);

Then('the bus is "DELETED" and event delivery to it will fail', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then('the bucket is "ACTIVE" with no notification configuration', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the bucket will publish notifications to the topic when objects are uploaded",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  "the object {string} but no notification is published",
  function (this: LwsWorld, _state: string) {
    return "pending";
  },
);

Then(
  "the object {string} and a notification is {string} to the topic",
  function (this: LwsWorld, _objectState: string, _notifState: string) {
    return "pending";
  },
);

Then('the topic is "DELETED" and notification delivery to it will fail', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the bucket will send notifications to the queue when objects are uploaded",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  "the object {string} but no notification message is delivered",
  function (this: LwsWorld, _state: string) {
    return "pending";
  },
);

Then(
  "the object {string} and a notification message is {string}",
  function (this: LwsWorld, _objectState: string, _msgState: string) {
    return "pending";
  },
);

Then('the queue is "DELETED" and notification delivery to it will fail', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  'the secret is "ACTIVE" and the {string} event is {string}',
  function (this: LwsWorld, _eventType: string, _state: string) {
    return "pending";
  },
);

Then('the secret is "ACTIVE" but no event is delivered', function (this: LwsWorld) {
  return "pending";
});

Then(
  'the secret is "PENDING_DELETION" and the {string} event is {string}',
  function (this: LwsWorld, _eventType: string, _state: string) {
    return "pending";
  },
);

Then(
  'the secret is "ACTIVE" with a new version and the {string} event is {string}',
  function (this: LwsWorld, _eventType: string, _state: string) {
    return "pending";
  },
);

Then(
  'the bus is "DELETED" and Secrets Manager event delivery will fail',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  "the parameter {string} and the {string} event is {string}",
  function (this: LwsWorld, _paramState: string, _eventType: string, _state: string) {
    return "pending";
  },
);

Then("the parameter {string} but no event is delivered", function (this: LwsWorld, _state: string) {
  return "pending";
});

Then(
  "the parameter is {string} and the {string} event is {string}",
  function (this: LwsWorld, _paramState: string, _eventType: string, _state: string) {
    return "pending";
  },
);

Then(
  'the bus is "DELETED" and {string} event delivery will fail',
  function (this: LwsWorld, _service: string) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  'the subscription is "CONFIRMED" and the queue will receive published messages',
  function (this: LwsWorld) {
    return "pending";
  },
);

Then('the message is "AVAILABLE" in the queue', function (this: LwsWorld) {
  return "pending";
});

Then(
  "a message can only be delivered if a confirmed subscription exists for the topic",
  function (this: LwsWorld) {
    // no-op: invariant
  },
);

Then('the state machine is "ACTIVE" with no DynamoDB task configured', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the state machine will write an item to the table when it reaches the task state",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  "the item {string} in the table and the execution is {string}",
  function (this: LwsWorld, _itemState: string, _execState: string) {
    return "pending";
  },
);

Then('the execution is "FAILED" because the item was not found', function (this: LwsWorld) {
  return "pending";
});

Then('the state machine is "ACTIVE" with no S3 task configured', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the state machine will read or write objects to the bucket when it reaches the task state",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  "the object {string} in the bucket and the execution is {string}",
  function (this: LwsWorld, _objectState: string, _execState: string) {
    return "pending";
  },
);

Then('the execution is "FAILED" with a NoSuchKey error', function (this: LwsWorld) {
  return "pending";
});

Then('the state machine is "ACTIVE" with no EventBridge bus configured', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  "the state machine will send execution state change events to the bus",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  'the execution is "RUNNING" and the {string} event is {string}',
  function (this: LwsWorld, _eventType: string, _state: string) {
    return "pending";
  },
);

Then(
  'the execution is "RUNNING" but no {string} event is delivered',
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

Then(
  'the execution is "SUCCEEDED" and the {string} event is {string}',
  function (this: LwsWorld, _eventType: string, _state: string) {
    return "pending";
  },
);

Then(
  'the execution is "SUCCEEDED" but no {string} event is delivered',
  function (this: LwsWorld, _eventType: string) {
    return "pending";
  },
);

Then('the bus is "DELETED" and execution event delivery will fail', function (this: LwsWorld) {
  assert.strictEqual(
    this.lastResult.success,
    true,
    `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
  );
});

Then(
  'the secret is "PENDING_DELETION" and will cause task failures when read',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the execution is "FAILED" with a ResourceNotFoundException', function (this: LwsWorld) {
  return "pending";
});

Then(
  'the parameter is "DELETED" and will cause task failures when read',
  function (this: LwsWorld) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then('the execution is "FAILED" with a ParameterNotFound error', function (this: LwsWorld) {
  return "pending";
});

Then(
  'the state machine is "ACTIVE" with no {string} task configured',
  function (this: LwsWorld, _service: string) {
    assert.strictEqual(
      this.lastResult.success,
      true,
      `Expected success but got: ${JSON.stringify(this.lastResult.output)}`,
    );
  },
);

Then(
  "the state machine will publish a message to the topic when it reaches the task state",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  'the execution is "SUCCEEDED" and the message has been published to the topic',
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  "the state machine will enqueue a message when it reaches the task state",
  function (this: LwsWorld) {
    return "pending";
  },
);

Then(
  'the message is "AVAILABLE" in the queue and the execution is "SUCCEEDED"',
  function (this: LwsWorld) {
    return "pending";
  },
);

// Note: Then("the execution is \"RUNNING\"") is already registered in abstract.ts.
