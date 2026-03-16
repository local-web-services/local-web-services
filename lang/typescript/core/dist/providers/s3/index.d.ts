/** S3 REST wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
interface S3Object {
    key: string;
    body: Buffer;
    contentType: string;
    etag: string;
    lastModified: Date;
    size: number;
    metadata: Record<string, string>;
}
interface S3Bucket {
    name: string;
    objects: Map<string, S3Object>;
    createdAt: Date;
    tags: Array<{
        Key: string;
        Value: string;
    }>;
    policy?: string;
    website?: {
        indexDocument: string;
    };
}
export declare class S3Store {
    private buckets;
    private parts;
    reset(): void;
    storePart(uploadId: string, partNumber: string, data: Buffer): string;
    completeParts(uploadId: string): Buffer;
    createBucket(name: string): S3Bucket;
    getBucketTags(name: string): Array<{
        Key: string;
        Value: string;
    }>;
    setBucketTags(name: string, tags: Array<{
        Key: string;
        Value: string;
    }>): void;
    deleteBucketTags(name: string): void;
    getBucketPolicy(name: string): string | undefined;
    setBucketPolicy(name: string, policy: string): void;
    getBucketWebsite(name: string): {
        indexDocument: string;
    } | undefined;
    setBucketWebsite(name: string, indexDocument: string): void;
    deleteBucketWebsite(name: string): void;
    deleteBucket(name: string): void;
    getBucket(name: string): S3Bucket | undefined;
    listBuckets(): S3Bucket[];
    putObject(bucketName: string, key: string, body: Buffer, headers: Record<string, string>): S3Object;
    getObject(bucketName: string, key: string): S3Object | undefined;
    deleteObject(bucketName: string, key: string): void;
    listObjects(bucketName: string, prefix?: string, delimiter?: string): {
        objects: S3Object[];
        prefixes: string[];
    };
    copyObject(srcBucket: string, srcKey: string, dstBucket: string, dstKey: string): S3Object;
}
export declare function registerS3(app: FastifyInstance, state: ServerState): S3Store;
export {};
//# sourceMappingURL=index.d.ts.map