import { randomUUID } from "crypto";
import path from "path";
import type { IProvider } from "../../interfaces/provider.js";

export interface FunctionConfig {
  functionName: string;
  handler: string;
  runtime?: "nodejs20.x" | "nodejs18.x" | "nodejs16.x";
  codeDir?: string;
  environment?: Record<string, string>;
  description?: string;
}

export interface StoredFunction {
  FunctionName: string;
  FunctionArn: string;
  Handler: string;
  Runtime: string;
  CodeSize: number;
  Description: string;
  Environment: { Variables: Record<string, string> };
  LastModified: string;
  State: "Active";
  RevisionId: string;
  codeDir: string | undefined;
}

export interface PolicyStatement {
  Sid: string;
  Effect: string;
  Action: string | string[];
  Principal: unknown;
  Resource: string;
}

export interface FunctionUrlConfig {
  FunctionUrl: string;
  FunctionArn: string;
  AuthType: string;
  Cors: Record<string, unknown>;
  CreationTime: string;
  LastModifiedTime: string;
}

export interface EventSourceMapping {
  UUID: string;
  EventSourceArn: string;
  FunctionName: string;
  FunctionArn: string;
  State: string;
  BatchSize: number;
  LastModified: string;
  StartingPosition?: string;
}

export type InvocationType = "RequestResponse" | "Event" | "DryRun";

const REGION = "us-east-1";
const ACCOUNT = "123456789012";

function functionArn(name: string): string {
  return `arn:aws:lambda:${REGION}:${ACCOUNT}:function:${name}`;
}

async function invokeHandler(codeDir: string, handler: string, payload: string): Promise<string> {
  const [file, fn] = handler.split(".");
  const modulePath = path.resolve(codeDir, (file ?? "index") + ".js");
  const mod = (await import(modulePath)) as Record<string, unknown>;
  const result = await (mod[fn ?? "handler"] as (e: unknown) => Promise<unknown>)(
    JSON.parse(payload || "{}"),
  );
  return JSON.stringify(result ?? null);
}

function makeStored(config: FunctionConfig): StoredFunction {
  return {
    FunctionName: config.functionName,
    FunctionArn: functionArn(config.functionName),
    Handler: config.handler,
    Runtime: config.runtime ?? "nodejs20.x",
    CodeSize: 0,
    Description: config.description ?? "",
    Environment: { Variables: config.environment ?? {} },
    LastModified: new Date().toISOString(),
    State: "Active",
    RevisionId: randomUUID(),
    codeDir: config.codeDir,
  };
}

export class LambdaProvider implements IProvider {
  readonly name = "lambda";

  private _functions = new Map<string, StoredFunction>();
  private _preconfiguredNames: ReadonlySet<string>;
  private _tags = new Map<string, Record<string, string>>();
  private _policy = new Map<string, PolicyStatement[]>();
  private _urlConfigs = new Map<string, FunctionUrlConfig>();
  private _eventSourceMappings = new Map<string, EventSourceMapping>();

  constructor(configs: FunctionConfig[] = []) {
    this._preconfiguredNames = new Set(configs.map((c) => c.functionName));
    for (const config of configs) {
      this._functions.set(config.functionName, makeStored(config));
    }
  }

  async start(): Promise<void> {}
  async stop(): Promise<void> {
    this._functions.clear();
    this._tags.clear();
    this._policy.clear();
    this._urlConfigs.clear();
    this._eventSourceMappings.clear();
  }
  async healthCheck(): Promise<boolean> { return true; }

  async reset(): Promise<void> {
    for (const name of [...this._functions.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._functions.delete(name);
        this._tags.delete(name);
        this._policy.delete(name);
        this._urlConfigs.delete(name);
      }
    }
    this._eventSourceMappings.clear();
  }

  private _nameFromArn(nameOrArn: string): string {
    if (!nameOrArn.startsWith("arn:")) return nameOrArn;
    const parts = nameOrArn.split(":");
    return parts[parts.length - 1] ?? nameOrArn;
  }

