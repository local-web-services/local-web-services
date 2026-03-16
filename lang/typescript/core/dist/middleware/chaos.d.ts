/** Chaos injection middleware. */
import type { FastifyReply, FastifyRequest } from "fastify";
import type { ServerState } from "../types";
export declare function applyChaos(state: ServerState, service: string, operation: string, _req: FastifyRequest, reply: FastifyReply): Promise<boolean>;
//# sourceMappingURL=chaos.d.ts.map