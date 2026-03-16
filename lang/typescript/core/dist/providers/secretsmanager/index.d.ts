/** SecretsManager wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
interface Secret {
    name: string;
    arn: string;
    secretString?: string;
    secretBinary?: string;
    description?: string;
    versionId: string;
    createdDate: number;
    lastChangedDate: number;
    deletedDate?: number;
    tags: Record<string, string>;
}
export declare class SecretsManagerStore {
    private secrets;
    reset(): void;
    createSecret(name: string, secretString?: string, secretBinary?: string, description?: string): Secret;
    getSecret(secretId: string): Secret | undefined;
    getSecretIncludingDeleted(secretId: string): Secret | undefined;
    putSecretValue(secretId: string, secretString?: string, secretBinary?: string): Secret;
    updateSecret(secretId: string, secretString?: string, secretBinary?: string, description?: string): Secret;
    restoreSecret(secretId: string): Secret;
    addTags(secretId: string, tags: Array<{
        Key: string;
        Value: string;
    }>): void;
    removeTags(secretId: string, tagKeys: string[]): void;
    listSecretVersionIds(secretId: string): Array<Record<string, unknown>>;
    deleteSecret(secretId: string, forceDelete?: boolean): void;
    listSecrets(): Secret[];
}
export declare function registerSecretsManager(app: FastifyInstance, state: ServerState): SecretsManagerStore;
export {};
//# sourceMappingURL=index.d.ts.map