/** Step Functions ASL interpreter. */

import { v4 as uuidv4 } from "uuid";

export interface StateMachineDefinition {
  Comment?: string;
  StartAt: string;
  States: Record<string, AslState>;
  TimeoutSeconds?: number;
}

export type AslState =
  | PassState
  | TaskState
  | ChoiceState
  | WaitState
  | SucceedState
  | FailState
  | ParallelState
  | MapState;

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
  Branches: Array<{ StartAt: string; States: Record<string, AslState> }>;
}

export interface MapState extends BaseState {
  Type: "Map";
  ItemsPath?: string;
  Iterator: { StartAt: string; States: Record<string, AslState> };
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

class StatesError extends Error {
  constructor(
    public readonly errorCode: string,
    public readonly cause?: string,
  ) {
    super(errorCode);
  }
}

// ─── Path utilities ──────────────────────────────────────────────────────────

function resolvePath(data: unknown, path: string | undefined): unknown {
  if (!path || path === "$") return data;
  if (!path.startsWith("$.")) return data;
  const keys = path.slice(2).split(".");
  let cur = data as Record<string, unknown>;
  for (const key of keys) {
    if (cur === null || cur === undefined || typeof cur !== "object") return undefined;
    cur = (cur as Record<string, unknown>)[key] as Record<string, unknown>;
  }
  return cur;
}

function setPath(data: unknown, path: string | undefined, value: unknown): unknown {
  if (!path || path === "$") return value;
  if (!path.startsWith("$.")) return data;
  const keys = path.slice(2).split(".");
  const result =
    typeof data === "object" && data !== null ? { ...(data as Record<string, unknown>) } : {};
  let cur: Record<string, unknown> = result;
  for (let i = 0; i < keys.length - 1; i++) {
    const key = keys[i];
    if (typeof cur[key] !== "object" || cur[key] === null) cur[key] = {};
    cur[key] = { ...(cur[key] as Record<string, unknown>) };
    cur = cur[key] as Record<string, unknown>;
  }
  cur[keys[keys.length - 1]] = value;
  return result;
}

function applyInputPath(data: unknown, inputPath: string | undefined): unknown {
  if (inputPath === null) return {};
  return resolvePath(data, inputPath ?? "$");
}

function applyResultPath(input: unknown, result: unknown, resultPath: string | undefined): unknown {
  if (resultPath === null) return input;
  if (!resultPath || resultPath === "$") return result;
  return setPath(input, resultPath, result);
}

function applyOutputPath(data: unknown, outputPath: string | undefined): unknown {
  if (outputPath === null) return {};
  return resolvePath(data, outputPath ?? "$");
}

function applyParameters(params: Record<string, unknown> | undefined, data: unknown): unknown {
  if (!params) return data;
  const result: Record<string, unknown> = {};
  for (const [key, val] of Object.entries(params)) {
    if (key.endsWith(".$")) {
      const realKey = key.slice(0, -2);
      result[realKey] = resolvePath(data, val as string);
    } else {
      result[key] = val;
    }
  }
  return result;
}

// ─── Choice evaluator ─────────────────────────────────────────────────────────

function evaluateChoice(rule: ChoiceRule, data: unknown): boolean {
  if (rule.And) return rule.And.every((r) => evaluateChoice(r, data));
  if (rule.Or) return rule.Or.some((r) => evaluateChoice(r, data));
  if (rule.Not) return !evaluateChoice(rule.Not, data);

  const variable = rule.Variable ? resolvePath(data, rule.Variable) : undefined;

  if (rule.StringEquals !== undefined) return variable === rule.StringEquals;
  if (rule.StringLessThan !== undefined) return String(variable) < rule.StringLessThan;
  if (rule.StringGreaterThan !== undefined) return String(variable) > rule.StringGreaterThan;
  if (rule.StringLessThanOrEquals !== undefined)
    return String(variable) <= rule.StringLessThanOrEquals;
  if (rule.StringGreaterThanOrEquals !== undefined)
    return String(variable) >= rule.StringGreaterThanOrEquals;
  if (rule.StringMatches !== undefined) {
    const pattern = rule.StringMatches.replace(/[.+^${}()|[\]\\]/g, "\\$&").replace(/\*/g, ".*");
    return new RegExp(`^${pattern}$`).test(String(variable));
  }
  if (rule.NumericEquals !== undefined) return Number(variable) === rule.NumericEquals;
  if (rule.NumericLessThan !== undefined) return Number(variable) < rule.NumericLessThan;
  if (rule.NumericGreaterThan !== undefined) return Number(variable) > rule.NumericGreaterThan;
  if (rule.NumericLessThanOrEquals !== undefined)
    return Number(variable) <= rule.NumericLessThanOrEquals;
  if (rule.NumericGreaterThanOrEquals !== undefined)
    return Number(variable) >= rule.NumericGreaterThanOrEquals;
  if (rule.BooleanEquals !== undefined) return Boolean(variable) === rule.BooleanEquals;
  if (rule.IsNull !== undefined) return (variable === null) === rule.IsNull;
  if (rule.IsPresent !== undefined) return (variable !== undefined) === rule.IsPresent;
  if (rule.IsString !== undefined) return (typeof variable === "string") === rule.IsString;
  if (rule.IsNumeric !== undefined) return (typeof variable === "number") === rule.IsNumeric;
  if (rule.IsBoolean !== undefined) return (typeof variable === "boolean") === rule.IsBoolean;

  return false;
}

// ─── Task invoker ─────────────────────────────────────────────────────────────

export interface TaskInvoker {
  invoke(resource: string, input: unknown): Promise<unknown>;
}

// Default task invoker: no-op (returns input)
const defaultInvoker: TaskInvoker = {
  async invoke(_resource: string, input: unknown): Promise<unknown> {
    return input;
  },
};

// ─── Execution engine ─────────────────────────────────────────────────────────

export async function runStateMachine(
  definition: StateMachineDefinition,
  input: unknown,
  executionArn: string,
  invoker: TaskInvoker = defaultInvoker,
): Promise<{ output: unknown; error?: string; cause?: string }> {
  let currentStateName = definition.StartAt;
  let currentData = input;

  while (currentStateName) {
    const state = definition.States[currentStateName];
    if (!state) throw new StatesError("States.Runtime", `State not found: ${currentStateName}`);

    try {
      const result = await executeState(state, currentData, definition, invoker);
      if (result.terminal) {
        if (result.error) {
          return { output: input, error: result.error, cause: result.cause };
        }
        return { output: result.output };
      }
      currentData = result.output;
      currentStateName = result.next!;
    } catch (err) {
      if (err instanceof StatesError) {
        return { output: input, error: err.errorCode, cause: err.cause };
      }
      return { output: input, error: "States.Runtime", cause: String(err) };
    }
  }

  return { output: currentData };
}

interface StateResult {
  output: unknown;
  next?: string;
  terminal: boolean;
  error?: string;
  cause?: string;
}

async function executeState(
  state: AslState,
  data: unknown,
  definition: StateMachineDefinition,
  invoker: TaskInvoker,
): Promise<StateResult> {
  switch (state.Type) {
    case "Pass":
      return executePass(state as PassState, data);
    case "Task":
      return executeTask(state as TaskState, data, invoker);
    case "Choice":
      return executeChoice(state as ChoiceState, data);
    case "Wait":
      return executeWait(state as WaitState, data);
    case "Succeed":
      return executeSucceed(state as SucceedState, data);
    case "Fail":
      return executeFail(state as FailState);
    case "Parallel":
      return executeParallel(state as ParallelState, data, invoker);
    case "Map":
      return executeMap(state as MapState, data, invoker);
    default:
      throw new StatesError("States.Runtime", `Unknown state type: ${(state as AslState).Type}`);
  }
}

function executePass(state: PassState, data: unknown): StateResult {
  const effectiveInput = applyInputPath(data, state.InputPath);
  const params = applyParameters(state.Parameters, effectiveInput);
  const result = state.Result ?? params;
  const combined = applyResultPath(effectiveInput, result, state.ResultPath);
  const output = applyOutputPath(combined, state.OutputPath);

  if (state.End) return { output, terminal: true };
  return { output, next: state.Next!, terminal: false };
}

async function executeTask(
  state: TaskState,
  data: unknown,
  invoker: TaskInvoker,
): Promise<StateResult> {
  const effectiveInput = applyInputPath(data, state.InputPath);
  const params = applyParameters(state.Parameters, effectiveInput);

  let result: unknown;
  try {
    result = await invoker.invoke(state.Resource, params ?? effectiveInput);
  } catch (err) {
    throw new StatesError("States.TaskFailed", String(err));
  }

  const combined = applyResultPath(effectiveInput, result, state.ResultPath);
  const output = applyOutputPath(combined, state.OutputPath);

  if (state.End) return { output, terminal: true };
  return { output, next: state.Next!, terminal: false };
}

function executeChoice(state: ChoiceState, data: unknown): StateResult {
  const effectiveInput = applyInputPath(data, state.InputPath);

  for (const rule of state.Choices) {
    if (evaluateChoice(rule, effectiveInput)) {
      const output = applyOutputPath(effectiveInput, state.OutputPath);
      return { output, next: rule.Next, terminal: false };
    }
  }

  if (state.Default) {
    const output = applyOutputPath(effectiveInput, state.OutputPath);
    return { output, next: state.Default, terminal: false };
  }

  throw new StatesError("States.NoChoiceMatched", "No choice rule matched and no default");
}

async function executeWait(state: WaitState, data: unknown): Promise<StateResult> {
  let waitMs = 0;
  if (state.Seconds) waitMs = Math.min(state.Seconds * 1000, 5000); // cap at 5s for local
  if (state.SecondsPath) {
    const secs = resolvePath(data, state.SecondsPath);
    waitMs = Math.min(Number(secs) * 1000, 5000);
  }
  if (waitMs > 0) await new Promise((r) => setTimeout(r, waitMs));

  const effectiveInput = applyInputPath(data, state.InputPath);
  const output = applyOutputPath(effectiveInput, state.OutputPath);

  if (state.End) return { output, terminal: true };
  return { output, next: state.Next!, terminal: false };
}

function executeSucceed(state: SucceedState, data: unknown): StateResult {
  const effectiveInput = applyInputPath(data, state.InputPath);
  const output = applyOutputPath(effectiveInput, state.OutputPath);
  return { output, terminal: true };
}

function executeFail(state: FailState): StateResult {
  return {
    output: null,
    terminal: true,
    error: state.Error ?? "States.Failed",
    cause: state.Cause,
  };
}

async function executeParallel(
  state: ParallelState,
  data: unknown,
  invoker: TaskInvoker,
): Promise<StateResult> {
  const effectiveInput = applyInputPath(data, state.InputPath);

  const results = await Promise.all(
    state.Branches.map((branch) =>
      runStateMachine(
        { StartAt: branch.StartAt, States: branch.States },
        effectiveInput,
        uuidv4(),
        invoker,
      ),
    ),
  );

  const outputs = results.map((r) => r.output);
  const combined = applyResultPath(effectiveInput, outputs, state.ResultPath);
  const output = applyOutputPath(combined, state.OutputPath);

  if (state.End) return { output, terminal: true };
  return { output, next: state.Next!, terminal: false };
}

async function executeMap(
  state: MapState,
  data: unknown,
  invoker: TaskInvoker,
): Promise<StateResult> {
  const effectiveInput = applyInputPath(data, state.InputPath);
  const items = state.ItemsPath ? resolvePath(effectiveInput, state.ItemsPath) : effectiveInput;
  const itemArray = Array.isArray(items) ? items : [];

  const results = await Promise.all(
    itemArray.map((item) =>
      runStateMachine(
        { StartAt: state.Iterator.StartAt, States: state.Iterator.States },
        item,
        uuidv4(),
        invoker,
      ),
    ),
  );

  const outputs = results.map((r) => r.output);
  const combined = applyResultPath(effectiveInput, outputs, state.ResultPath);
  const output = applyOutputPath(combined, state.OutputPath);

  if (state.End) return { output, terminal: true };
  return { output, next: state.Next!, terminal: false };
}
