"use strict";

class FakeBuilder {
  constructor(service, mgmtPort) {
    this.service = service;
    this.mgmtPort = mgmtPort;
    this.rules = [];
  }

  operation(operationName) {
    return new FakeRuleBuilder(this, operationName);
  }

  async _addRule(rule) {
    this.rules.push(rule);
    await this._apply();
  }

  async _apply() {
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/aws-fake`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: { enabled: true, rules: this.rules } }),
    });
  }

  async clear() {
    this.rules = [];
    await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/aws-fake`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ [this.service]: { enabled: false, rules: [] } }),
    });
  }
}

class FakeRuleBuilder {
  constructor(parent, operation) {
    this.parent = parent;
    this.operation = operation;
    this.matchHeaders = {};
  }

  withHeader(name, value) {
    this.matchHeaders[name] = value;
    return this;
  }

  async respond(opts) {
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

  async error(errorType, message = "", status = 400) {
    return this.respond({
      status,
      body: JSON.stringify({ __type: errorType, message }),
    });
  }
}

module.exports = { FakeBuilder, FakeRuleBuilder };
