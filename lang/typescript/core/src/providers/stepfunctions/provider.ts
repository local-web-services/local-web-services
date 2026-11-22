import type { IProvider } from "../../interfaces/provider.js";

export interface StateMachineConfig {
  name: string;
  definition: string;
  roleArn?: string;
}

type ExecutionStatus = "RUNNING" | "SUCCEEDED" | "FAILED" | "TIMED_OUT" | "ABORTED";
type MachineType = "STANDARD" | "EXPRESS";

interface HistoryEvent {
  id: number;
  type: "ExecutionStarted" | "ExecutionSucceeded" | "ExecutionFailed" | "ExecutionAborted";
  timestamp: number;
  executionStartedEventDetails?: { input: string; roleArn: string };
  executionSucceededEventDetails?: { output: string };
}

interface StoredMachine {
  name: string;
  arn: string;
  definition: string;
  roleArn: string;
  status: "ACTIVE";
  createdAt: number;
  type: MachineType;
}

interface StoredExecution {
  name: string;
  arn: string;
  machineArn: string;
  status: ExecutionStatus;
  input: string;
  output?: string;
  startDate: number;
  stopDate?: number;
  events: HistoryEvent[];
}

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "123456789012";
const DEFAULT_ROLE = `arn:aws:iam::${FAKE_ACCOUNT}:role/StepFunctionsRole`;

function machineArn(name: string): string {
  return `arn:aws:states:${FAKE_REGION}:${FAKE_ACCOUNT}:stateMachine:${name}`;
}

function executionArn(machineName: string, executionName: string): string {
  return `arn:aws:states:${FAKE_REGION}:${FAKE_ACCOUNT}:execution:${machineName}:${executionName}`;
}

function machineName(arn: string): string {
  return arn.split(":").pop() ?? arn;
}

export class StepFunctionsProvider implements IProvider {
  readonly name = "states";

  private _machines = new Map<string, StoredMachine>();
  private _executions = new Map<string, StoredExecution>();
  private _tags = new Map<string, Map<string, string>>();
  private _preconfiguredMachineArns: ReadonlySet<string>;
  private _running = false;

  constructor(configs: StateMachineConfig[] = []) {
    this._preconfiguredMachineArns = new Set(configs.map((c) => machineArn(c.name)));
    for (const config of configs) {
      this._seedMachine(config);
    }
  }

  async start(): Promise<void> {
    this._running = true;
  }

