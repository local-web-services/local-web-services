"use strict";

const WebSocket = require("ws");

class LogCapture {
  constructor(mgmtPort) {
    this.mgmtPort = mgmtPort;
    this.ws = null;
    this.entries = [];
  }

  start() {
    this.entries = [];
    return new Promise((resolve, reject) => {
      const ws = new WebSocket(`ws://127.0.0.1:${this.mgmtPort}/_ldk/ws/logs`);
      this.ws = ws;
      ws.once("open", () => resolve());
      ws.once("error", (err) => reject(err));
      ws.on("message", (data) => {
        try {
          const raw = JSON.parse(data.toString());
          const entry = {
            ...raw,
            operation: raw["operation"] ?? raw["handler"],
          };
          this.entries.push(entry);
        } catch {
          // ignore invalid JSON
        }
      });
    });
  }

  async stop() {
    // Wait briefly for any in-flight WebSocket messages to arrive
    await new Promise((r) => setTimeout(r, 200));
    if (this.ws) {
      this.ws.close();
      this.ws = null;
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
