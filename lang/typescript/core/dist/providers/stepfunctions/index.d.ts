/** StepFunctions wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
import { type StateMachineDefinition, type Execution, type TaskInvoker } from "./engine";
interface StateMachine {
    name: string;
    arn: string;
    definition: StateMachineDefinition;
    roleArn: string;
    type: string;
    status: string;
    creationDate: number;
}
export declare class StepFunctionsStore {
    private stateMachines;
    private executions;
    private taskInvoker;
    private tags;
    constructor(invoker?: TaskInvoker);
    reset(): void;
    createStateMachine(name: string, definition: string | StateMachineDefinition, roleArn: string, type?: string): StateMachine;
    deleteStateMachine(arn: string): void;
    describeStateMachine(arn: string): StateMachine | undefined;
    listStateMachines(): StateMachine[];
    startExecution(stateMachineArn: string, input: string, name?: string): Promise<Execution>;
    describeExecution(executionArn: string): Execution | undefined;
    listExecutions(stateMachineArn: string): Execution[];
    stopExecution(executionArn: string): void;
    tagResource(arn: string, tagsArr: Array<{
        key: string;
        value: string;
    }>): void;
    untagResource(arn: string, tagKeys: string[]): void;
    listTagsForResource(arn: string): Record<string, string>;
}
export declare function registerStepFunctions(app: FastifyInstance, state: ServerState): StepFunctionsStore;
export {};
//# sourceMappingURL=index.d.ts.map