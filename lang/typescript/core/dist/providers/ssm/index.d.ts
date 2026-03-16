/** SSM wire-protocol Fastify plugin (JSON API). */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
interface SsmParameter {
    name: string;
    value: string;
    type: string;
    version: number;
    arn: string;
    description?: string;
    lastModifiedDate: number;
}
export declare class SsmStore {
    private params;
    reset(): void;
    putParameter(name: string, value: string, type?: string, description?: string): SsmParameter;
    getParameter(name: string, withDecryption?: boolean): SsmParameter | undefined;
    getParametersByPath(path: string): SsmParameter[];
    deleteParameter(name: string): void;
    describeParameters(filters?: Array<{
        Key: string;
        Values: string[];
    }>): SsmParameter[];
}
export declare function registerSsm(app: FastifyInstance, state: ServerState): SsmStore;
export {};
//# sourceMappingURL=index.d.ts.map