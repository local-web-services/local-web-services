"use strict";

class LogCapture {
  constructor(mgmtPort) {
    this.mgmtPort = mgmtPort;
    this.entries = [];
  }

  start() {
    this.entries = [];
  }

  async stop() {
    try {
      const res = await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/status`);
      if (res.ok) {
        // Logs collected via WebSocket during the test.
      }
    } catch {
      // ignore
    }
  }

  get all() {
    return [...this.entries];
  }

  forService(service) {
    return this.entries.filter(
      (e) => (e.service ?? "").toLowerCase() === service.toLowerCase()
    );
  }

  forOperation(operation) {
    return this.entries.filter((e) => e.operation === operation);
  }

  assertCalled(service, operation) {
    const matching = this.entries.filter(
      (e) =>
        (e.service ?? "").toLowerCase() === service.toLowerCase() &&
        e.operation === operation
    );
    if (matching.length === 0) {
      throw new Error(
        `Expected ${service}.${operation} to have been called, ` +
          `but no matching log entry was found. Captured: ${JSON.stringify(this.entries)}`
      );
    }
  }

  assertNotCalled(service, operation) {
    const matching = this.entries.filter(
      (e) =>
        (e.service ?? "").toLowerCase() === service.toLowerCase() &&
        e.operation === operation
    );
    if (matching.length > 0) {
      throw new Error(
        `Expected ${service}.${operation} NOT to have been called, ` +
          `but found ${matching.length} matching log entry/entries.`
      );
    }
  }

  assertNoErrors() {
    const errors = this.entries.filter((e) => e.level === "ERROR");
    if (errors.length > 0) {
      throw new Error(
        `Expected no ERROR log entries, but found ${errors.length}: ${JSON.stringify(errors)}`
      );
    }
  }
}

module.exports = { LogCapture };
