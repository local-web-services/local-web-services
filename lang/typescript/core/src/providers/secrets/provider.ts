import type { IProvider } from "../../interfaces/provider.js";
import { randomUUID } from "crypto";

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "000000000000";

export interface SecretConfig {
  name: string;
  secretString?: string;
}

export interface SecretRecord {
  ARN: string;
  Name: string;
  SecretString: string;
  VersionId: string;
  CreatedDate: number;
}

export class SecretsProvider implements IProvider {
  readonly name = "secretsmanager";

  private _secrets = new Map<string, SecretRecord>();
  private _preconfiguredNames: ReadonlySet<string>;
  private _running = false;

  constructor(configs: SecretConfig[] = []) {
    this._preconfiguredNames = new Set(configs.map((c) => c.name));
    for (const c of configs) {
      this._secrets.set(c.name, this._makeRecord(c.name, c.secretString ?? ""));
    }
  }

  async start(): Promise<void> {
    this._running = true;
  }

  async stop(): Promise<void> {
    this._secrets.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const name of [...this._secrets.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._secrets.delete(name);
      }
    }
  }

  createSecret(name: string, secretString?: string): SecretRecord {
    if (this._secrets.has(name)) {
      throw new Error(`ResourceExistsException: Secret ${name} already exists`);
    }
    const record = this._makeRecord(name, secretString ?? "");
    this._secrets.set(name, record);
    return record;
  }

  getSecretValue(id: string): SecretRecord {
    const record = this._secrets.get(id);
    if (record === undefined) {
      throw new Error(`ResourceNotFoundException: Secret ${id} not found`);
    }
    return record;
  }

  putSecretValue(id: string, secretString: string): SecretRecord {
    const existing = this._secrets.get(id);
    if (existing === undefined) {
      throw new Error(`ResourceNotFoundException: Secret ${id} not found`);
    }
    const updated: SecretRecord = { ...existing, SecretString: secretString, VersionId: randomUUID() };
    this._secrets.set(id, updated);
    return updated;
  }

  deleteSecret(id: string): SecretRecord {
    const record = this._secrets.get(id);
    if (record === undefined) {
      throw new Error(`ResourceNotFoundException: Secret ${id} not found`);
    }
    this._secrets.delete(id);
    return record;
  }

  listSecrets(): SecretRecord[] {
    return [...this._secrets.values()];
  }

  describeSecret(id: string): SecretRecord {
    const record = this._secrets.get(id);
    if (record === undefined) {
      throw new Error(`ResourceNotFoundException: Secret ${id} not found`);
    }
    return record;
  }

  private _makeRecord(name: string, secretString: string): SecretRecord {
    const suffix = Math.random().toString(36).substring(2, 8).toUpperCase();
    return {
      ARN: `arn:aws:secretsmanager:${FAKE_REGION}:${FAKE_ACCOUNT}:secret:${name}-${suffix}`,
      Name: name,
      SecretString: secretString,
      VersionId: randomUUID(),
      CreatedDate: Date.now() / 1000,
    };
  }
}
