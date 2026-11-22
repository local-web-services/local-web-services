import type { IProvider } from "../../interfaces/provider.js";

export interface EventBusConfig {
  name: string;
}

interface StoredTarget {
  id: string;
  arn: string;
}

interface StoredRule {
  name: string;
  busName: string;
  eventPattern?: string;
  scheduleExpression?: string;
  state: "ENABLED" | "DISABLED";
  arn: string;
  targets: StoredTarget[];
}

interface StoredEvent {
  eventBusName: string;
  source: string;
  detailType: string;
  detail: string;
  id: string;
  time: string;
}

interface StoredBus {
  name: string;
  arn: string;
}

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "123456789012";

function busArn(name: string): string {
  return `arn:aws:events:${FAKE_REGION}:${FAKE_ACCOUNT}:event-bus/${name}`;
}

function ruleArn(busName: string, ruleName: string): string {
  return `arn:aws:events:${FAKE_REGION}:${FAKE_ACCOUNT}:rule/${busName}/${ruleName}`;
}

function ruleKey(name: string, busName: string): string {
  return `${name}@${busName}`;
}

export class EventBridgeProvider implements IProvider {
  readonly name = "events";

  private _buses = new Map<string, StoredBus>();
  private _events = new Map<string, StoredEvent[]>();
  private _rules = new Map<string, StoredRule>();
  private _tags = new Map<string, Map<string, string>>();
  private _preconfiguredBusNames: ReadonlySet<string>;
  private _running = false;

  constructor(configs: EventBusConfig[] = []) {
    this._preconfiguredBusNames = new Set([...configs.map((c) => c.name), "default"]);
  }

  async start(): Promise<void> {
    this._seedBus("default");
    for (const config of this._preconfiguredBusNames) {
      if (config !== "default") this._seedBus(config);
    }
    this._running = true;
  }

