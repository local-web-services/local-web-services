/** Fluent builder for configuring chaos engineering rules. */

export class ChaosBuilder {
  private config: Record<string, unknown> = { enabled: true };

  constructor(
    private readonly service: string,
    private readonly mgmtPort: number
  ) {}

  errorRate(rate: number): ChaosBuilder {
    this.config.error_rate = rate;
    return this;
  }

  latency(minMs: number, maxMs: number): ChaosBuilder {
    this.config.latency_min_ms = minMs;
    this.config.latency_max_ms = maxMs;
    return this;
  }

  connectionResetRate(rate: number): ChaosBuilder {
    this.config.connection_reset_rate = rate;
    return this;
  }

  timeoutRate(rate: number): ChaosBuilder {
    this.config.timeout_rate = rate;
    return this;
  }

  async apply(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/chaos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: this.config }),
    });
  }

  async clear(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/chaos`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        [this.service]: { enabled: false, error_rate: 0.0 },
      }),
    });
  }
}
