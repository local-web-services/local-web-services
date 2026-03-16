/** DynamoDB wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import { DynamoStore } from "./store";
import type { ServerState } from "../../types";
export declare function registerDynamoDb(app: FastifyInstance, state: ServerState): DynamoStore;
//# sourceMappingURL=index.d.ts.map