/** EventBridge wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { isExhausted } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import type { SqsStore } from "../sqs";
import type { SnsStore } from "../sns";
import type { StepFunctionsStore } from "../stepfunctions";
import type { DynamoStore } from "../dynamodb/store";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

/** Infer the service name from a target ARN for capacity checking. */
function serviceFromArn(arn: string): string | null {
  if (arn.includes(":sqs:")) return "sqs";
  if (arn.includes(":sns:")) return "sns";
  if (arn.includes(":states:")) return "stepfunctions";
  if (arn.includes(":lambda:")) return "lambda";
  if (arn.includes(":dynamodb:")) return "dynamodb";
  return null;
}

interface EventBus {
  name: string;
  arn: string;
  state: string; // "ACTIVE" | "DELETED"
  rules: Rule[];
}

interface Rule {
  name: string;
  eventPattern?: string;
  scheduleExpression?: string;
  state: string; // "ENABLED" | "DISABLED" | "DELETED"
  targets: Target[];
}

interface Target {
  Id: string;
  Arn: string;
  Input?: string;
  InputPath?: string;
}

export class EventBridgeStore {
  private buses: Map<string, EventBus> = new Map();
  private eventLog: Array<Record<string, unknown>> = [];
  private sqsStore: SqsStore | null = null;
  private snsStore: SnsStore | null = null;
  private stepFunctionsStore: StepFunctionsStore | null = null;
  private dynamoDbStore: DynamoStore | null = null;

  constructor() {
    // Create default event bus
    this._createBus("default");
  }

  setSqsStore(sqsStore: SqsStore): void {
    this.sqsStore = sqsStore;
  }

  setSnsStore(snsStore: SnsStore): void {
    this.snsStore = snsStore;
  }

  setStepFunctionsStore(stepFunctionsStore: StepFunctionsStore): void {
    this.stepFunctionsStore = stepFunctionsStore;
  }

  setDynamoDbStore(dynamoDbStore: DynamoStore): void {
    this.dynamoDbStore = dynamoDbStore;
  }

  reset(): void {
    this.buses.clear();
    this.eventLog = [];
    this._createBus("default");
  }

  private _createBus(name: string): EventBus {
    const arn = `arn:aws:events:${REGION}:${ACCOUNT_ID}:event-bus/${name}`;
    const bus: EventBus = { name, arn, state: "ACTIVE", rules: [] };
    this.buses.set(name, bus);
    return bus;
  }

  createEventBus(name: string): EventBus | null {
    const existing = this.buses.get(name);
    if (existing && existing.state !== "DELETED") return null;
    return this._createBus(name);
  }

  deleteEventBus(name: string): string | null {
    if (name === "default") return "default";
    const bus = this.buses.get(name);
    if (!bus || bus.state === "DELETED") return "not_found";
    const activeRules = bus.rules.filter((r) => r.state !== "DELETED");
    if (activeRules.length > 0) return "has_rules";
    bus.state = "DELETED";
    return null;
  }

  listEventBuses(): EventBus[] {
    return Array.from(this.buses.values()).filter((b) => b.state !== "DELETED");
  }

  /** Returns the bus or undefined regardless of state. */
  private _getBusRaw(name: string): EventBus | undefined {
    return this.buses.get(name);
  }

  /** Returns only ACTIVE buses. */
  getActiveEventBus(name: string): EventBus | undefined {
    const bus = this.buses.get(name);
    if (!bus || bus.state === "DELETED") return undefined;
    return bus;
  }

  /**
   * PutRule — returns:
   *   { rule } on success
   *   "bus_not_found" if the bus does not exist or is DELETED
   *   "rule_exists" if the rule already exists (not DELETED)
   */
  putRule(
    busName: string,
    name: string,
    eventPattern?: string,
    scheduleExpression?: string,
    state: string = "ENABLED",
  ): Rule | "bus_not_found" | "rule_exists" {
    const bus = this.getActiveEventBus(busName ?? "default");
    if (!bus) return "bus_not_found";
    const existing = bus.rules.find((r) => r.name === name);
    if (existing) {
      if (existing.state !== "DELETED") return "rule_exists";
      // Overwrite the DELETED slot
      existing.eventPattern = eventPattern;
      existing.scheduleExpression = scheduleExpression;
      existing.state = state;
      existing.targets = [];
      return existing;
    }
    const rule: Rule = { name, eventPattern, scheduleExpression, state, targets: [] };
    bus.rules.push(rule);
    return rule;
  }

