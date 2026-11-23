/**
 * Fluent builder for configuring AWS operation fakes.
 *
 * Mirrors `lws_testing/_builders/fake.py`.
 */

export interface FakeRule {
  operation: string;
  match_headers: Record<string, string>;
  response: {
    status: number;
    content_type: string;
    body?: string;
    delay_ms: number;
  };
}

export class FakeBuilder {
  private readonly _service: string;
  private readonly _mgmtPort: number;
  private readonly _rules: FakeRule[] = [];

  constructor(service: string, mgmtPort: number) {
    this._service = service;
    this._mgmtPort = mgmtPort;
  }

  operation(operationName: string): FakeRuleBuilder {
    return new FakeRuleBuilder(this, operationName);
  }

  _addRule(rule: FakeRule): void {
    this._rules.push(rule);
  }

  build(): Record<string, { enabled: boolean; rules: FakeRule[] }> {
    return { [this._service]: { enabled: true, rules: [...this._rules] } };
  }

  async apply(): Promise<void> {
    const url = `http://127.0.0.1:${this._mgmtPort}/_ldk/aws-fake`;
    const resp = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(this.build()),
    });
    if (!resp.ok) {
      throw new Error(`FakeBuilder.apply() failed: ${resp.status}`);
    }
  }

  async clear(): Promise<void> {
    const url = `http://127.0.0.1:${this._mgmtPort}/_ldk/aws-fake`;
    await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this._service]: { enabled: false, rules: [] } }),
    });
  }
}

export class FakeRuleBuilder {
  private readonly _parent: FakeBuilder;
  private readonly _operation: string;
  private readonly _matchHeaders: Record<string, string> = {};
  private _delayMs: number = 0;

  constructor(parent: FakeBuilder, operation: string) {
    this._parent = parent;
    this._operation = operation;
  }

  withHeader(name: string, value: string): this {
    this._matchHeaders[name] = value;
    return this;
  }

  delayMs(ms: number): this {
    this._delayMs = ms;
    return this;
  }

  respond(
    status: number = 200,
    body: string | Record<string, unknown> = "",
    contentType: string = "application/json",
    delayMs: number = 0,
  ): FakeBuilder {
    const bodyStr = typeof body === "string" ? body : JSON.stringify(body);
    const rule: FakeRule = {
      operation: this._operation,
      match_headers: { ...this._matchHeaders },
      response: {
        status,
        content_type: contentType,
        delay_ms: delayMs || this._delayMs,
        ...(bodyStr !== "" && { body: bodyStr }),
      },
    };
    this._parent._addRule(rule);
    return this._parent;
  }

  error(errorType: string, message: string = "", status: number = 400): FakeBuilder {
    return this.respond(status, { __type: errorType, message });
  }
}
