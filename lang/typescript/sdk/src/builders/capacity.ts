export interface CapacityConfig {
  slots: number | null;
}

export class CapacityBuilder {
  private readonly service: string;
  private readonly managementUrl: string;
  private config: CapacityConfig = { slots: null };

  constructor(service: string, managementUrl: string) {
    this.service = service;
    this.managementUrl = managementUrl;
  }

  exhaust(): this {
    this.config = { slots: 0 };
    return this;
  }

  slots(n: number): this {
    this.config = { slots: n };
    return this;
  }

  unlimited(): this {
    this.config = { slots: null };
    return this;
  }

  build(): Record<string, CapacityConfig> {
    return { [this.service]: { ...this.config } };
  }

  async apply(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/capacity`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(this.build()),
    });
  }

  async clear(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/capacity/${this.service}`, {
      method: "DELETE",
    });
  }

  async isExhausted(): Promise<boolean> {
    const response = await fetch(`${this.managementUrl}/_ldk/capacity/${this.service}`);
    const data = (await response.json()) as CapacityConfig;
    return data.slots === 0;
  }
}