  /**
   * PutTargets — returns:
   *   null on success
   *   "rule_not_found" if the rule does not exist or is DELETED
   */
  putTargets(busName: string, ruleName: string, targets: Target[]): null | "rule_not_found" {
    const bus =
      this.getActiveEventBus(busName ?? "default") ?? this.buses.get(busName ?? "default");
    const rule = bus?.rules.find((r) => r.name === ruleName && r.state !== "DELETED");
    if (!rule) return "rule_not_found";
    for (const target of targets) {
      const existing = rule.targets.findIndex((t) => t.Id === target.Id);
      if (existing >= 0) rule.targets[existing] = target;
      else rule.targets.push(target);
    }
    return null;
  }

  getEventBus(name: string): EventBus | undefined {
    return this.getActiveEventBus(name);
  }

  /**
   * deleteRule — returns:
   *   null on success
   *   "rule_not_found" if the rule does not exist
   *   "rule_deleted" if the rule is already DELETED
   *   "has_targets" if the rule has active targets
   */
  deleteRule(
    busName: string,
    ruleName: string,
  ): null | "rule_not_found" | "rule_deleted" | "has_targets" {
    const bus = this._getBusRaw(busName ?? "default");
    const rule = bus?.rules.find((r) => r.name === ruleName);
    if (!rule) return "rule_not_found";
    if (rule.state === "DELETED") return "rule_deleted";
    if (rule.targets.length > 0) return "has_targets";
    rule.state = "DELETED";
    return null;
  }

  /**
   * listTargetsByRule — returns:
   *   Target[] on success
   *   "rule_not_found" if the rule does not exist or is DELETED
   */
  listTargetsByRule(busName: string, ruleName: string): Target[] | "rule_not_found" {
    const bus = this._getBusRaw(busName ?? "default");
    const rule = bus?.rules.find((r) => r.name === ruleName);
    if (!rule || rule.state === "DELETED") return "rule_not_found";
    return rule.targets;
  }

  /**
   * removeTargets — returns:
   *   { failedIds: string[] } on partial/full success
   *   "rule_not_found" if the rule does not exist or is DELETED
   */
  removeTargets(
    busName: string,
    ruleName: string,
    ids: string[],
  ): { failedIds: string[] } | "rule_not_found" {
    const bus = this._getBusRaw(busName ?? "default");
    const rule = bus?.rules.find((r) => r.name === ruleName);
    if (!rule || rule.state === "DELETED") return "rule_not_found";
    const existingIds = new Set(rule.targets.map((t) => t.Id));
    const failedIds = ids.filter((id) => !existingIds.has(id));
    rule.targets = rule.targets.filter((t) => !ids.includes(t.Id));
    return { failedIds };
  }

  /**
   * setRuleState — returns:
   *   null on success
   *   "rule_not_found" if rule doesn't exist or is DELETED
   *   "already_state" if the rule is already in that state
   */
  setRuleState(
    busName: string,
    ruleName: string,
    state: string,
  ): null | "rule_not_found" | "already_state" {
    const bus = this._getBusRaw(busName ?? "default");
    const rule = bus?.rules.find((r) => r.name === ruleName);
    if (!rule || rule.state === "DELETED") return "rule_not_found";
    if (rule.state === state) return "already_state";
    rule.state = state;
    return null;
  }

  tagResource(resourceArn: string, tags: Array<{ Key: string; Value: string }>): void {
    if (!this._tags.has(resourceArn)) this._tags.set(resourceArn, {});
    const tagMap = this._tags.get(resourceArn)!;
    for (const tag of tags) tagMap[tag.Key] = tag.Value;
  }

  untagResource(resourceArn: string, tagKeys: string[]): void {
    const tagMap = this._tags.get(resourceArn) ?? {};
    for (const key of tagKeys) delete tagMap[key];
    this._tags.set(resourceArn, tagMap);
  }

  listTagsForResource(resourceArn: string): Array<{ Key: string; Value: string }> {
    const tagMap = this._tags.get(resourceArn) ?? {};
    return Object.entries(tagMap).map(([Key, Value]) => ({ Key, Value }));
  }

  private _tags: Map<string, Record<string, string>> = new Map();

