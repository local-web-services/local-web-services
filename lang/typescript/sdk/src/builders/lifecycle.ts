/** Fluent builder for configuring resource lifecycle simulation. */
export class LifecycleBuilder {
  private config: Record<string, unknown> = { enabled: true };

  constructor(
    private readonly service: string,
    private readonly mgmtPort: number,
  ) {}

  createDwellMs(ms: number): this {
    this.config.create_dwell_ms = Math.floor(ms);
    return this;
  }

  deleteDwellMs(ms: number): this {
    this.config.delete_dwell_ms = Math.floor(ms);
    return this;
  }

  async apply(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/lifecycle`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: this.config }),
    });
  }

  async clear(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/lifecycle`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        [this.service]: { enabled: false, create_dwell_ms: 0, delete_dwell_ms: 0 },
      }),
    });
  }
}
