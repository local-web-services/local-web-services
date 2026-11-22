import type { IProvider } from "../../interfaces/provider.js";

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "000000000000";

export interface SsmParameterConfig {
  name: string;
  value: string;
  type?: "String" | "StringList" | "SecureString";
}

export interface ParameterRecord {
  Name: string;
  Value: string;
  Type: string;
  Version: number;
  LastModifiedDate: number;
  ARN: string;
}

export class SsmProvider implements IProvider {
  readonly name = "ssm";

  private _parameters = new Map<string, ParameterRecord>();
  private _preconfiguredNames: ReadonlySet<string>;
  private _running = false;

  constructor(configs: SsmParameterConfig[] = []) {
    this._preconfiguredNames = new Set(configs.map((c) => c.name));
    for (const c of configs) {
      this._parameters.set(c.name, this._makeRecord(c.name, c.value, c.type ?? "String", 1));
    }
  }

  async start(): Promise<void> {
    this._running = true;
  }

  async stop(): Promise<void> {
    this._parameters.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const name of [...this._parameters.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._parameters.delete(name);
      }
    }
  }

  putParameter(name: string, value: string, type: string, overwrite: boolean): number {
    const existing = this._parameters.get(name);
    if (existing !== undefined && !overwrite) {
      throw new Error(`ParameterAlreadyExists: Parameter ${name} already exists`);
    }
    const version = existing !== undefined ? existing.Version + 1 : 1;
    this._parameters.set(name, this._makeRecord(name, value, type, version));
    return version;
  }

  getParameter(name: string): ParameterRecord {
    const param = this._parameters.get(name);
    if (param === undefined) throw new Error(`ParameterNotFound: Parameter ${name} not found`);
    return param;
  }

  getParameters(names: string[]): { Parameters: ParameterRecord[]; InvalidParameters: string[] } {
    const Parameters: ParameterRecord[] = [];
    const InvalidParameters: string[] = [];
    for (const n of names) {
      const p = this._parameters.get(n);
      if (p !== undefined) Parameters.push(p);
      else InvalidParameters.push(n);
    }
    return { Parameters, InvalidParameters };
  }

  getParametersByPath(path: string, recursive: boolean): ParameterRecord[] {
    const results: ParameterRecord[] = [];
    const prefix = path.endsWith("/") ? path : `${path}/`;
    for (const [n, p] of this._parameters) {
      if (!n.startsWith(prefix)) continue;
      const rest = n.slice(prefix.length);
      if (!recursive && rest.includes("/")) continue;
      results.push(p);
    }
    return results;
  }

  deleteParameter(name: string): void {
    if (!this._parameters.has(name)) {
      throw new Error(`ParameterNotFound: Parameter ${name} not found`);
    }
    this._parameters.delete(name);
  }

  describeParameters(): ParameterRecord[] {
    return [...this._parameters.values()];
  }

  private _makeRecord(name: string, value: string, type: string, version: number): ParameterRecord {
    return {
      Name: name,
      Value: value,
      Type: type,
      Version: version,
      LastModifiedDate: Date.now() / 1000,
      ARN: `arn:aws:ssm:${FAKE_REGION}:${FAKE_ACCOUNT}:parameter${name}`,
    };
  }
}