  /**
   * putEvents — returns:
   *   null on success (events queued)
   *   "bus_not_found" if event bus doesn't exist
   *   "no_enabled_rule" if no ENABLED rule is on that bus
   *   "no_target" if no enabled rule has any targets
   *   "capacity_exhausted" if a target service has no available capacity slots
   */
  putEvents(
    busName: string,
    events: Array<Record<string, unknown>>,
    capacityConfigs?: Record<string, { slots: number | null }>,
  ): null | "bus_not_found" | "no_enabled_rule" | "no_target" | "capacity_exhausted" {
    const bus = this.getActiveEventBus(busName);
    if (!bus) return "bus_not_found";
    const enabledRules = bus.rules.filter((r) => r.state === "ENABLED");
    if (enabledRules.length === 0) return "no_enabled_rule";
    const rulesWithTargets = enabledRules.filter((r) => r.targets.length > 0);
    if (rulesWithTargets.length === 0) return "no_target";
    if (capacityConfigs) {
      if (isExhausted(capacityConfigs["events"] ?? { slots: null })) {
        return "capacity_exhausted";
      }
      for (const rule of rulesWithTargets) {
        for (const target of rule.targets) {
          const service = serviceFromArn(target.Arn);
          if (service && isExhausted(capacityConfigs[service] ?? { slots: null })) {
            return "capacity_exhausted";
          }
        }
      }
    }
    this.eventLog.push(...events);
    const eventPayload = JSON.stringify(events);
    for (const rule of rulesWithTargets) {
      for (const target of rule.targets) {
        const messageBody = target.Input ?? eventPayload;
        if (target.Arn.includes(":sqs:") && this.sqsStore) {
          const queue = this.sqsStore.getQueue(target.Arn);
          if (queue) {
            queue.sendMessage(messageBody);
          }
        } else if (target.Arn.includes(":sns:") && this.snsStore) {
          const topic = this.snsStore.getTopic(target.Arn);
          if (topic) {
            this.snsStore.publish(target.Arn, messageBody);
          }
        } else if (target.Arn.includes(":states:") && this.stepFunctionsStore) {
          void this.stepFunctionsStore.startExecution(target.Arn, messageBody);
        } else if (target.Arn.includes(":dynamodb:") && this.dynamoDbStore) {
          const tableNameMatch = target.Arn.match(/[/]([^/]+)$/);
          const tableName = tableNameMatch ? tableNameMatch[1] : "";
          if (tableName) {
            const item = typeof messageBody === "string" ? JSON.parse(messageBody) : messageBody;
            this.dynamoDbStore.putItem(tableName, item as Record<string, unknown>);
          }
        }
      }
    }
    return null;
  }

  /**
   * putEventsInternal — called by other services (e.g. S3) to deliver events
   * directly to an event bus without capacity or rule checks. Events are logged
   * and dispatched to all ENABLED rule targets on the named bus.
   */
  putEventsInternal(busName: string, events: Array<Record<string, unknown>>): void {
    const bus = this.getActiveEventBus(busName);
    if (!bus) return;
    this.eventLog.push(...events);
    const eventPayload = JSON.stringify(events);
    const enabledRules = bus.rules.filter((r) => r.state === "ENABLED");
    for (const rule of enabledRules) {
      for (const target of rule.targets) {
        const messageBody = target.Input ?? eventPayload;
        if (target.Arn.includes(":sqs:") && this.sqsStore) {
          const queue = this.sqsStore.getQueue(target.Arn);
          if (queue) {
            queue.sendMessage(messageBody);
          }
        } else if (target.Arn.includes(":sns:") && this.snsStore) {
          try {
            this.snsStore.publish(target.Arn, messageBody);
          } catch {
            // ignore if topic does not exist
          }
        } else if (target.Arn.includes(":states:") && this.stepFunctionsStore) {
          void this.stepFunctionsStore.startExecution(target.Arn, messageBody);
        } else if (target.Arn.includes(":dynamodb:") && this.dynamoDbStore) {
          const tableNameMatch = target.Arn.match(/[/]([^/]+)$/);
          const tableName = tableNameMatch ? tableNameMatch[1] : "";
          if (tableName) {
            const item = typeof messageBody === "string" ? JSON.parse(messageBody) : messageBody;
            this.dynamoDbStore.putItem(tableName, item as Record<string, unknown>);
          }
        }
      }
    }
  }

  getEvents(): Array<Record<string, unknown>> {
    return [...this.eventLog];
  }
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}

const TARGET_PREFIXES = ["AmazonEventBridge.", "AWSEvents."];

