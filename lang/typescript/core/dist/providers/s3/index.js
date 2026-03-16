"use strict";
/** S3 REST wire-protocol Fastify plugin. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.S3Store = void 0;
exports.registerS3 = registerS3;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const ACCOUNT_ID = "000000000000";
const REGION = "us-east-1";
class S3Store {
    constructor() {
        this.buckets = new Map();
        // multipart parts: key = "uploadId#partNumber", value = Buffer
        this.parts = new Map();
    }
    reset() {
        this.buckets.clear();
        this.parts.clear();
    }
    storePart(uploadId, partNumber, data) {
        const { createHash } = require("crypto");
        const etag = `"${createHash("md5").update(data).digest("hex")}"`;
        this.parts.set(`${uploadId}#${partNumber}`, data);
        return etag;
    }
    completeParts(uploadId) {
        // Gather all parts for this upload in order
        const partEntries = [];
        for (const [key, data] of this.parts.entries()) {
            const [uid, numStr] = key.split("#");
            if (uid === uploadId) {
                partEntries.push({ num: parseInt(numStr, 10), data });
            }
        }
        partEntries.sort((a, b) => a.num - b.num);
        // Remove parts from store
        for (const entry of partEntries) {
            this.parts.delete(`${uploadId}#${entry.num}`);
        }
        return Buffer.concat(partEntries.map((e) => e.data));
    }
    createBucket(name) {
        if (this.buckets.has(name))
            return this.buckets.get(name);
        const bucket = { name, objects: new Map(), createdAt: new Date(), tags: [] };
        this.buckets.set(name, bucket);
        return bucket;
    }
    getBucketTags(name) {
        return this.buckets.get(name)?.tags ?? [];
    }
    setBucketTags(name, tags) {
        const bucket = this.buckets.get(name);
        if (bucket)
            bucket.tags = tags;
    }
    deleteBucketTags(name) {
        const bucket = this.buckets.get(name);
        if (bucket)
            bucket.tags = [];
    }
    getBucketPolicy(name) {
        return this.buckets.get(name)?.policy;
    }
    setBucketPolicy(name, policy) {
        const bucket = this.buckets.get(name);
        if (bucket)
            bucket.policy = policy;
    }
    getBucketWebsite(name) {
        return this.buckets.get(name)?.website;
    }
    setBucketWebsite(name, indexDocument) {
        const bucket = this.buckets.get(name);
        if (bucket)
            bucket.website = { indexDocument };
    }
    deleteBucketWebsite(name) {
        const bucket = this.buckets.get(name);
        if (bucket)
            delete bucket.website;
    }
    deleteBucket(name) {
        this.buckets.delete(name);
    }
    getBucket(name) {
        return this.buckets.get(name);
    }
    listBuckets() {
        return Array.from(this.buckets.values());
    }
    putObject(bucketName, key, body, headers) {
        const bucket = this.buckets.get(bucketName);
        if (!bucket)
            throw new Error(`NoSuchBucket: ${bucketName}`);
        const { createHash } = require("crypto");
        const etag = `"${createHash("md5").update(body).digest("hex")}"`;
        const obj = {
            key,
            body,
            contentType: headers["content-type"] ?? "application/octet-stream",
            etag,
            lastModified: new Date(),
            size: body.length,
            metadata: {},
        };
        bucket.objects.set(key, obj);
        return obj;
    }
    getObject(bucketName, key) {
        return this.buckets.get(bucketName)?.objects.get(key);
    }
    deleteObject(bucketName, key) {
        this.buckets.get(bucketName)?.objects.delete(key);
    }
    listObjects(bucketName, prefix, delimiter) {
        const bucket = this.buckets.get(bucketName);
        if (!bucket)
            throw new Error(`NoSuchBucket: ${bucketName}`);
        const objects = Array.from(bucket.objects.values());
        let filtered = prefix ? objects.filter((o) => o.key.startsWith(prefix)) : objects;
        const prefixes = new Set();
        if (delimiter) {
            const result = [];
            for (const obj of filtered) {
                const keyAfterPrefix = prefix ? obj.key.slice(prefix.length) : obj.key;
                const delimIdx = keyAfterPrefix.indexOf(delimiter);
                if (delimIdx >= 0) {
                    const commonPrefix = (prefix ?? "") + keyAfterPrefix.slice(0, delimIdx + 1);
                    prefixes.add(commonPrefix);
                }
                else {
                    result.push(obj);
                }
            }
            filtered = result;
        }
        return { objects: filtered.sort((a, b) => a.key.localeCompare(b.key)), prefixes: Array.from(prefixes) };
    }
    copyObject(srcBucket, srcKey, dstBucket, dstKey) {
        const src = this.getObject(srcBucket, srcKey);
        if (!src)
            throw new Error(`NoSuchKey: ${srcKey}`);
        return this.putObject(dstBucket, dstKey, src.body, { "content-type": src.contentType });
    }
}
exports.S3Store = S3Store;
function xmlReply(reply, content, status = 200) {
    reply.status(status).header("Content-Type", "application/xml").send(`<?xml version="1.0" encoding="UTF-8"?>${content}`);
}
function s3Error(reply, code, message, status = 400) {
    xmlReply(reply, `<Error><Code>${code}</Code><Message>${message}</Message><RequestId>${(0, uuid_1.v4)()}</RequestId></Error>`, status);
}
function registerS3(app, state) {
    const store = new S3Store();
    state.resetCallbacks.push(() => store.reset());
    // S3 uses path-style routing: /{bucket}/{key}
    // We need raw body for object uploads
    app.addContentTypeParser("*", { parseAs: "buffer" }, (_req, body, done) => {
        done(null, body);
    });
    // Global IAM auth check for all S3 requests — return XML since S3 uses XML wire protocol
    app.addHook("preHandler", async (req, reply) => {
        if (await (0, iam_1.applyIamAuth)(state, "s3", "s3-operation", req, reply, true)) {
            return reply;
        }
    });
    // List all buckets: GET /
    app.get("/", async (req, reply) => {
        const ctx = (0, logging_1.createRequestContext)("s3", "ListBuckets");
        if (await (0, chaos_1.applyChaos)(state, "s3", "ListBuckets", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "s3", "ListBuckets", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const buckets = store.listBuckets();
        const bucketsXml = buckets
            .map((b) => `<Bucket><Name>${b.name}</Name><CreationDate>${b.createdAt.toISOString()}</CreationDate></Bucket>`)
            .join("");
        xmlReply(reply, `<ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Owner><ID>${ACCOUNT_ID}</ID><DisplayName>test</DisplayName></Owner>
  <Buckets>${bucketsXml}</Buckets>
</ListAllMyBucketsResult>`);
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    // Bucket-level operations: PUT /{bucket}, DELETE /{bucket}, GET /{bucket}?...
    app.put("/:bucket", async (req, reply) => {
        const { bucket } = req.params;
        const ctx = (0, logging_1.createRequestContext)("s3", "CreateBucket");
        if (await (0, chaos_1.applyChaos)(state, "s3", "CreateBucket", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        store.createBucket(bucket);
        reply.status(200).header("Location", `/${bucket}`).send("");
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    app.delete("/:bucket", async (req, reply) => {
        const { bucket } = req.params;
        const ctx = (0, logging_1.createRequestContext)("s3", "DeleteBucket");
        store.deleteBucket(bucket);
        reply.status(204).send();
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    app.get("/:bucket", async (req, reply) => {
        const { bucket } = req.params;
        const query = req.query;
        const ctx = (0, logging_1.createRequestContext)("s3", "ListObjectsV2");
        if (await (0, chaos_1.applyChaos)(state, "s3", "ListObjectsV2", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "s3", "ListObjectsV2", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            const { objects, prefixes } = store.listObjects(bucket, query.prefix, query.delimiter);
            const maxKeys = parseInt(query["max-keys"] ?? "1000", 10);
            const truncated = objects.length > maxKeys;
            const sliced = objects.slice(0, maxKeys);
            const objectsXml = sliced
                .map((o) => `<Contents>
  <Key>${escapeXml(o.key)}</Key>
  <LastModified>${o.lastModified.toISOString()}</LastModified>
  <ETag>${o.etag}</ETag>
  <Size>${o.size}</Size>
  <StorageClass>STANDARD</StorageClass>
</Contents>`)
                .join("");
            const prefixesXml = prefixes
                .map((p) => `<CommonPrefixes><Prefix>${escapeXml(p)}</Prefix></CommonPrefixes>`)
                .join("");
            xmlReply(reply, `<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Name>${bucket}</Name>
  <Prefix>${escapeXml(query.prefix ?? "")}</Prefix>
  <MaxKeys>${maxKeys}</MaxKeys>
  <IsTruncated>${truncated}</IsTruncated>
  <KeyCount>${sliced.length}</KeyCount>
  ${objectsXml}
  ${prefixesXml}
</ListBucketResult>`);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            s3Error(reply, "NoSuchBucket", msg, 404);
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    // Object-level operations: GET/PUT/DELETE /{bucket}/{key*}
    app.put("/:bucket/*", async (req, reply) => {
        const params = req.params;
        const bucket = params.bucket;
        const key = params["*"];
        // Bucket-level PUT operations when key is empty (SDK sends PUT /bucket/?tagging etc.)
        if (!key || key === "") {
            const query = req.query;
            if ("tagging" in query) {
                // PutBucketTagging: parse XML body
                const ctx = (0, logging_1.createRequestContext)("s3", "PutBucketTagging");
                const bodyBuf = req.body ?? Buffer.alloc(0);
                const bodyStr = bodyBuf.toString();
                const tagMatches = [...bodyStr.matchAll(/<Tag>\s*<Key>([^<]+)<\/Key>\s*<Value>([^<]*)<\/Value>\s*<\/Tag>/g)];
                const tags = tagMatches.map((m) => ({ Key: m[1], Value: m[2] }));
                store.setBucketTags(bucket, tags);
                reply.status(200).send("");
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("policy" in query) {
                // PutBucketPolicy
                const ctx = (0, logging_1.createRequestContext)("s3", "PutBucketPolicy");
                const bodyBuf = req.body ?? Buffer.alloc(0);
                store.setBucketPolicy(bucket, bodyBuf.toString());
                reply.status(200).send("");
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("notification" in query) {
                // PutBucketNotificationConfiguration - no-op
                const ctx = (0, logging_1.createRequestContext)("s3", "PutBucketNotificationConfiguration");
                reply.status(200).send("");
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("website" in query) {
                // PutBucketWebsite: parse XML body
                const ctx = (0, logging_1.createRequestContext)("s3", "PutBucketWebsite");
                const bodyBuf = req.body ?? Buffer.alloc(0);
                const bodyStr = bodyBuf.toString();
                const suffixMatch = /<Suffix>([^<]+)<\/Suffix>/.exec(bodyStr);
                const indexDoc = suffixMatch ? suffixMatch[1] : "index.html";
                store.setBucketWebsite(bucket, indexDoc);
                reply.status(200).send("");
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("acl" in query || "cors" in query || "versioning" in query || "accelerate" in query || "logging" in query || "replication" in query || "lifecycle" in query || "encryption" in query || "ownershipControls" in query || "publicAccessBlock" in query) {
                // No-op bucket configuration PUT operations
                reply.status(200).send("");
                return;
            }
            // SDK sends PUT /bucket/ (trailing slash) for CreateBucket — treat empty key as bucket creation
            const ctx = (0, logging_1.createRequestContext)("s3", "CreateBucket");
            if (await (0, chaos_1.applyChaos)(state, "s3", "CreateBucket", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            store.createBucket(bucket);
            reply.status(200).header("Location", `/${bucket}`).send("");
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const query = req.query;
        // UploadPart: PUT /:bucket/:key?partNumber=N&uploadId=...
        if ("partNumber" in query && "uploadId" in query) {
            const ctx = (0, logging_1.createRequestContext)("s3", "UploadPart");
            if (await (0, chaos_1.applyChaos)(state, "s3", "UploadPart", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            const partBody = req.body ?? Buffer.alloc(0);
            const etag = store.storePart(query.uploadId, query.partNumber, partBody);
            reply.status(200).header("ETag", etag).send("");
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const ctx = (0, logging_1.createRequestContext)("s3", "PutObject");
        if (await (0, chaos_1.applyChaos)(state, "s3", "PutObject", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "s3", "PutObject", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        // Check if this is a copy operation
        const copySource = req.headers["x-amz-copy-source"];
        if (copySource) {
            const decoded = decodeURIComponent(copySource.startsWith("/") ? copySource.slice(1) : copySource);
            const slashIdx = decoded.indexOf("/");
            const srcBucket = decoded.slice(0, slashIdx);
            const srcKey = decoded.slice(slashIdx + 1);
            try {
                const obj = store.copyObject(srcBucket, srcKey, bucket, key);
                reply.status(200).header("Content-Type", "application/xml").send(`<?xml version="1.0"?><CopyObjectResult><ETag>${obj.etag}</ETag><LastModified>${obj.lastModified.toISOString()}</LastModified></CopyObjectResult>`);
            }
            catch (err) {
                const msg = err instanceof Error ? err.message : String(err);
                s3Error(reply, "NoSuchKey", msg, 404);
            }
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            const body = req.body ?? Buffer.alloc(0);
            const obj = store.putObject(bucket, key, body, req.headers);
            reply
                .status(200)
                .header("ETag", obj.etag)
                .send("");
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            s3Error(reply, "NoSuchBucket", msg, 404);
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    app.get("/:bucket/*", async (req, reply) => {
        const params = req.params;
        const bucket = params.bucket;
        const key = params["*"];
        const query = req.query;
        // Bucket-level operations when key is empty (SDK sends GET /bucket/)
        if (!key || key === "") {
            // Handle bucket-level query operations
            if ("location" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "GetBucketLocation");
                xmlReply(reply, `<LocationConstraint xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`);
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("tagging" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "GetBucketTagging");
                const tags = store.getBucketTags(bucket);
                const tagsXml = tags.map((t) => `<Tag><Key>${escapeXml(t.Key)}</Key><Value>${escapeXml(t.Value)}</Value></Tag>`).join("");
                xmlReply(reply, `<Tagging xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><TagSet>${tagsXml}</TagSet></Tagging>`);
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("policy" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "GetBucketPolicy");
                const policy = store.getBucketPolicy(bucket);
                if (!policy) {
                    s3Error(reply, "NoSuchBucketPolicy", `The bucket policy does not exist: ${bucket}`, 404);
                }
                else {
                    reply.status(200).header("Content-Type", "application/json").send(policy);
                }
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("notification" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "GetBucketNotificationConfiguration");
                xmlReply(reply, `<NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`);
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("website" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "GetBucketWebsite");
                const website = store.getBucketWebsite(bucket);
                if (!website) {
                    s3Error(reply, "NoSuchWebsiteConfiguration", `The specified bucket does not have a website configuration: ${bucket}`, 404);
                }
                else {
                    xmlReply(reply, `<WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><IndexDocument><Suffix>${escapeXml(website.indexDocument)}</Suffix></IndexDocument></WebsiteConfiguration>`);
                }
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("acl" in query || "cors" in query || "versioning" in query || "accelerate" in query || "requestPayment" in query || "logging" in query || "replication" in query || "lifecycle" in query || "encryption" in query || "ownershipControls" in query || "publicAccessBlock" in query || "intelligentTieringConfiguration" in query) {
                // No-op bucket configuration operations - return empty/default response
                xmlReply(reply, `<Empty xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`);
                return;
            }
            // Default: ListObjectsV2
            const ctx = (0, logging_1.createRequestContext)("s3", "ListObjectsV2");
            if (await (0, chaos_1.applyChaos)(state, "s3", "ListObjectsV2", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if (await (0, fake_1.applyFake)(state, "s3", "ListObjectsV2", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            try {
                const { objects, prefixes } = store.listObjects(bucket, query.prefix, query.delimiter);
                const maxKeys = parseInt(query["max-keys"] ?? "1000", 10);
                const truncated = objects.length > maxKeys;
                const sliced = objects.slice(0, maxKeys);
                const objectsXml = sliced.map((o) => `<Contents><Key>${escapeXml(o.key)}</Key><LastModified>${o.lastModified.toISOString()}</LastModified><ETag>${o.etag}</ETag><Size>${o.size}</Size><StorageClass>STANDARD</StorageClass></Contents>`).join("");
                const prefixesXml = prefixes.map((p) => `<CommonPrefixes><Prefix>${escapeXml(p)}</Prefix></CommonPrefixes>`).join("");
                xmlReply(reply, `<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Name>${bucket}</Name><Prefix>${escapeXml(query.prefix ?? "")}</Prefix><MaxKeys>${maxKeys}</MaxKeys><IsTruncated>${truncated}</IsTruncated><KeyCount>${sliced.length}</KeyCount>${objectsXml}${prefixesXml}</ListBucketResult>`);
            }
            catch (err) {
                const msg = err instanceof Error ? err.message : String(err);
                s3Error(reply, "NoSuchBucket", msg, 404);
            }
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        // ListParts: GET /:bucket/:key?uploadId=...
        if ("uploadId" in query) {
            const ctx = (0, logging_1.createRequestContext)("s3", "ListParts");
            if (await (0, chaos_1.applyChaos)(state, "s3", "ListParts", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            xmlReply(reply, `<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <UploadId>${query.uploadId}</UploadId>
  <IsTruncated>false</IsTruncated>
</ListPartsResult>`);
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const ctx = (0, logging_1.createRequestContext)("s3", "GetObject");
        if (await (0, chaos_1.applyChaos)(state, "s3", "GetObject", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "s3", "GetObject", req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const obj = store.getObject(bucket, key);
        if (!obj) {
            s3Error(reply, "NoSuchKey", `The specified key does not exist: ${key}`, 404);
        }
        else {
            reply
                .status(200)
                .header("Content-Type", obj.contentType)
                .header("ETag", obj.etag)
                .header("Last-Modified", obj.lastModified.toUTCString())
                .header("Content-Length", String(obj.size))
                .send(obj.body);
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    app.delete("/:bucket/*", async (req, reply) => {
        const params = req.params;
        const bucket = params.bucket;
        const key = params["*"];
        const query = req.query;
        // Bucket-level DELETE operations when key is empty
        if (!key || key === "") {
            if ("tagging" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "DeleteBucketTagging");
                store.deleteBucketTags(bucket);
                reply.status(204).send();
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("website" in query) {
                const ctx = (0, logging_1.createRequestContext)("s3", "DeleteBucketWebsite");
                store.deleteBucketWebsite(bucket);
                reply.status(204).send();
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if ("policy" in query || "cors" in query || "lifecycle" in query || "replication" in query || "encryption" in query || "ownershipControls" in query || "publicAccessBlock" in query) {
                reply.status(204).send();
                return;
            }
            // DeleteBucket with trailing slash
            const ctx = (0, logging_1.createRequestContext)("s3", "DeleteBucket");
            store.deleteBucket(bucket);
            reply.status(204).send();
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        // AbortMultipartUpload: DELETE /:bucket/:key?uploadId=...
        if ("uploadId" in query) {
            const ctx = (0, logging_1.createRequestContext)("s3", "AbortMultipartUpload");
            reply.status(204).send();
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        const ctx = (0, logging_1.createRequestContext)("s3", "DeleteObject");
        store.deleteObject(bucket, key);
        reply.status(204).send();
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    app.head("/:bucket/*", async (req, reply) => {
        const params = req.params;
        const bucket = params.bucket;
        const key = params["*"];
        // HeadBucket: HEAD /bucket/ with empty key
        if (!key || key === "") {
            const bucketObj = store.getBucket(bucket);
            if (!bucketObj) {
                reply.status(404).send();
            }
            else {
                reply.status(200).send();
            }
            return;
        }
        const obj = store.getObject(bucket, key);
        if (!obj) {
            reply.status(404).send();
        }
        else {
            reply
                .status(200)
                .header("Content-Type", obj.contentType)
                .header("ETag", obj.etag)
                .header("Content-Length", String(obj.size))
                .send();
        }
    });
    // Multipart upload operations: POST /:bucket/:key?uploads or POST /:bucket/:key?uploadId=...
    app.post("/:bucket/*", async (req, reply) => {
        const params = req.params;
        const bucket = params.bucket;
        const key = params["*"];
        const query = req.query;
        // DeleteObjects: POST /:bucket/?delete (empty key with trailing slash)
        if ((!key || key === "") && "delete" in query) {
            const ctx = (0, logging_1.createRequestContext)("s3", "DeleteObjects");
            const body = req.body;
            const bodyStr = Buffer.isBuffer(body) ? body.toString() : String(body ?? "");
            const keyMatches = [...bodyStr.matchAll(/<Key>([^<]+)<\/Key>/g)];
            const deleted = [];
            for (const match of keyMatches) {
                const objKey = match[1];
                store.deleteObject(bucket, objKey);
                deleted.push(objKey);
            }
            const deletedXml = deleted.map((k) => `<Deleted><Key>${escapeXml(k)}</Key></Deleted>`).join("");
            xmlReply(reply, `<DeleteResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">${deletedXml}</DeleteResult>`);
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if ("uploads" in query) {
            // CreateMultipartUpload
            const ctx = (0, logging_1.createRequestContext)("s3", "CreateMultipartUpload");
            if (await (0, chaos_1.applyChaos)(state, "s3", "CreateMultipartUpload", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if (await (0, fake_1.applyFake)(state, "s3", "CreateMultipartUpload", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            const uploadId = (0, uuid_1.v4)();
            xmlReply(reply, `<InitiateMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <UploadId>${uploadId}</UploadId>
</InitiateMultipartUploadResult>`);
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if ("uploadId" in query) {
            // CompleteMultipartUpload - just store empty body for the key
            const ctx = (0, logging_1.createRequestContext)("s3", "CompleteMultipartUpload");
            if (await (0, chaos_1.applyChaos)(state, "s3", "CompleteMultipartUpload", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            if (await (0, fake_1.applyFake)(state, "s3", "CompleteMultipartUpload", req, reply)) {
                (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
                return;
            }
            try {
                store.createBucket(bucket); // ensure exists
                const combinedBody = store.completeParts(query.uploadId);
                store.putObject(bucket, key, combinedBody, {});
            }
            catch {
                // ignore
            }
            const location = `http://127.0.0.1/${bucket}/${key}`;
            xmlReply(reply, `<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Location>${location}</Location>
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <ETag>"${(0, uuid_1.v4)().replace(/-/g, "")}"</ETag>
</CompleteMultipartUploadResult>`);
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        reply.status(400).send();
    });
    // Delete objects batch
    app.post("/:bucket", async (req, reply) => {
        const { bucket } = req.params;
        const query = req.query;
        if ("delete" in query) {
            const ctx = (0, logging_1.createRequestContext)("s3", "DeleteObjects");
            // Parse XML body for delete operation
            const body = req.body;
            const bodyStr = Buffer.isBuffer(body) ? body.toString() : String(body ?? "");
            const keyMatches = [...bodyStr.matchAll(/<Key>([^<]+)<\/Key>/g)];
            const deleted = [];
            for (const match of keyMatches) {
                const key = match[1];
                store.deleteObject(bucket, key);
                deleted.push(key);
            }
            const deletedXml = deleted
                .map((k) => `<Deleted><Key>${escapeXml(k)}</Key></Deleted>`)
                .join("");
            xmlReply(reply, `<DeleteResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">${deletedXml}</DeleteResult>`);
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        reply.status(400).send();
    });
    void ACCOUNT_ID;
    void REGION;
    return store;
}
function escapeXml(str) {
    return str
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;");
}
//# sourceMappingURL=index.js.map