  createFunction(config: FunctionConfig): StoredFunction {
    if (this._functions.has(config.functionName)) {
      throw new Error("ResourceConflictException: Function already exists.");
    }
    const fn = makeStored(config);
    this._functions.set(config.functionName, fn);
    return fn;
  }

  deleteFunction(name: string): void {
    if (!this._functions.has(name)) {
      throw new Error("ResourceNotFoundException: Function not found.");
    }
    this._functions.delete(name);
  }

  listFunctions(): { Functions: StoredFunction[] } {
    return { Functions: [...this._functions.values()].map((f) => this._publicView(f)) };
  }

  getFunction(name: string): { Configuration: StoredFunction } {
    const fn = this._functions.get(name);
    if (!fn) throw new Error("ResourceNotFoundException: Function not found.");
    return { Configuration: this._publicView(fn) };
  }

  getFunctionConfiguration(name: string): StoredFunction {
    const fn = this._functions.get(name);
    if (!fn) throw new Error("ResourceNotFoundException: Function not found.");
    return this._publicView(fn);
  }

  updateFunctionCode(name: string, codeDir?: string): StoredFunction {
    const fn = this._functions.get(name);
    if (!fn) throw new Error("ResourceNotFoundException: Function not found.");
    fn.codeDir = codeDir;
    fn.RevisionId = randomUUID();
    fn.LastModified = new Date().toISOString();
    return this._publicView(fn);
  }

  updateFunctionConfiguration(
    name: string,
    updates: Partial<Pick<FunctionConfig, "handler" | "runtime" | "environment" | "description">>,
  ): StoredFunction {
    const fn = this._functions.get(name);
    if (!fn) throw new Error("ResourceNotFoundException: Function not found.");
    if (updates.handler !== undefined) fn.Handler = updates.handler;
    if (updates.runtime !== undefined) fn.Runtime = updates.runtime;
    if (updates.environment !== undefined) fn.Environment = { Variables: updates.environment };
    if (updates.description !== undefined) fn.Description = updates.description;
    fn.RevisionId = randomUUID();
    fn.LastModified = new Date().toISOString();
    return this._publicView(fn);
  }

  async invoke(
    name: string,
    payload?: string,
    invocationType: InvocationType = "RequestResponse",
  ): Promise<{ StatusCode: number; Payload: string }> {
    const fn = this._functions.get(name);
    if (!fn) throw new Error("ResourceNotFoundException: Function not found.");
    if (invocationType === "DryRun") return { StatusCode: 204, Payload: "" };
    if (invocationType === "Event") {
      if (fn.codeDir) {
        invokeHandler(fn.codeDir, fn.Handler, payload ?? "{}").catch(() => {});
      }
      return { StatusCode: 202, Payload: "" };
    }
    if (fn.codeDir) {
      const result = await invokeHandler(fn.codeDir, fn.Handler, payload ?? "{}");
      return { StatusCode: 200, Payload: result };
    }
    const mock = JSON.stringify({ statusCode: 200, body: '{"message":"ok"}' });
    return { StatusCode: 200, Payload: mock };
  }

  // --- Tagging ---

  tagFunction(nameOrArn: string, tags: Record<string, string>): void {
    const name = this._nameFromArn(nameOrArn);
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const existing = this._tags.get(name) ?? {};
    this._tags.set(name, { ...existing, ...tags });
  }

  untagFunction(nameOrArn: string, tagKeys: string[]): void {
    const name = this._nameFromArn(nameOrArn);
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const existing = this._tags.get(name) ?? {};
    for (const k of tagKeys) delete existing[k];
    this._tags.set(name, existing);
  }

  listFunctionTags(nameOrArn: string): Record<string, string> {
    const name = this._nameFromArn(nameOrArn);
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    return { ...(this._tags.get(name) ?? {}) };
  }

  // --- Permissions ---

  addPermission(name: string, stmt: PolicyStatement): { Statement: string } {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const stmts = this._policy.get(name) ?? [];
    stmts.push(stmt);
    this._policy.set(name, stmts);
    return { Statement: JSON.stringify(stmt) };
  }

