/** Request logging middleware — records to buffer and broadcasts to WebSocket subscribers. */

import { v4 as uuidv4 } from "uuid";
import type { ServerState, LogEntry } from "../types";

const MAX_LOG_BUFFER = 500;

export function addLogEntry(state: ServerState, entry: LogEntry): void {
  state.logBuffer.push(entry);
  if (state.logBuffer.length > MAX_LOG_BUFFER) {
    state.logBuffer.shift();
  }
  const msg = JSON.stringify(entry);
  for (const ws of state.logSubscribers) {
    try {
      ws.send(msg);
    } catch {
      state.logSubscribers.delete(ws);
    }
  }
}

export interface RequestContext {
  service: string;
  operation: string;
  requestId: string;
  startTime: number;
}

export function createRequestContext(service: string, operation: string): RequestContext {
  return {
    service,
    operation,
    requestId: uuidv4(),
    startTime: Date.now(),
  };
}

export function recordLog(
  state: ServerState,
  ctx: RequestContext,
  method: string,
  path: string,
  status: number,
): void {
  const entry: LogEntry = {
    timestamp: new Date().toISOString(),
    service: ctx.service,
    operation: ctx.operation,
    method,
    path,
    status,
    duration_ms: Date.now() - ctx.startTime,
    request_id: ctx.requestId,
  };
  addLogEntry(state, entry);
}
