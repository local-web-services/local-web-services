/** IAM policy evaluation middleware. */
import type { FastifyReply, FastifyRequest } from "fastify";
import type { ServerState } from "../types";
export declare function applyIamAuth(state: ServerState, service: string, operation: string, req: FastifyRequest, reply: FastifyReply, xmlProtocol?: boolean): Promise<boolean>;
//# sourceMappingURL=iam.d.ts.map