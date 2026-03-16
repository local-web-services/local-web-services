/** Management API — /_ldk/* endpoints. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../types";
import { WebSocketServer } from "ws";
declare function normalizeOp(op: string): string;
export declare function registerManagementApi(app: FastifyInstance, state: ServerState, wsServer: WebSocketServer): void;
export { normalizeOp };
//# sourceMappingURL=management.d.ts.map