export function registerEventBridge(app: FastifyInstance, state: ServerState): EventBridgeStore {
  const store = new EventBridgeStore();
  state.resetCallbacks.push(() => store.reset());

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string) ?? "";
    let operation = target;
    for (const prefix of TARGET_PREFIXES) {
      if (target.startsWith(prefix)) {
        operation = target.slice(prefix.length);
        break;
      }
    }
    const body = req.body as Record<string, unknown>;
    const ctx = createRequestContext("eventbridge", operation);

    if (await applyIamAuth(state, "events", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "events", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "events", operation, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    handleOperation(operation, body, store, state, reply);
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  void ACCOUNT_ID;
  void REGION;

  return store;
}

function handleOperation(
  operation: string,
  body: Record<string, unknown>,
  store: EventBridgeStore,
  state: ServerState,
  reply: FastifyReply,
): void {
  switch (operation) {
    case "CreateEventBus": {
      const name = body.Name as string;
      const bus = store.createEventBus(name);
      if (bus === null) {
        jsonReply(
          reply,
          { __type: "EventBusAlreadyExists", message: `Event bus ${name} already exists.` },
          400,
        );
        return;
      }
      jsonReply(reply, { EventBusArn: bus.arn });
      break;
    }

    case "DeleteEventBus": {
      const deleteName = body.Name as string;
      const deleteError = store.deleteEventBus(deleteName);
      if (deleteError === "default") {
        jsonReply(
          reply,
          {
            __type: "OperationDisabledException",
            message: "Operation not permitted on default event bus.",
          },
          400,
        );
        return;
      }
      if (deleteError === "not_found") {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: "Event bus not found." },
          400,
        );
        return;
      }
      if (deleteError === "has_rules") {
        jsonReply(
          reply,
          { __type: "IllegalStatusException", message: "Event bus has active rules." },
          400,
        );
        return;
      }
      jsonReply(reply, {});
      break;
    }

    case "ListEventBuses": {
      const buses = store.listEventBuses();
      jsonReply(reply, {
        EventBuses: buses.map((b) => ({ Name: b.name, Arn: b.arn })),
      });
      break;
    }

    case "PutRule": {
      const busName = (body.EventBusName as string) ?? "default";
      const result = store.putRule(
        busName,
        body.Name as string,
        body.EventPattern as string | undefined,
        body.ScheduleExpression as string | undefined,
        (body.State as string) ?? "ENABLED",
      );
      if (result === "bus_not_found") {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: "Event bus not found." },
          400,
        );
        return;
      }
      if (result === "rule_exists") {
        jsonReply(
          reply,
          { __type: "ResourceAlreadyExistsException", message: "Rule already exists." },
          400,
        );
        return;
      }
      const rule = result;
      jsonReply(reply, {
        RuleArn: `arn:aws:events:us-east-1:${ACCOUNT_ID}:rule/${busName}/${rule.name}`,
      });
      break;
    }

    case "PutTargets": {
      const ptBusName = (body.EventBusName as string) ?? "default";
      const ptTargets = (body.Targets as Target[]) ?? [];
      // Validate that each target ARN references an existing resource
      for (const t of ptTargets) {
        if (t.Arn) {
          const arnParts = t.Arn.split(":");
          // arn:aws:<service>:region:account:...
          const service = arnParts[2] ?? "";
          const checker = state.arnExistsCheckers.get(service);
          if (checker && !checker(t.Arn)) {
            jsonReply(
              reply,
              {
                __type: "ResourceNotFoundException",
                message: `Target resource not found: ${t.Arn}`,
              },
              400,
            );
            return;
          }
        }
      }
      const ptError = store.putTargets(ptBusName, body.Rule as string, ptTargets);
      if (ptError === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      jsonReply(reply, { FailedEntryCount: 0, FailedEntries: [] });
      break;
    }

    case "PutEvents": {
      const entries = (body.Entries as Array<Record<string, unknown>>) ?? [];
      // Extract bus name from first entry, defaulting to "default"
      const eventBusName = (entries[0]?.EventBusName as string) ?? "default";
      const putEventsError = store.putEvents(eventBusName, entries, state.capacityConfigs);
      if (putEventsError === "bus_not_found") {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: "Event bus not found." },
          400,
        );
        return;
      }
      if (putEventsError === "no_enabled_rule") {
        jsonReply(
          reply,
          {
            __type: "ResourceNotFoundException",
            message: "No rule is associated with the event bus.",
          },
          400,
        );
        return;
      }
      if (putEventsError === "no_target") {
        jsonReply(
          reply,
          {
            __type: "ResourceNotFoundException",
            message: "No target is associated with the rule.",
          },
          400,
        );
        return;
      }
      if (putEventsError === "capacity_exhausted") {
        jsonReply(
          reply,
          {
            __type: "ThrottlingException",
            message: "No capacity slot available for target service.",
          },
          400,
        );
        return;
      }
      jsonReply(reply, {
        FailedEntryCount: 0,
        Entries: entries.map(() => ({
          EventId: uuidv4(),
        })),
      });
      break;
    }

    case "ListRules": {
      const busName = (body.EventBusName as string) ?? "default";
      const bus = store.getEventBus(busName);
      if (!bus) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: "Event bus not found." },
          400,
        );
        return;
      }
      const activeRules = bus.rules.filter((r) => r.state !== "DELETED");
      jsonReply(reply, { Rules: activeRules.map((r) => ({ Name: r.name, State: r.state })) });
      break;
    }

    case "DescribeRule": {
      const busName = (body.EventBusName as string) ?? "default";
      const buses = store.listEventBuses();
      const bus = buses.find((b) => b.name === busName);
      const rule = bus?.rules.find((r) => r.name === body.Name);
      if (!rule || rule.state === "DELETED") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      jsonReply(reply, { Name: rule.name, State: rule.state, EventPattern: rule.eventPattern });
      break;
    }

    case "DescribeEventBus": {
      const busName = (body.Name as string) ?? "default";
      const bus = store.getEventBus(busName);
      if (!bus) {
        jsonReply(
          reply,
          { __type: "ResourceNotFoundException", message: `Event bus ${busName} not found` },
          400,
        );
        return;
      }
      jsonReply(reply, { Name: bus.name, Arn: bus.arn });
      break;
    }

    case "DeleteRule": {
      const drBusName = (body.EventBusName as string) ?? "default";
      const drError = store.deleteRule(drBusName, body.Name as string);
      if (drError === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      if (drError === "rule_deleted") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      if (drError === "has_targets") {
        jsonReply(
          reply,
          { __type: "ManagedRuleException", message: "Rule has active targets." },
          400,
        );
        return;
      }
      jsonReply(reply, {});
      break;
    }

    case "ListTargetsByRule": {
      const ltBusName = (body.EventBusName as string) ?? "default";
      const ltResult = store.listTargetsByRule(ltBusName, body.Rule as string);
      if (ltResult === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      jsonReply(reply, { Targets: ltResult });
      break;
    }

    case "RemoveTargets": {
      const rtBusName = (body.EventBusName as string) ?? "default";
      const rtResult = store.removeTargets(
        rtBusName,
        body.Rule as string,
        (body.Ids as string[]) ?? [],
      );
      if (rtResult === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      const failedEntries = rtResult.failedIds.map((id: string) => ({
        TargetId: id,
        ErrorCode: "ResourceNotFoundException",
        ErrorMessage: "Target not found",
      }));
      jsonReply(reply, {
        FailedEntryCount: failedEntries.length,
        FailedEntries: failedEntries,
      });
      break;
    }

    case "EnableRule": {
      const enError = store.setRuleState(
        (body.EventBusName as string) ?? "default",
        body.Name as string,
        "ENABLED",
      );
      if (enError === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      if (enError === "already_state") {
        jsonReply(
          reply,
          { __type: "InvalidParameterException", message: "Rule is already enabled." },
          400,
        );
        return;
      }
      jsonReply(reply, {});
      break;
    }

    case "DisableRule": {
      const disError = store.setRuleState(
        (body.EventBusName as string) ?? "default",
        body.Name as string,
        "DISABLED",
      );
      if (disError === "rule_not_found") {
        jsonReply(reply, { __type: "ResourceNotFoundException", message: "Rule not found." }, 400);
        return;
      }
      if (disError === "already_state") {
        jsonReply(
          reply,
          { __type: "InvalidParameterException", message: "Rule is already disabled." },
          400,
        );
        return;
      }
      jsonReply(reply, {});
      break;
    }

    case "TagResource": {
      store.tagResource(
        body.ResourceARN as string,
        (body.Tags as Array<{ Key: string; Value: string }>) ?? [],
      );
      jsonReply(reply, {});
      break;
    }

    case "UntagResource": {
      store.untagResource(body.ResourceARN as string, (body.TagKeys as string[]) ?? []);
      jsonReply(reply, {});
      break;
    }

    case "ListTagsForResource": {
      const tags = store.listTagsForResource(body.ResourceARN as string);
      jsonReply(reply, { Tags: tags });
      break;
    }

    default: {
      jsonReply(
        reply,
        {
          __type: "UnknownOperationException",
          message: `lws: EventBridge operation '${operation}' not implemented`,
        },
        400,
      );
    }
  }
}
