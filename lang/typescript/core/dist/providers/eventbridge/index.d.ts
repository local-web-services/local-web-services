/** EventBridge wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
interface EventBus {
    name: string;
    arn: string;
    rules: Rule[];
}
interface Rule {
    name: string;
    eventPattern?: string;
    scheduleExpression?: string;
    state: string;
    targets: Target[];
}
interface Target {
    Id: string;
    Arn: string;
    Input?: string;
    InputPath?: string;
}
export declare class EventBridgeStore {
    private buses;
    private eventLog;
    constructor();
    reset(): void;
    private _createBus;
    createEventBus(name: string): EventBus;
    deleteEventBus(name: string): void;
    listEventBuses(): EventBus[];
    putRule(busName: string, name: string, eventPattern?: string, scheduleExpression?: string, state?: string): Rule;
    putTargets(busName: string, ruleName: string, targets: Target[]): void;
    getEventBus(name: string): EventBus | undefined;
    deleteRule(busName: string, ruleName: string): void;
    listTargetsByRule(busName: string, ruleName: string): Target[];
    removeTargets(busName: string, ruleName: string, ids: string[]): void;
    setRuleState(busName: string, ruleName: string, state: string): void;
    tagResource(resourceArn: string, tags: Array<{
        Key: string;
        Value: string;
    }>): void;
    untagResource(resourceArn: string, tagKeys: string[]): void;
    listTagsForResource(resourceArn: string): Array<{
        Key: string;
        Value: string;
    }>;
    private _tags;
    putEvents(events: Array<Record<string, unknown>>): number;
    getEvents(): Array<Record<string, unknown>>;
}
export declare function registerEventBridge(app: FastifyInstance, state: ServerState): EventBridgeStore;
export {};
//# sourceMappingURL=index.d.ts.map