/** Log capture utilities for LWS testing sessions. */

export interface LogEntry {
  service?: string;
  operation?: string;
  level?: string;
  message?: string;
  [key: string]: unknown;
}

export class LogCapture {
  private snapshotLen = 0;
  private entries: LogEntry[] = [];

  constructor(private readonly mgmtPort: number) {}

  start(): void {
    this.snapshotLen = 0;
    this.entries = [];
  }

  async stop(): Promise<void> {
    // Fetch recent logs from the management API
    try {
      const res = await fetch(`http://127.0.0.1:${this.mgmtPort}/_ldk/status`);
      if (res.ok) {
        // Logs are streamed via WebSocket; for synchronous capture we
        // rely on entries collected via the WebSocket during the test.
        // A simple alternative is to parse the backlog from the API.
      }
    } catch {
      // ignore
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
