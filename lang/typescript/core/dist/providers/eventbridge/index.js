"use strict";
/** EventBridge wire-protocol Fastify plugin. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.EventBridgeStore = void 0;
exports.registerEventBridge = registerEventBridge;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";
class EventBridgeStore {
    constructor() {
        this.buses = new Map();
        this.eventLog = [];
        this._tags = new Map();
        // Create default event bus
        this._createBus("default");
    }
    reset() {
        this.buses.clear();
        this.eventLog = [];
        this._createBus("default");
    }
    _createBus(name) {
        const arn = `arn:aws:events:${REGION}:${ACCOUNT_ID}:event-bus/${name}`;
        const bus = { name, arn, rules: [] };
        this.buses.set(name, bus);
        return bus;
    }
    createEventBus(name) {
        if (this.buses.has(name))
            return this.buses.get(name);
        return this._createBus(name);
    }
    deleteEventBus(name) {
        this.buses.delete(name);
    }
    listEventBuses() {
        return Array.from(this.buses.values());
    }
    putRule(busName, name, eventPattern, scheduleExpression, state = "ENABLED") {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        const existing = bus.rules.find((r) => r.name === name);
        if (existing) {
            existing.eventPattern = eventPattern;
            existing.scheduleExpression = scheduleExpression;
            existing.state = state;
            return existing;
        }
        const rule = { name, eventPattern, scheduleExpression, state, targets: [] };
        bus.rules.push(rule);
        return rule;
    }
    putTargets(busName, ruleName, targets) {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        const rule = bus.rules.find((r) => r.name === ruleName);
        if (rule) {
            for (const target of targets) {
                const existing = rule.targets.findIndex((t) => t.Id === target.Id);
                if (existing >= 0)
                    rule.targets[existing] = target;
                else
                    rule.targets.push(target);
            }
        }
    }
    getEventBus(name) {
        return this.buses.get(name);
    }
    deleteRule(busName, ruleName) {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        if (bus) {
            bus.rules = bus.rules.filter((r) => r.name !== ruleName);
        }
    }
    listTargetsByRule(busName, ruleName) {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        const rule = bus?.rules.find((r) => r.name === ruleName);
        return rule?.targets ?? [];
    }
    removeTargets(busName, ruleName, ids) {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        const rule = bus?.rules.find((r) => r.name === ruleName);
        if (rule) {
            rule.targets = rule.targets.filter((t) => !ids.includes(t.Id));
        }
    }
    setRuleState(busName, ruleName, state) {
        const bus = this.buses.get(busName ?? "default") ?? this.buses.get("default");
        const rule = bus?.rules.find((r) => r.name === ruleName);
        if (rule)
            rule.state = state;
    }
    tagResource(resourceArn, tags) {
        if (!this._tags.has(resourceArn))
            this._tags.set(resourceArn, {});
        const tagMap = this._tags.get(resourceArn);
        for (const tag of tags)
            tagMap[tag.Key] = tag.Value;
    }
    untagResource(resourceArn, tagKeys) {
        const tagMap = this._tags.get(resourceArn) ?? {};
        for (const key of tagKeys)
            delete tagMap[key];
        this._tags.set(resourceArn, tagMap);
    }
    listTagsForResource(resourceArn) {
        const tagMap = this._tags.get(resourceArn) ?? {};
        return Object.entries(tagMap).map(([Key, Value]) => ({ Key, Value }));
    }
    putEvents(events) {
        this.eventLog.push(...events);
        return events.length;
    }
    getEvents() {
        return [...this.eventLog];
    }
}
exports.EventBridgeStore = EventBridgeStore;
function jsonReply(reply, data, status = 200) {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.1").send(data);
}
const TARGET_PREFIXES = ["AmazonEventBridge.", "AWSEvents."];
function registerEventBridge(app, state) {
    const store = new EventBridgeStore();
    state.resetCallbacks.push(() => store.reset());
    app.post("/", async (req, reply) => {
        const target = req.headers["x-amz-target"] ?? "";
        let operation = target;
        for (const prefix of TARGET_PREFIXES) {
            if (target.startsWith(prefix)) {
                operation = target.slice(prefix.length);
                break;
            }
        }
        const body = req.body;
        const ctx = (0, logging_1.createRequestContext)("eventbridge", operation);
        if (await (0, iam_1.applyIamAuth)(state, "events", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "events", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "events", operation, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        handleOperation(operation, body, store, reply);
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    void ACCOUNT_ID;
    void REGION;
    return store;
}
function handleOperation(operation, body, store, reply) {
    switch (operation) {
        case "CreateEventBus": {
            const bus = store.createEventBus(body.Name);
            jsonReply(reply, { EventBusArn: bus.arn });
            break;
        }
        case "DeleteEventBus": {
            store.deleteEventBus(body.Name);
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
            const rule = store.putRule(body.EventBusName ?? "default", body.Name, body.EventPattern, body.ScheduleExpression, body.State ?? "ENABLED");
            const bus = store.listEventBuses().find((b) => b.rules.includes(rule));
            jsonReply(reply, {
                RuleArn: `arn:aws:events:us-east-1:${ACCOUNT_ID}:rule/${bus?.name ?? "default"}/${rule.name}`,
            });
            break;
        }
        case "PutTargets": {
            store.putTargets(body.EventBusName ?? "default", body.Rule, body.Targets ?? []);
            jsonReply(reply, { FailedEntryCount: 0, FailedEntries: [] });
            break;
        }
        case "PutEvents": {
            const events = body.Entries ?? [];
            store.putEvents(events);
            jsonReply(reply, {
                FailedEntryCount: 0,
                Entries: events.map(() => ({
                    EventId: (0, uuid_1.v4)(),
                })),
            });
            break;
        }
        case "ListRules": {
            const buses = store.listEventBuses();
            const busName = body.EventBusName ?? "default";
            const bus = buses.find((b) => b.name === busName);
            jsonReply(reply, { Rules: (bus?.rules ?? []).map((r) => ({ Name: r.name, State: r.state })) });
            break;
        }
        case "DescribeRule": {
            const busName = body.EventBusName ?? "default";
            const buses = store.listEventBuses();
            const bus = buses.find((b) => b.name === busName);
            const rule = bus?.rules.find((r) => r.name === body.Name);
            if (!rule) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: `Rule ${body.Name} not found` }, 400);
                return;
            }
            jsonReply(reply, { Name: rule.name, State: rule.state, EventPattern: rule.eventPattern });
            break;
        }
        case "DescribeEventBus": {
            const busName = body.Name ?? "default";
            const bus = store.getEventBus(busName);
            if (!bus) {
                jsonReply(reply, { __type: "ResourceNotFoundException", message: `Event bus ${busName} not found` }, 400);
                return;
            }
            jsonReply(reply, { Name: bus.name, Arn: bus.arn });
            break;
        }
        case "DeleteRule": {
            store.deleteRule(body.EventBusName ?? "default", body.Name);
            jsonReply(reply, {});
            break;
        }
        case "ListTargetsByRule": {
            const targets = store.listTargetsByRule(body.EventBusName ?? "default", body.Rule);
            jsonReply(reply, { Targets: targets });
            break;
        }
        case "RemoveTargets": {
            store.removeTargets(body.EventBusName ?? "default", body.Rule, body.Ids ?? []);
            jsonReply(reply, { FailedEntryCount: 0, FailedEntries: [] });
            break;
        }
        case "EnableRule": {
            store.setRuleState(body.EventBusName ?? "default", body.Name, "ENABLED");
            jsonReply(reply, {});
            break;
        }
        case "DisableRule": {
            store.setRuleState(body.EventBusName ?? "default", body.Name, "DISABLED");
            jsonReply(reply, {});
            break;
        }
        case "TagResource": {
            store.tagResource(body.ResourceARN, body.Tags ?? []);
            jsonReply(reply, {});
            break;
        }
        case "UntagResource": {
            store.untagResource(body.ResourceARN, body.TagKeys ?? []);
            jsonReply(reply, {});
            break;
        }
        case "ListTagsForResource": {
            const tags = store.listTagsForResource(body.ResourceARN);
            jsonReply(reply, { Tags: tags });
            break;
        }
        default: {
            jsonReply(reply, {
                __type: "UnknownOperationException",
                message: `lws: EventBridge operation '${operation}' not implemented`,
            }, 400);
        }
    }
}
//# sourceMappingURL=index.js.map