/** Request logging middleware — records to buffer and broadcasts to WebSocket subscribers. */
import type { ServerState, LogEntry } from "../types";
export declare function addLogEntry(state: ServerState, entry: LogEntry): void;
export interface RequestContext {
    service: string;
    operation: string;
    requestId: string;
    startTime: number;
}
export declare function createRequestContext(service: string, operation: string): RequestContext;
export declare function recordLog(state: ServerState, ctx: RequestContext, method: string, path: string, status: number): void;
//# sourceMappingURL=logging.d.ts.map