  removePermission(name: string, sid: string): void {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const stmts = (this._policy.get(name) ?? []).filter((s) => s.Sid !== sid);
    this._policy.set(name, stmts);
  }

  getPolicy(name: string): { Policy: string; RevisionId: string } | null {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const stmts = this._policy.get(name) ?? [];
    if (stmts.length === 0) return null;
    return { Policy: JSON.stringify({ Version: "2012-10-17", Statement: stmts }), RevisionId: "1" };
  }

  // --- Event Source Mappings ---

  createEventSourceMapping(params: {
    EventSourceArn: string;
    FunctionName: string;
    BatchSize?: number;
    StartingPosition?: string;
  }): EventSourceMapping {
    const uuid = randomUUID();
    const fn = this._functions.get(params.FunctionName);
    const mapping: EventSourceMapping = {
      UUID: uuid,
      EventSourceArn: params.EventSourceArn,
      FunctionName: params.FunctionName,
      FunctionArn: fn ? fn.FunctionArn : functionArn(params.FunctionName),
      State: "Enabled",
      BatchSize: params.BatchSize ?? 100,
      LastModified: new Date().toISOString(),
      ...(params.StartingPosition !== undefined && { StartingPosition: params.StartingPosition }),
    };
    this._eventSourceMappings.set(uuid, mapping);
    return mapping;
  }

  getEventSourceMapping(uuid: string): EventSourceMapping {
    const m = this._eventSourceMappings.get(uuid);
    if (!m) throw new Error("ResourceNotFoundException: Event source mapping not found.");
    return m;
  }

  updateEventSourceMapping(uuid: string, updates: { BatchSize?: number }): EventSourceMapping {
    const m = this._eventSourceMappings.get(uuid);
    if (!m) throw new Error("ResourceNotFoundException: Event source mapping not found.");
    if (updates.BatchSize !== undefined) m.BatchSize = updates.BatchSize;
    m.LastModified = new Date().toISOString();
    return m;
  }

  deleteEventSourceMapping(uuid: string): EventSourceMapping {
    const m = this._eventSourceMappings.get(uuid);
    if (!m) throw new Error("ResourceNotFoundException: Event source mapping not found.");
    this._eventSourceMappings.delete(uuid);
    return { ...m, State: "Deleting" };
  }

  listEventSourceMappings(): { EventSourceMappings: EventSourceMapping[] } {
    return { EventSourceMappings: [...this._eventSourceMappings.values()] };
  }

  // --- Function URLs ---

  createFunctionUrlConfig(name: string, authType: string, cors?: Record<string, unknown>): FunctionUrlConfig {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    if (this._urlConfigs.has(name)) throw new Error("ResourceConflictException: Function URL already exists.");
    const fn = this._functions.get(name)!;
    const config: FunctionUrlConfig = {
      FunctionUrl: `http://localhost/${name}`,
      FunctionArn: fn.FunctionArn,
      AuthType: authType,
      Cors: cors ?? {},
      CreationTime: new Date().toISOString(),
      LastModifiedTime: new Date().toISOString(),
    };
    this._urlConfigs.set(name, config);
    return config;
  }

  getFunctionUrlConfig(name: string): FunctionUrlConfig | undefined {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    return this._urlConfigs.get(name);
  }

  updateFunctionUrlConfig(name: string, updates: { AuthType?: string; Cors?: Record<string, unknown> }): FunctionUrlConfig {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    const config = this._urlConfigs.get(name);
    if (!config) throw new Error("ResourceNotFoundException: Function URL config not found.");
    if (updates.AuthType !== undefined) config.AuthType = updates.AuthType;
    if (updates.Cors !== undefined) config.Cors = updates.Cors;
    config.LastModifiedTime = new Date().toISOString();
    return config;
  }

  deleteFunctionUrlConfig(name: string): void {
    if (!this._functions.has(name)) throw new Error("ResourceNotFoundException: Function not found.");
    this._urlConfigs.delete(name);
  }

  private _publicView(fn: StoredFunction): StoredFunction {
    const { codeDir: _codeDir, ...rest } = fn;
    void _codeDir;
    return rest as StoredFunction;
  }
}