  async stop(): Promise<void> {
    this._buses.clear();
    this._events.clear();
    this._rules.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const name of [...this._buses.keys()]) {
      if (!this._preconfiguredBusNames.has(name)) {
        this._buses.delete(name);
        this._events.delete(name);
      }
    }
    for (const name of this._preconfiguredBusNames) {
      this._events.set(name, []);
    }
    for (const [key, rule] of [...this._rules.entries()]) {
      if (!this._preconfiguredBusNames.has(rule.busName)) {
        this._rules.delete(key);
      }
    }
  }

  createEventBus(name: string): { EventBusArn: string } {
    if (this._buses.has(name)) {
      throw new Error(`ResourceAlreadyExistsException: Event bus '${name}' already exists`);
    }
    this._seedBus(name);
    return { EventBusArn: busArn(name) };
  }

  deleteEventBus(name: string): void {
    if (name === "default") {
      throw new Error(`ValidationException: Cannot delete the default event bus`);
    }
    if (!this._buses.has(name)) {
      throw new Error(`ResourceNotFoundException: Event bus '${name}' not found`);
    }
    this._buses.delete(name);
    this._events.delete(name);
  }

  listEventBuses(namePrefix?: string): { EventBuses: { Name: string; Arn: string }[] } {
    const buses = [...this._buses.values()]
      .filter((b) => namePrefix === undefined || b.name.startsWith(namePrefix))
      .map((b) => ({ Name: b.name, Arn: b.arn }));
    return { EventBuses: buses };
  }

  describeEventBus(name: string): { Name: string; Arn: string } {
    const bus = this._buses.get(name);
    if (bus === undefined) {
      throw new Error(`ResourceNotFoundException: Event bus '${name}' not found`);
    }
    return { Name: bus.name, Arn: bus.arn };
  }

  putRule(
    name: string,
    busName: string = "default",
    eventPattern?: string,
    scheduleExpression?: string,
    state: "ENABLED" | "DISABLED" = "ENABLED",
  ): { RuleArn: string } {
    if (!this._buses.has(busName)) {
      throw new Error(`ResourceNotFoundException: Event bus '${busName}' not found`);
    }
    const key = ruleKey(name, busName);
    const existing = this._rules.get(key);
    const rule: StoredRule = {
      name,
      busName,
      ...(eventPattern !== undefined && { eventPattern }),
      ...(scheduleExpression !== undefined && { scheduleExpression }),
      state,
      arn: ruleArn(busName, name),
      targets: existing?.targets ?? [],
    };
    this._rules.set(key, rule);
    return { RuleArn: rule.arn };
  }

  deleteRule(name: string, busName: string = "default"): void {
    const key = ruleKey(name, busName);
    if (!this._rules.has(key)) {
      throw new Error(`ResourceNotFoundException: Rule '${name}' not found on bus '${busName}'`);
    }
    this._rules.delete(key);
  }

  listRules(
    busName: string = "default",
    namePrefix?: string,
  ): { Rules: object[] } {
    const rules = [...this._rules.values()]
      .filter((r) => r.busName === busName)
      .filter((r) => namePrefix === undefined || r.name.startsWith(namePrefix))
      .map((r) => ({
        Name: r.name,
        Arn: r.arn,
        State: r.state,
        ...(r.eventPattern !== undefined && { EventPattern: r.eventPattern }),
        ...(r.scheduleExpression !== undefined && { ScheduleExpression: r.scheduleExpression }),
      }));
    return { Rules: rules };
  }

  describeRule(name: string, busName: string = "default"): object {
    const rule = this._rules.get(ruleKey(name, busName));
    if (rule === undefined) {
      throw new Error(`ResourceNotFoundException: Rule '${name}' not found on bus '${busName}'`);
    }
    return {
      Name: rule.name,
      Arn: rule.arn,
      State: rule.state,
      EventBusName: rule.busName,
      ...(rule.eventPattern !== undefined && { EventPattern: rule.eventPattern }),
      ...(rule.scheduleExpression !== undefined && { ScheduleExpression: rule.scheduleExpression }),
    };
  }

  enableRule(name: string, busName: string = "default"): void {
    const key = ruleKey(name, busName);
    const rule = this._rules.get(key);
    if (rule === undefined) throw new Error(`ResourceNotFoundException: Rule '${name}' not found`);
    this._rules.set(key, { ...rule, state: "ENABLED" });
  }

  disableRule(name: string, busName: string = "default"): void {
    const key = ruleKey(name, busName);
    const rule = this._rules.get(key);
    if (rule === undefined) throw new Error(`ResourceNotFoundException: Rule '${name}' not found`);
    this._rules.set(key, { ...rule, state: "DISABLED" });
  }

  putTargets(
    ruleName: string,
    busName: string = "default",
    targets: { Id: string; Arn: string }[],
  ): { FailedEntryCount: number; FailedEntries: unknown[] } {
    const key = ruleKey(ruleName, busName);
    const rule = this._rules.get(key);
    if (rule === undefined) throw new Error(`ResourceNotFoundException: Rule '${ruleName}' not found`);
    const updated = { ...rule };
    for (const t of targets) {
      const idx = updated.targets.findIndex((x) => x.id === t.Id);
      if (idx >= 0) updated.targets[idx] = { id: t.Id, arn: t.Arn };
      else updated.targets.push({ id: t.Id, arn: t.Arn });
    }
    this._rules.set(key, updated);
    return { FailedEntryCount: 0, FailedEntries: [] };
  }

  removeTargets(
    ruleName: string,
    busName: string = "default",
    ids: string[],
  ): { FailedEntryCount: number; FailedEntries: unknown[] } {
    const key = ruleKey(ruleName, busName);
    const rule = this._rules.get(key);
    if (rule === undefined) throw new Error(`ResourceNotFoundException: Rule '${ruleName}' not found`);
    const updated = { ...rule, targets: rule.targets.filter((t) => !ids.includes(t.id)) };
    this._rules.set(key, updated);
    return { FailedEntryCount: 0, FailedEntries: [] };
  }

  listTargetsByRule(
    ruleName: string,
    busName: string = "default",
  ): { Targets: { Id: string; Arn: string }[] } {
    const rule = this._rules.get(ruleKey(ruleName, busName));
    if (rule === undefined) throw new Error(`ResourceNotFoundException: Rule '${ruleName}' not found`);
    return { Targets: rule.targets.map((t) => ({ Id: t.id, Arn: t.arn })) };
  }

  putEvents(
    entries: { EventBusName?: string; Source: string; DetailType: string; Detail: string }[],
  ): { FailedEntryCount: number; Entries: { EventId: string }[] } {
    const resultEntries: { EventId: string }[] = [];
    for (const entry of entries) {
      const busName = entry.EventBusName ?? "default";
      if (!this._events.has(busName)) this._events.set(busName, []);
      const id = `evt-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`;
      this._events.get(busName)!.push({
        eventBusName: busName,
        source: entry.Source,
        detailType: entry.DetailType,
        detail: entry.Detail,
        id,
        time: new Date().toISOString(),
      });
      resultEntries.push({ EventId: id });
    }
    return { FailedEntryCount: 0, Entries: resultEntries };
  }

  listEvents(busName: string): StoredEvent[] {
    return this._events.get(busName) ?? [];
  }

  tagResource(arn: string, tags: { Key: string; Value: string }[]): void {
    if (!this._tags.has(arn)) this._tags.set(arn, new Map());
    for (const t of tags) this._tags.get(arn)!.set(t.Key, t.Value);
  }

  untagResource(arn: string, tagKeys: string[]): void {
    const m = this._tags.get(arn);
    if (m !== undefined) for (const k of tagKeys) m.delete(k);
  }

  listTagsForResource(arn: string): { Key: string; Value: string }[] {
    const m = this._tags.get(arn);
    if (m === undefined) return [];
    return [...m.entries()].map(([Key, Value]) => ({ Key, Value }));
  }

  private _seedBus(name: string): void {
    this._buses.set(name, { name, arn: busArn(name) });
    if (!this._events.has(name)) this._events.set(name, []);
  }
}
