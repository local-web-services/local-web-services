/** Fake response middleware — intercepts and returns pre-configured responses. */
import type { FastifyReply, FastifyRequest } from "fastify";
import type { ServerState } from "../types";
export declare function applyFake(state: ServerState, service: string, operation: string, req: FastifyRequest, reply: FastifyReply): Promise<boolean>;
//# sourceMappingURL=fake.d.ts.map