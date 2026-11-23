export interface LifecycleConfig {
  enabled: boolean;
  create_dwell_ms: number;
  delete_dwell_ms: number;
  modify_dwell_ms: number;
}

export class LifecycleBuilder {
  private readonly service: string;
  private readonly managementUrl: string;
  private config: Partial<LifecycleConfig> = { enabled: true };

  constructor(service: string, managementUrl: string) {
    this.service = service;
    this.managementUrl = managementUrl;
  }

  createDwellMs(ms: number): this {
    this.config.create_dwell_ms = ms;
    return this;
  }

  deleteDwellMs(ms: number): this {
    this.config.delete_dwell_ms = ms;
    return this;
  }

  modifyDwellMs(ms: number): this {
    this.config.modify_dwell_ms = ms;
    return this;
  }

  build(): Record<string, Partial<LifecycleConfig>> {
    return { [this.service]: { ...this.config } };
  }

  async apply(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/lifecycle`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(this.build()),
    });
  }

  async clear(): Promise<void> {
    await fetch(`${this.managementUrl}/_ldk/lifecycle/${this.service}`, {
      method: "DELETE",
    });
  }
}
