/**
 * Fluent builder for configuring chaos engineering rules.
 *
 * Mirrors `lws_testing/_builders/chaos.py`.
 */

export interface ChaosConfig {
  enabled: boolean;
  error_rate?: number;
  latency_min_ms?: number;
  latency_max_ms?: number;
  connection_reset_rate?: number;
  timeout_rate?: number;
}

export class ChaosBuilder {
  private readonly _service: string;
  private readonly _mgmtPort: number;
  private readonly _config: ChaosConfig = { enabled: true };

  constructor(service: string, mgmtPort: number) {
    this._service = service;
    this._mgmtPort = mgmtPort;
  }

  errorRate(rate: number): this {
    this._config.error_rate = rate;
    return this;
  }

  latency(minMs: number, maxMs: number = minMs): this {
    this._config.latency_min_ms = minMs;
    this._config.latency_max_ms = maxMs;
    return this;
  }

  connectionResetRate(rate: number): this {
    this._config.connection_reset_rate = rate;
    return this;
  }

  timeoutRate(rate: number): this {
    this._config.timeout_rate = rate;
    return this;
  }

  build(): Record<string, ChaosConfig> {
    return { [this._service]: { ...this._config } };
  }

  async apply(): Promise<void> {
    const url = `http://127.0.0.1:${this._mgmtPort}/_ldk/chaos`;
    const resp = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(this.build()),
    });
    if (!resp.ok) {
      throw new Error(`ChaosBuilder.apply() failed: ${resp.status}`);
    }
  }

  async clear(): Promise<void> {
    const url = `http://127.0.0.1:${this._mgmtPort}/_ldk/chaos/${this._service}`;
    await fetch(url, { method: "DELETE" });
  }
}
