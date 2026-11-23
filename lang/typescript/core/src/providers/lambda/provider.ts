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

  constructor(configs: FunctionConfig[] = []) {
    this._preconfiguredNames = new Set(configs.map((c) => c.functionName));
    for (const config of configs) {
      this._functions.set(config.functionName, makeStored(config));
    }
  }

  async start(): Promise<void> {}
  async stop(): Promise<void> { this._functions.clear(); }
  async healthCheck(): Promise<boolean> { return true; }

  async reset(): Promise<void> {
    for (const name of [...this._functions.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._functions.delete(name);
      }
    }
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

  private _publicView(fn: StoredFunction): StoredFunction {
    const { codeDir: _codeDir, ...rest } = fn;
    void _codeDir;
    return rest as StoredFunction;
  }
}
