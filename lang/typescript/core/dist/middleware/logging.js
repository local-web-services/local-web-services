"use strict";
/** Request logging middleware — records to buffer and broadcasts to WebSocket subscribers. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.addLogEntry = addLogEntry;
exports.createRequestContext = createRequestContext;
exports.recordLog = recordLog;
const uuid_1 = require("uuid");
const MAX_LOG_BUFFER = 500;
function addLogEntry(state, entry) {
    state.logBuffer.push(entry);
    if (state.logBuffer.length > MAX_LOG_BUFFER) {
        state.logBuffer.shift();
    }
    const msg = JSON.stringify(entry);
    for (const ws of state.logSubscribers) {
        try {
            ws.send(msg);
        }
        catch {
            state.logSubscribers.delete(ws);
        }
    }
}
function createRequestContext(service, operation) {
    return {
        service,
        operation,
        requestId: (0, uuid_1.v4)(),
        startTime: Date.now(),
    };
}
function recordLog(state, ctx, method, path, status) {
    const entry = {
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
//# sourceMappingURL=logging.js.map