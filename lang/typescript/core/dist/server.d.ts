/** Multi-port Fastify server orchestration. */
import { type ServerState } from "./types";
export interface LwsServerConfig {
    basePort: number;
    host?: string;
}
export interface LwsServer {
    state: ServerState;
    managementUrl: string;
    ports: Record<string, number>;
    close(): Promise<void>;
}
export declare function startServer(config: LwsServerConfig): Promise<LwsServer>;
//# sourceMappingURL=server.d.ts.map