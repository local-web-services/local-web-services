/** Log capture utilities for LWS testing sessions. */

import WebSocket from "ws";

export interface LogEntry {
  service?: string;
  operation?: string;
  level?: string;
  message?: string;
  [key: string]: unknown;
}

export class LogCapture {
  private ws: WebSocket | null = null;
  private entries: LogEntry[] = [];

  constructor(private readonly mgmtPort: number) {}

  async start(): Promise<void> {
    this.entries = [];
    return new Promise<void>((resolve, reject) => {
      const ws = new WebSocket(`ws://127.0.0.1:${this.mgmtPort}/_ldk/ws/logs`);
      this.ws = ws;
      ws.once("open", () => resolve());
      ws.once("error", (err: Error) => reject(err));
      ws.on("message", (data: WebSocket.RawData) => {
        try {
          const raw = JSON.parse(data.toString()) as Record<string, unknown>;
          const entry: LogEntry = {
            ...raw,
            operation: (raw["operation"] ?? raw["handler"]) as string | undefined,
          };
          this.entries.push(entry);
        } catch {
          // ignore invalid JSON
        }
      });
    });
  }

  async stop(): Promise<void> {
    // Wait briefly for any in-flight WebSocket messages to arrive
    await new Promise<void>((r) => setTimeout(r, 200));
    if (this.ws) {
      this.ws.close();
      this.ws = null;
    }
  }

  get all(): LogEntry[] {
    return [...this.entries];
  }

  forService(service: string): LogEntry[] {
    return this.entries.filter(
      (e) => (e.service ?? "").toLowerCase() === service.toLowerCase()
    );
  }

  forOperation(operation: string): LogEntry[] {
    return this.entries.filter((e) => e.operation === operation);
  }

  assertCalled(service: string, operation: string): void {
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

  assertNotCalled(service: string, operation: string): void {
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

  assertNoErrors(): void {
    const errors = this.entries.filter((e) => e.level === "ERROR");
    if (errors.length > 0) {
      throw new Error(
        `Expected no ERROR log entries, but found ${errors.length}: ${JSON.stringify(errors)}`
      );
    }
  }
}