  async stop(): Promise<void> {
    this._machines.clear();
    this._executions.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const arn of [...this._machines.keys()]) {
      if (!this._preconfiguredMachineArns.has(arn)) {
        this._machines.delete(arn);
      }
    }
    this._executions.clear();
  }

  createStateMachine(
    name: string,
    definition: string,
    type: MachineType = "STANDARD",
    roleArn: string = DEFAULT_ROLE,
  ): { stateMachineArn: string; creationDate: number } {
    const arn = machineArn(name);
    if (this._machines.has(arn)) {
      throw new Error(`StateMachineAlreadyExists: State machine '${name}' already exists`);
    }
    const createdAt = Date.now() / 1000;
    this._machines.set(arn, {
      name,
      arn,
      definition,
      roleArn,
      status: "ACTIVE",
      createdAt,
      type,
    });
    return { stateMachineArn: arn, creationDate: createdAt };
  }

  deleteStateMachine(arn: string): void {
    if (!this._machines.has(arn)) {
      throw new Error(`StateMachineDoesNotExist: State machine '${arn}' not found`);
    }
    this._machines.delete(arn);
  }

  listStateMachines(): {
    stateMachines: { name: string; stateMachineArn: string; creationDate: number; type: string }[];
  } {
    const machines = [...this._machines.values()].map((m) => ({
      name: m.name,
      stateMachineArn: m.arn,
      creationDate: m.createdAt,
      type: m.type,
    }));
    return { stateMachines: machines };
  }

  describeStateMachine(arn: string): object {
    const machine = this._machines.get(arn);
    if (machine === undefined) {
      throw new Error(`StateMachineDoesNotExist: State machine '${arn}' not found`);
    }
    return {
      stateMachineArn: machine.arn,
      name: machine.name,
      status: machine.status,
      definition: machine.definition,
      roleArn: machine.roleArn,
      type: machine.type,
      creationDate: machine.createdAt,
    };
  }

  startExecution(
    stateMachineArn: string,
    name?: string,
    input: string = "{}",
  ): { executionArn: string; startDate: number } {
    const machine = this._machines.get(stateMachineArn);
    if (machine === undefined) {
      throw new Error(`StateMachineDoesNotExist: State machine '${stateMachineArn}' not found`);
    }
    const execName = name ?? `exec-${Date.now()}`;
    const arn = executionArn(machine.name, execName);
    if (this._executions.has(arn)) {
      throw new Error(`ExecutionAlreadyExists: Execution '${execName}' already exists`);
    }
    const startDate = Date.now() / 1000;
    const stopDate = Date.now() / 1000;
    const events: HistoryEvent[] = [
      {
        id: 1,
        type: "ExecutionStarted",
        timestamp: startDate,
        executionStartedEventDetails: { input, roleArn: machine.roleArn },
      },
      {
        id: 2,
        type: "ExecutionSucceeded",
        timestamp: stopDate,
        executionSucceededEventDetails: { output: input },
      },
    ];
    this._executions.set(arn, {
      name: execName,
      arn,
      machineArn: stateMachineArn,
      status: "SUCCEEDED",
      input,
      output: input,
      startDate,
      stopDate,
      events,
    });
    return { executionArn: arn, startDate };
  }

  stopExecution(
    execArn: string,
    _cause?: string,
    _error?: string,
  ): { stopDate: number } {
    const exec = this._executions.get(execArn);
    if (exec === undefined) {
      throw new Error(`ExecutionDoesNotExist: Execution '${execArn}' not found`);
    }
    const stopDate = Date.now() / 1000;
    this._executions.set(execArn, { ...exec, status: "ABORTED", stopDate });
    return { stopDate };
  }

  describeExecution(execArn: string): object {
    const exec = this._executions.get(execArn);
    if (exec === undefined) {
      throw new Error(`ExecutionDoesNotExist: Execution '${execArn}' not found`);
    }
    return {
      executionArn: exec.arn,
      stateMachineArn: exec.machineArn,
      name: exec.name,
      status: exec.status,
      startDate: exec.startDate,
      ...(exec.stopDate !== undefined && { stopDate: exec.stopDate }),
      input: exec.input,
      ...(exec.output !== undefined && { output: exec.output }),
    };
  }

  listExecutions(
    stateMachineArn: string,
    statusFilter?: string,
  ): { executions: object[] } {
    const execs = [...this._executions.values()]
      .filter((e) => e.machineArn === stateMachineArn)
      .filter((e) => statusFilter === undefined || e.status === statusFilter)
      .map((e) => ({
        executionArn: e.arn,
        stateMachineArn: e.machineArn,
        name: e.name,
        status: e.status,
        startDate: e.startDate,
        ...(e.stopDate !== undefined && { stopDate: e.stopDate }),
      }));
    return { executions: execs };
  }

  getExecutionHistory(execArn: string): { events: HistoryEvent[] } {
    const exec = this._executions.get(execArn);
    if (exec === undefined) {
      throw new Error(`ExecutionDoesNotExist: Execution '${execArn}' not found`);
    }
    return { events: exec.events };
  }

  updateStateMachine(arn: string, definition?: string, roleArn?: string): { updateDate: number } {
    const machine = this._machines.get(arn);
    if (machine === undefined) throw new Error(`StateMachineDoesNotExist: State machine '${arn}' not found`);
    this._machines.set(arn, {
      ...machine,
      ...(definition !== undefined && { definition }),
      ...(roleArn !== undefined && { roleArn }),
    });
    return { updateDate: Date.now() / 1000 };
  }

  startSyncExecution(
    stateMachineArn: string,
    name?: string,
    input: string = "{}",
  ): object {
    const machine = this._machines.get(stateMachineArn);
    if (machine === undefined) throw new Error(`StateMachineDoesNotExist: State machine '${stateMachineArn}' not found`);
    const execName = name ?? `sync-${Date.now()}`;
    const arn = executionArn(machine.name, execName);
    const startDate = Date.now() / 1000;
    const stopDate = Date.now() / 1000;
    return { executionArn: arn, name: execName, startDate, stopDate, status: "SUCCEEDED", input, output: input };
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

  private _seedMachine(config: StateMachineConfig): void {
    const arn = machineArn(config.name);
    this._machines.set(arn, {
      name: config.name,
      arn,
      definition: config.definition,
      roleArn: config.roleArn ?? DEFAULT_ROLE,
      status: "ACTIVE",
      createdAt: Date.now() / 1000,
      type: "STANDARD",
    });
  }
}

export { machineName };
