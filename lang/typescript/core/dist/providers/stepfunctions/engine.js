"use strict";
/** Step Functions ASL interpreter. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.runStateMachine = runStateMachine;
const uuid_1 = require("uuid");
class StatesError extends Error {
    constructor(errorCode, cause) {
        super(errorCode);
        this.errorCode = errorCode;
        this.cause = cause;
    }
}
// ─── Path utilities ──────────────────────────────────────────────────────────
function resolvePath(data, path) {
    if (!path || path === "$")
        return data;
    if (!path.startsWith("$."))
        return data;
    const keys = path.slice(2).split(".");
    let cur = data;
    for (const key of keys) {
        if (cur === null || cur === undefined || typeof cur !== "object")
            return undefined;
        cur = cur[key];
    }
    return cur;
}
function setPath(data, path, value) {
    if (!path || path === "$")
        return value;
    if (!path.startsWith("$."))
        return data;
    const keys = path.slice(2).split(".");
    const result = typeof data === "object" && data !== null ? { ...data } : {};
    let cur = result;
    for (let i = 0; i < keys.length - 1; i++) {
        const key = keys[i];
        if (typeof cur[key] !== "object" || cur[key] === null)
            cur[key] = {};
        cur[key] = { ...cur[key] };
        cur = cur[key];
    }
    cur[keys[keys.length - 1]] = value;
    return result;
}
function applyInputPath(data, inputPath) {
    if (inputPath === null)
        return {};
    return resolvePath(data, inputPath ?? "$");
}
function applyResultPath(input, result, resultPath) {
    if (resultPath === null)
        return input;
    if (!resultPath || resultPath === "$")
        return result;
    return setPath(input, resultPath, result);
}
function applyOutputPath(data, outputPath) {
    if (outputPath === null)
        return {};
    return resolvePath(data, outputPath ?? "$");
}
function applyParameters(params, data) {
    if (!params)
        return data;
    const result = {};
    for (const [key, val] of Object.entries(params)) {
        if (key.endsWith(".$")) {
            const realKey = key.slice(0, -2);
            result[realKey] = resolvePath(data, val);
        }
        else {
            result[key] = val;
        }
    }
    return result;
}
// ─── Choice evaluator ─────────────────────────────────────────────────────────
function evaluateChoice(rule, data) {
    if (rule.And)
        return rule.And.every((r) => evaluateChoice(r, data));
    if (rule.Or)
        return rule.Or.some((r) => evaluateChoice(r, data));
    if (rule.Not)
        return !evaluateChoice(rule.Not, data);
    const variable = rule.Variable ? resolvePath(data, rule.Variable) : undefined;
    if (rule.StringEquals !== undefined)
        return variable === rule.StringEquals;
    if (rule.StringLessThan !== undefined)
        return String(variable) < rule.StringLessThan;
    if (rule.StringGreaterThan !== undefined)
        return String(variable) > rule.StringGreaterThan;
    if (rule.StringLessThanOrEquals !== undefined)
        return String(variable) <= rule.StringLessThanOrEquals;
    if (rule.StringGreaterThanOrEquals !== undefined)
        return String(variable) >= rule.StringGreaterThanOrEquals;
    if (rule.StringMatches !== undefined) {
        const pattern = rule.StringMatches.replace(/[.+^${}()|[\]\\]/g, "\\$&").replace(/\*/g, ".*");
        return new RegExp(`^${pattern}$`).test(String(variable));
    }
    if (rule.NumericEquals !== undefined)
        return Number(variable) === rule.NumericEquals;
    if (rule.NumericLessThan !== undefined)
        return Number(variable) < rule.NumericLessThan;
    if (rule.NumericGreaterThan !== undefined)
        return Number(variable) > rule.NumericGreaterThan;
    if (rule.NumericLessThanOrEquals !== undefined)
        return Number(variable) <= rule.NumericLessThanOrEquals;
    if (rule.NumericGreaterThanOrEquals !== undefined)
        return Number(variable) >= rule.NumericGreaterThanOrEquals;
    if (rule.BooleanEquals !== undefined)
        return Boolean(variable) === rule.BooleanEquals;
    if (rule.IsNull !== undefined)
        return (variable === null) === rule.IsNull;
    if (rule.IsPresent !== undefined)
        return (variable !== undefined) === rule.IsPresent;
    if (rule.IsString !== undefined)
        return (typeof variable === "string") === rule.IsString;
    if (rule.IsNumeric !== undefined)
        return (typeof variable === "number") === rule.IsNumeric;
    if (rule.IsBoolean !== undefined)
        return (typeof variable === "boolean") === rule.IsBoolean;
    return false;
}
// Default task invoker: no-op (returns input)
const defaultInvoker = {
    async invoke(_resource, input) {
        return input;
    },
};
// ─── Execution engine ─────────────────────────────────────────────────────────
async function runStateMachine(definition, input, executionArn, invoker = defaultInvoker) {
    let currentStateName = definition.StartAt;
    let currentData = input;
    while (currentStateName) {
        const state = definition.States[currentStateName];
        if (!state)
            throw new StatesError("States.Runtime", `State not found: ${currentStateName}`);
        try {
            const result = await executeState(state, currentData, definition, invoker);
            if (result.terminal) {
                if (result.error) {
                    return { output: input, error: result.error, cause: result.cause };
                }
                return { output: result.output };
            }
            currentData = result.output;
            currentStateName = result.next;
        }
        catch (err) {
            if (err instanceof StatesError) {
                return { output: input, error: err.errorCode, cause: err.cause };
            }
            return { output: input, error: "States.Runtime", cause: String(err) };
        }
    }
    return { output: currentData };
}
async function executeState(state, data, definition, invoker) {
    switch (state.Type) {
        case "Pass": return executePass(state, data);
        case "Task": return executeTask(state, data, invoker);
        case "Choice": return executeChoice(state, data);
        case "Wait": return executeWait(state, data);
        case "Succeed": return executeSucceed(state, data);
        case "Fail": return executeFail(state);
        case "Parallel": return executeParallel(state, data, invoker);
        case "Map": return executeMap(state, data, invoker);
        default: throw new StatesError("States.Runtime", `Unknown state type: ${state.Type}`);
    }
}
function executePass(state, data) {
    const effectiveInput = applyInputPath(data, state.InputPath);
    const params = applyParameters(state.Parameters, effectiveInput);
    const result = state.Result ?? params;
    const combined = applyResultPath(effectiveInput, result, state.ResultPath);
    const output = applyOutputPath(combined, state.OutputPath);
    if (state.End)
        return { output, terminal: true };
    return { output, next: state.Next, terminal: false };
}
async function executeTask(state, data, invoker) {
    const effectiveInput = applyInputPath(data, state.InputPath);
    const params = applyParameters(state.Parameters, effectiveInput);
    let result;
    try {
        result = await invoker.invoke(state.Resource, params ?? effectiveInput);
    }
    catch (err) {
        throw new StatesError("States.TaskFailed", String(err));
    }
    const combined = applyResultPath(effectiveInput, result, state.ResultPath);
    const output = applyOutputPath(combined, state.OutputPath);
    if (state.End)
        return { output, terminal: true };
    return { output, next: state.Next, terminal: false };
}
function executeChoice(state, data) {
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
async function executeWait(state, data) {
    let waitMs = 0;
    if (state.Seconds)
        waitMs = Math.min(state.Seconds * 1000, 5000); // cap at 5s for local
    if (state.SecondsPath) {
        const secs = resolvePath(data, state.SecondsPath);
        waitMs = Math.min(Number(secs) * 1000, 5000);
    }
    if (waitMs > 0)
        await new Promise((r) => setTimeout(r, waitMs));
    const effectiveInput = applyInputPath(data, state.InputPath);
    const output = applyOutputPath(effectiveInput, state.OutputPath);
    if (state.End)
        return { output, terminal: true };
    return { output, next: state.Next, terminal: false };
}
function executeSucceed(state, data) {
    const effectiveInput = applyInputPath(data, state.InputPath);
    const output = applyOutputPath(effectiveInput, state.OutputPath);
    return { output, terminal: true };
}
function executeFail(state) {
    return {
        output: null,
        terminal: true,
        error: state.Error ?? "States.Failed",
        cause: state.Cause,
    };
}
async function executeParallel(state, data, invoker) {
    const effectiveInput = applyInputPath(data, state.InputPath);
    const results = await Promise.all(state.Branches.map((branch) => runStateMachine({ StartAt: branch.StartAt, States: branch.States }, effectiveInput, (0, uuid_1.v4)(), invoker)));
    const outputs = results.map((r) => r.output);
    const combined = applyResultPath(effectiveInput, outputs, state.ResultPath);
    const output = applyOutputPath(combined, state.OutputPath);
    if (state.End)
        return { output, terminal: true };
    return { output, next: state.Next, terminal: false };
}
async function executeMap(state, data, invoker) {
    const effectiveInput = applyInputPath(data, state.InputPath);
    const items = state.ItemsPath ? resolvePath(effectiveInput, state.ItemsPath) : effectiveInput;
    const itemArray = Array.isArray(items) ? items : [];
    const results = await Promise.all(itemArray.map((item) => runStateMachine({ StartAt: state.Iterator.StartAt, States: state.Iterator.States }, item, (0, uuid_1.v4)(), invoker)));
    const outputs = results.map((r) => r.output);
    const combined = applyResultPath(effectiveInput, outputs, state.ResultPath);
    const output = applyOutputPath(combined, state.OutputPath);
    if (state.End)
        return { output, terminal: true };
    return { output, next: state.Next, terminal: false };
}
//# sourceMappingURL=engine.js.map