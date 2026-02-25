/** Fluent builder for configuring AWS operation fakes. */

export class FakeBuilder {
  private readonly rules: Array<Record<string, unknown>> = [];

  constructor(
    private readonly service: string,
    private readonly mgmtPort: number
  ) {}

  operation(operationName: string): FakeRuleBuilder {
    return new FakeRuleBuilder(this, operationName);
  }

  async _addRule(rule: Record<string, unknown>): Promise<void> {
    this.rules.push(rule);
    await this._apply();
  }

  private async _apply(): Promise<void> {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/aws-fake`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: { enabled: true, rules: this.rules } }),
    });
  }

  async clear(): Promise<void> {
    this.rules.length = 0;
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/aws-fake`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: { enabled: false, rules: [] } }),
    });
  }
}

export class FakeRuleBuilder {
  private matchHeaders: Record<string, string> = {};

  constructor(
    private readonly parent: FakeBuilder,
    private readonly operation: string
  ) {}

  withHeader(name: string, value: string): FakeRuleBuilder {
    this.matchHeaders[name] = value;
    return this;
  }

  async respond(opts: {
    status?: number;
    body?: string | object;
    contentType?: string;
    delayMs?: number;
  }): Promise<FakeBuilder> {
    const body =
      typeof opts.body === "object" ? JSON.stringify(opts.body) : opts.body ?? "";
    const rule = {
      operation: this.operation,
      match_headers: this.matchHeaders,
      response: {
        status: opts.status ?? 200,
        content_type: opts.contentType ?? "application/json",
        delay_ms: opts.delayMs ?? 0,
        body,
      },
    };
    await this.parent._addRule(rule);
    return this.parent;
  }

  async error(errorType: string, message = "", status = 400): Promise<FakeBuilder> {
    return this.respond({
      status,
      body: JSON.stringify({ __type: errorType, message }),
    });
  }
}
