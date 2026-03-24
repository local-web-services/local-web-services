/** Fluent builder for configuring capacity slot management. */

export class CapacityBuilder {
  private service: string;
  private managementPort: number;
  private config: { slots?: number | null } = {};

  constructor(service: string, managementPort: number) {
    this.service = service;
    this.managementPort = managementPort;
  }

  exhaust(): this {
    this.config.slots = 0;
    return this;
  }

  slots(n: number): this {
    this.config.slots = n;
    return this;
  }

  unlimited(): this {
    this.config.slots = null;
    return this;
  }

  async apply(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.managementPort}/_ldk/capacity`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: this.config }),
    });
  }

  async clear(): Promise<void> {
    return this.unlimited().apply();
  }
}
