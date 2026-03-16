/** Step Functions ASL interpreter. */
export interface StateMachineDefinition {
    Comment?: string;
    StartAt: string;
    States: Record<string, AslState>;
    TimeoutSeconds?: number;
}
export type AslState = PassState | TaskState | ChoiceState | WaitState | SucceedState | FailState | ParallelState | MapState;
export interface BaseState {
    Type: string;
    Comment?: string;
    InputPath?: string;
    OutputPath?: string;
    ResultPath?: string;
    Parameters?: Record<string, unknown>;
    Next?: string;
    End?: boolean;
    Retry?: RetryConfig[];
    Catch?: CatchConfig[];
}
export interface PassState extends BaseState {
    Type: "Pass";
    Result?: unknown;
}
export interface TaskState extends BaseState {
    Type: "Task";
    Resource: string;
    TimeoutSeconds?: number;
    HeartbeatSeconds?: number;
}
export interface ChoiceState {
    Type: "Choice";
    Comment?: string;
    InputPath?: string;
    OutputPath?: string;
    Choices: ChoiceRule[];
    Default?: string;
}
export interface ChoiceRule {
    Next: string;
    Variable?: string;
    StringEquals?: string;
    StringEqualsPath?: string;
    StringLessThan?: string;
    StringGreaterThan?: string;
    StringLessThanOrEquals?: string;
    StringGreaterThanOrEquals?: string;
    StringMatches?: string;
    NumericEquals?: number;
    NumericLessThan?: number;
    NumericGreaterThan?: number;
    NumericLessThanOrEquals?: number;
    NumericGreaterThanOrEquals?: number;
    BooleanEquals?: boolean;
    IsNull?: boolean;
    IsPresent?: boolean;
    IsString?: boolean;
    IsNumeric?: boolean;
    IsBoolean?: boolean;
    And?: ChoiceRule[];
    Or?: ChoiceRule[];
    Not?: ChoiceRule;
}
export interface WaitState extends BaseState {
    Type: "Wait";
    Seconds?: number;
    SecondsPath?: string;
    Timestamp?: string;
    TimestampPath?: string;
}
export interface SucceedState {
    Type: "Succeed";
    Comment?: string;
    InputPath?: string;
    OutputPath?: string;
}
export interface FailState {
    Type: "Fail";
    Comment?: string;
    Error?: string;
    Cause?: string;
}
export interface ParallelState extends BaseState {
    Type: "Parallel";
    Branches: Array<{
        StartAt: string;
        States: Record<string, AslState>;
    }>;
}
export interface MapState extends BaseState {
    Type: "Map";
    ItemsPath?: string;
    Iterator: {
        StartAt: string;
        States: Record<string, AslState>;
    };
    MaxConcurrency?: number;
}
export interface RetryConfig {
    ErrorEquals: string[];
    IntervalSeconds?: number;
    MaxAttempts?: number;
    BackoffRate?: number;
}
export interface CatchConfig {
    ErrorEquals: string[];
    Next: string;
    ResultPath?: string;
}
export interface Execution {
    executionArn: string;
    stateMachineArn: string;
    name: string;
    status: "RUNNING" | "SUCCEEDED" | "FAILED" | "TIMED_OUT" | "ABORTED";
    startDate: number;
    stopDate?: number;
    input: string;
    output?: string;
    error?: string;
    cause?: string;
}
export interface TaskInvoker {
    invoke(resource: string, input: unknown): Promise<unknown>;
}
export declare function runStateMachine(definition: StateMachineDefinition, input: unknown, executionArn: string, invoker?: TaskInvoker): Promise<{
    output: unknown;
    error?: string;
    cause?: string;
}>;
//# sourceMappingURL=engine.d.ts.map