/** S3 REST wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import type { SnsStore } from "../sns";
import type { SqsStore } from "../sqs";
import type { EventBridgeStore } from "../eventbridge";

const ACCOUNT_ID = "000000000000";
const REGION = "us-east-1";

interface S3Object {
  key: string;
  body: Buffer;
  contentType: string;
  etag: string;
  lastModified: Date;
  size: number;
  metadata: Record<string, string>;
}

interface NotificationQueueConfig {
  queueArn: string;
  events: string[];
}

interface NotificationTopicConfig {
  topicArn: string;
  events: string[];
}

interface NotificationEventBridgeConfig {
  eventBusArn: string;
}

interface BucketNotificationConfig {
  queueConfigurations: NotificationQueueConfig[];
  topicConfigurations: NotificationTopicConfig[];
  eventBridgeConfiguration?: NotificationEventBridgeConfig;
}

interface S3Bucket {
  name: string;
  objects: Map<string, S3Object>;
  createdAt: Date;
  tags: Array<{ Key: string; Value: string }>;
  policy?: string;
  website?: { indexDocument: string };
  notificationConfig?: BucketNotificationConfig;
}

export class S3Store {
  private buckets: Map<string, S3Bucket> = new Map();
  // multipart parts: key = "uploadId#partNumber", value = Buffer
  private parts: Map<string, Buffer> = new Map();
  // active multipart uploads: uploadId -> { bucket, key, status }
  private uploads: Map<
    string,
    { bucket: string; key: string; status: "IN_PROGRESS" | "COMPLETED" | "ABORTED" }
  > = new Map();
  private snsStore: SnsStore | null = null;
  private sqsStore: SqsStore | null = null;
  private eventBridgeStore: EventBridgeStore | null = null;

  setSnsStore(snsStore: SnsStore): void {
    this.snsStore = snsStore;
  }

  setSqsStore(sqsStore: SqsStore): void {
    this.sqsStore = sqsStore;
  }

  setEventBridgeStore(store: EventBridgeStore): void {
    this.eventBridgeStore = store;
  }

  reset(): void {
    this.buckets.clear();
    this.parts.clear();
    this.uploads.clear();
  }

  hasActiveUpload(bucket: string, key: string): boolean {
    for (const u of this.uploads.values()) {
      if (u.bucket === bucket && u.key === key && u.status === "IN_PROGRESS") return true;
    }
    return false;
  }

  createUpload(bucket: string, key: string): string {
    const uploadId = uuidv4();
    this.uploads.set(uploadId, { bucket, key, status: "IN_PROGRESS" });
    return uploadId;
  }

  getUpload(
    uploadId: string,
  ): { bucket: string; key: string; status: "IN_PROGRESS" | "COMPLETED" | "ABORTED" } | undefined {
    return this.uploads.get(uploadId);
  }

  storePart(uploadId: string, partNumber: string, data: Buffer): string {
    const { createHash } = require("crypto") as typeof import("crypto");
    const etag = `"${createHash("md5").update(data).digest("hex")}"`;
    this.parts.set(`${uploadId}#${partNumber}`, data);
    return etag;
  }

  countParts(uploadId: string): number {
    let count = 0;
    for (const key of this.parts.keys()) {
      const [uid] = key.split("#");
      if (uid === uploadId) count++;
    }
    return count;
  }

  completeParts(uploadId: string): Buffer {
    // Gather all parts for this upload in order
    const partEntries: Array<{ num: number; data: Buffer }> = [];
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
    const upload = this.uploads.get(uploadId);
    if (upload) upload.status = "COMPLETED";
    return Buffer.concat(partEntries.map((e) => e.data));
  }

  abortUpload(uploadId: string): void {
    const upload = this.uploads.get(uploadId);
    if (upload) upload.status = "ABORTED";
    // Remove any parts for this upload
    for (const key of Array.from(this.parts.keys())) {
      const [uid] = key.split("#");
      if (uid === uploadId) this.parts.delete(key);
    }
  }

  createBucket(name: string): S3Bucket {
    if (this.buckets.has(name)) return this.buckets.get(name)!;
    const bucket: S3Bucket = { name, objects: new Map(), createdAt: new Date(), tags: [] };
    this.buckets.set(name, bucket);
    return bucket;
  }

  getBucketTags(name: string): Array<{ Key: string; Value: string }> {
    return this.buckets.get(name)?.tags ?? [];
  }

  setBucketTags(name: string, tags: Array<{ Key: string; Value: string }>): void {
    const bucket = this.buckets.get(name);
    if (bucket) bucket.tags = tags;
  }

  deleteBucketTags(name: string): void {
    const bucket = this.buckets.get(name);
    if (bucket) bucket.tags = [];
  }

  getBucketPolicy(name: string): string | undefined {
    return this.buckets.get(name)?.policy;
  }

  setBucketPolicy(name: string, policy: string): void {
    const bucket = this.buckets.get(name);
    if (bucket) bucket.policy = policy;
  }

  getBucketWebsite(name: string): { indexDocument: string } | undefined {
    return this.buckets.get(name)?.website;
  }

  setBucketWebsite(name: string, indexDocument: string): void {
    const bucket = this.buckets.get(name);
    if (bucket) bucket.website = { indexDocument };
  }

  deleteBucketWebsite(name: string): void {
    const bucket = this.buckets.get(name);
    if (bucket) delete bucket.website;
  }

  getBucketNotificationConfig(name: string): BucketNotificationConfig | undefined {
    return this.buckets.get(name)?.notificationConfig;
  }

  setBucketNotificationConfig(name: string, config: BucketNotificationConfig): void {
    const bucket = this.buckets.get(name);
    if (bucket) bucket.notificationConfig = config;
  }

  dispatchNotification(bucketName: string, eventName: string, key: string): void {
    const config = this.getBucketNotificationConfig(bucketName);
    if (!config) return;

    const eventPayload = JSON.stringify({
      Records: [
        {
          eventSource: "aws:s3",
          eventName,
          s3: {
            bucket: { name: bucketName },
            object: { key },
          },
        },
      ],
    });

    const wildcardEvent = eventName.startsWith("ObjectCreated")
      ? "s3:ObjectCreated:*"
      : "s3:ObjectRemoved:*";
    const specificEvent = `s3:${eventName}`;

    for (const queueCfg of config.queueConfigurations) {
      if (queueCfg.events.some((e) => e === wildcardEvent || e === specificEvent)) {
        if (this.sqsStore) {
          const queue = this.sqsStore.getQueue(queueCfg.queueArn);
          if (queue) {
            queue.sendMessage(eventPayload);
          }
        }
      }
    }

    for (const topicCfg of config.topicConfigurations) {
      if (topicCfg.events.some((e) => e === wildcardEvent || e === specificEvent)) {
        if (this.snsStore) {
          try {
            this.snsStore.publish(topicCfg.topicArn, eventPayload);
          } catch {
            // ignore if topic does not exist
          }
        }
      }
    }

    if (config.eventBridgeConfiguration && this.eventBridgeStore) {
      const busArn = config.eventBridgeConfiguration.eventBusArn;
      const busNameMatch = busArn.match(/event-bus\/(.+)$/);
      const busName = busNameMatch ? busNameMatch[1] : busArn;
      const s3EventEntry = {
        source: "aws.s3",
        "detail-type": "Object Created",
        detail: {
          bucket: { name: bucketName },
          object: { key },
        },
      };
      try {
        this.eventBridgeStore.putEventsInternal(busName, [s3EventEntry]);
      } catch {
        // ignore if bus does not exist
      }
    }
  }

  deleteBucket(name: string): void {
    this.buckets.delete(name);
  }

  getBucket(name: string): S3Bucket | undefined {
    return this.buckets.get(name);
  }

  listBuckets(): S3Bucket[] {
    return Array.from(this.buckets.values());
  }

  putObject(
    bucketName: string,
    key: string,
    body: Buffer,
    headers: Record<string, string>,
  ): S3Object {
    const bucket = this.buckets.get(bucketName);
    if (!bucket) throw new Error(`NoSuchBucket: ${bucketName}`);
    const { createHash } = require("crypto") as typeof import("crypto");
    const etag = `"${createHash("md5").update(body).digest("hex")}"`;
    const obj: S3Object = {
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

  getObject(bucketName: string, key: string): S3Object | undefined {
    return this.buckets.get(bucketName)?.objects.get(key);
  }

  deleteObject(bucketName: string, key: string): void {
    this.buckets.get(bucketName)?.objects.delete(key);
  }

  listObjects(
    bucketName: string,
    prefix?: string,
    delimiter?: string,
  ): {
    objects: S3Object[];
    prefixes: string[];
  } {
    const bucket = this.buckets.get(bucketName);
    if (!bucket) throw new Error(`NoSuchBucket: ${bucketName}`);

    const objects = Array.from(bucket.objects.values());
    let filtered = prefix ? objects.filter((o) => o.key.startsWith(prefix)) : objects;

    const prefixes = new Set<string>();
    if (delimiter) {
      const result: S3Object[] = [];
      for (const obj of filtered) {
        const keyAfterPrefix = prefix ? obj.key.slice(prefix.length) : obj.key;
        const delimIdx = keyAfterPrefix.indexOf(delimiter);
        if (delimIdx >= 0) {
          const commonPrefix = (prefix ?? "") + keyAfterPrefix.slice(0, delimIdx + 1);
          prefixes.add(commonPrefix);
        } else {
          result.push(obj);
        }
      }
      filtered = result;
    }

    return {
      objects: filtered.sort((a, b) => a.key.localeCompare(b.key)),
      prefixes: Array.from(prefixes),
    };
  }

  copyObject(srcBucket: string, srcKey: string, dstBucket: string, dstKey: string): S3Object {
    const src = this.getObject(srcBucket, srcKey);
    if (!src) throw new Error(`NoSuchKey: ${srcKey}`);
    return this.putObject(dstBucket, dstKey, src.body, { "content-type": src.contentType });
  }
}

function xmlReply(reply: FastifyReply, content: string, status = 200): void {
  reply
    .status(status)
    .header("Content-Type", "application/xml")
    .send(`<?xml version="1.0" encoding="UTF-8"?>${content}`);
}

function s3Error(reply: FastifyReply, code: string, message: string, status = 400): void {
  xmlReply(
    reply,
    `<Error><Code>${code}</Code><Message>${message}</Message><RequestId>${uuidv4()}</RequestId></Error>`,
    status,
  );
}

export function registerS3(app: FastifyInstance, state: ServerState): S3Store {
  const store = new S3Store();
  state.resetCallbacks.push(() => store.reset());

  // S3 uses path-style routing: /{bucket}/{key}
  // We need raw body for object uploads
  app.addContentTypeParser("*", { parseAs: "buffer" }, (_req, body, done) => {
    done(null, body);
  });

  // Global IAM auth check for all S3 requests — return XML since S3 uses XML wire protocol
  app.addHook("preHandler", async (req: FastifyRequest, reply: FastifyReply) => {
    if (await applyIamAuth(state, "s3", "s3-operation", req, reply, true)) {
      return reply;
    }
  });

  // List all buckets: GET /
  app.get("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("s3", "ListBuckets");
    if (await applyChaos(state, "s3", "ListBuckets", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3", "ListBuckets", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const buckets = store.listBuckets();
    const bucketsXml = buckets
      .map(
        (b) =>
          `<Bucket><Name>${b.name}</Name><CreationDate>${b.createdAt.toISOString()}</CreationDate></Bucket>`,
      )
      .join("");
    xmlReply(
      reply,
      `<ListAllMyBucketsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Owner><ID>${ACCOUNT_ID}</ID><DisplayName>test</DisplayName></Owner>
  <Buckets>${bucketsXml}</Buckets>
</ListAllMyBucketsResult>`,
    );
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // Bucket-level operations: PUT /{bucket}, DELETE /{bucket}, GET /{bucket}?...
  app.put("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3", "CreateBucket");
    if (await applyChaos(state, "s3", "CreateBucket", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (store.getBucket(bucket)) {
      s3Error(
        reply,
        "BucketAlreadyOwnedByYou",
        "Your previous request to create the named bucket succeeded and you already own it.",
        409,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    store.createBucket(bucket);
    reply.status(200).header("Location", `/${bucket}`).send("");
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const ctx = createRequestContext("s3", "DeleteBucket");
    const bucketObj = store.getBucket(bucket);
    if (!bucketObj) {
      s3Error(reply, "NoSuchBucket", "The specified bucket does not exist", 404);
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (bucketObj.objects.size > 0) {
      s3Error(reply, "BucketNotEmpty", "The bucket you tried to delete is not empty", 409);
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    store.deleteBucket(bucket);
    reply.status(204).send();
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const query = req.query as Record<string, string>;
    const ctx = createRequestContext("s3", "ListObjectsV2");

    if (await applyChaos(state, "s3", "ListObjectsV2", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3", "ListObjectsV2", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      const { objects, prefixes } = store.listObjects(bucket, query.prefix, query.delimiter);
      const maxKeys = parseInt(query["max-keys"] ?? "1000", 10);
      const truncated = objects.length > maxKeys;
      const sliced = objects.slice(0, maxKeys);

      const objectsXml = sliced
        .map(
          (o) =>
            `<Contents>
  <Key>${escapeXml(o.key)}</Key>
  <LastModified>${o.lastModified.toISOString()}</LastModified>
  <ETag>${o.etag}</ETag>
  <Size>${o.size}</Size>
  <StorageClass>STANDARD</StorageClass>
</Contents>`,
        )
        .join("");

      const prefixesXml = prefixes
        .map((p) => `<CommonPrefixes><Prefix>${escapeXml(p)}</Prefix></CommonPrefixes>`)
        .join("");

      xmlReply(
        reply,
        `<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Name>${bucket}</Name>
  <Prefix>${escapeXml(query.prefix ?? "")}</Prefix>
  <MaxKeys>${maxKeys}</MaxKeys>
  <IsTruncated>${truncated}</IsTruncated>
  <KeyCount>${sliced.length}</KeyCount>
  ${objectsXml}
  ${prefixesXml}
</ListBucketResult>`,
      );
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      s3Error(reply, "NoSuchBucket", msg, 404);
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // Object-level operations: GET/PUT/DELETE /{bucket}/{key*}
  app.put("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const bucket = params.bucket;
    const key = params["*"];

    // Bucket-level PUT operations when key is empty (SDK sends PUT /bucket/?tagging etc.)
    if (!key || key === "") {
      const query = req.query as Record<string, string>;

      if ("tagging" in query) {
        // PutBucketTagging: parse XML body
        const ctx = createRequestContext("s3", "PutBucketTagging");
        const bodyBuf = (req.body as Buffer) ?? Buffer.alloc(0);
        const bodyStr = bodyBuf.toString();
        const tagMatches = [
          ...bodyStr.matchAll(/<Tag>\s*<Key>([^<]+)<\/Key>\s*<Value>([^<]*)<\/Value>\s*<\/Tag>/g),
        ];
        const tags = tagMatches.map((m) => ({ Key: m[1], Value: m[2] }));
        store.setBucketTags(bucket, tags);
        reply.status(200).send("");
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      if ("policy" in query) {
        // PutBucketPolicy
        const ctx = createRequestContext("s3", "PutBucketPolicy");
        const bodyBuf = (req.body as Buffer) ?? Buffer.alloc(0);
        store.setBucketPolicy(bucket, bodyBuf.toString());
        reply.status(200).send("");
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      if ("notification" in query) {
        // PutBucketNotificationConfiguration
        const ctx = createRequestContext("s3", "PutBucketNotificationConfiguration");
        const bodyBuf = (req.body as Buffer) ?? Buffer.alloc(0);
        const bodyStr = bodyBuf.toString();
        const queueConfigurations: NotificationQueueConfig[] = [];
        const queueMatches = [
          ...bodyStr.matchAll(
            /<QueueConfiguration>[\s\S]*?<Queue>([^<]+)<\/Queue>[\s\S]*?<Event>([^<]+)<\/Event>[\s\S]*?<\/QueueConfiguration>/g,
          ),
        ];
        for (const m of queueMatches) {
          queueConfigurations.push({ queueArn: m[1], events: [m[2]] });
        }
        const topicConfigurations: NotificationTopicConfig[] = [];
        const topicMatches = [
          ...bodyStr.matchAll(
            /<TopicConfiguration>[\s\S]*?<Topic>([^<]+)<\/Topic>[\s\S]*?<Event>([^<]+)<\/Event>[\s\S]*?<\/TopicConfiguration>/g,
          ),
        ];
        for (const m of topicMatches) {
          topicConfigurations.push({ topicArn: m[1], events: [m[2]] });
        }
        let eventBridgeConfiguration: NotificationEventBridgeConfig | undefined;
        const ebMatch =
          /<EventBridgeConfiguration>\s*<EventBusArn>([^<]+)<\/EventBusArn>\s*<\/EventBridgeConfiguration>/.exec(
            bodyStr,
          );
        if (ebMatch) {
          eventBridgeConfiguration = { eventBusArn: ebMatch[1] };
        }
        store.setBucketNotificationConfig(bucket, {
          queueConfigurations,
          topicConfigurations,
          eventBridgeConfiguration,
        });
        reply.status(200).send("");
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      if ("website" in query) {
        // PutBucketWebsite: parse XML body
        const ctx = createRequestContext("s3", "PutBucketWebsite");
        const bodyBuf = (req.body as Buffer) ?? Buffer.alloc(0);
        const bodyStr = bodyBuf.toString();
        const suffixMatch = /<Suffix>([^<]+)<\/Suffix>/.exec(bodyStr);
        const indexDoc = suffixMatch ? suffixMatch[1] : "index.html";
        store.setBucketWebsite(bucket, indexDoc);
        reply.status(200).send("");
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      if ("versioning" in query) {
        // PutBucketVersioning: check bucket exists
        const ctx = createRequestContext("s3", "PutBucketVersioning");
        if (!store.getBucket(bucket)) {
          s3Error(reply, "NoSuchBucket", "The specified bucket does not exist", 404);
          recordLog(state, ctx, req.method, req.url, reply.statusCode);
          return;
        }
        reply.status(200).send("");
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      if (
        "acl" in query ||
        "cors" in query ||
        "accelerate" in query ||
        "logging" in query ||
        "replication" in query ||
        "lifecycle" in query ||
        "encryption" in query ||
        "ownershipControls" in query ||
        "publicAccessBlock" in query
      ) {
        // No-op bucket configuration PUT operations
        reply.status(200).send("");
        return;
      }

      // SDK sends PUT /bucket/ (trailing slash) for CreateBucket — treat empty key as bucket creation
      const ctx = createRequestContext("s3", "CreateBucket");
      if (await applyChaos(state, "s3", "CreateBucket", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (store.getBucket(bucket)) {
        s3Error(
          reply,
          "BucketAlreadyOwnedByYou",
          "Your previous request to create the named bucket succeeded and you already own it.",
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      store.createBucket(bucket);
      reply.status(200).header("Location", `/${bucket}`).send("");
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const query = req.query as Record<string, string>;

    // UploadPart: PUT /:bucket/:key?partNumber=N&uploadId=...
    if ("partNumber" in query && "uploadId" in query) {
      const ctx = createRequestContext("s3", "UploadPart");
      if (await applyChaos(state, "s3", "UploadPart", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const partBody = (req.body as Buffer) ?? Buffer.alloc(0);
      const etag = store.storePart(query.uploadId, query.partNumber, partBody);
      reply.status(200).header("ETag", etag).send("");
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const ctx = createRequestContext("s3", "PutObject");

    if (await applyChaos(state, "s3", "PutObject", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3", "PutObject", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    // Check if this is a copy operation
    const copySource = req.headers["x-amz-copy-source"] as string | undefined;
    if (copySource) {
      const decoded = decodeURIComponent(
        copySource.startsWith("/") ? copySource.slice(1) : copySource,
      );
      const slashIdx = decoded.indexOf("/");
      const srcBucket = decoded.slice(0, slashIdx);
      const srcKey = decoded.slice(slashIdx + 1);
      try {
        const obj = store.copyObject(srcBucket, srcKey, bucket, key);
        reply
          .status(200)
          .header("Content-Type", "application/xml")
          .send(
            `<?xml version="1.0"?><CopyObjectResult><ETag>${obj.etag}</ETag><LastModified>${obj.lastModified.toISOString()}</LastModified></CopyObjectResult>`,
          );
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        s3Error(reply, "NoSuchKey", msg, 404);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      const body = (req.body as Buffer) ?? Buffer.alloc(0);
      const obj = store.putObject(bucket, key, body, req.headers as Record<string, string>);
      reply.status(200).header("ETag", obj.etag).send("");
      store.dispatchNotification(bucket, "ObjectCreated:Put", key);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      s3Error(reply, "NoSuchBucket", msg, 404);
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const bucket = params.bucket;
    const key = params["*"];
    const query = req.query as Record<string, string>;

    // Bucket-level operations when key is empty (SDK sends GET /bucket/)
    if (!key || key === "") {
      // Handle bucket-level query operations
      if ("location" in query) {
        const ctx = createRequestContext("s3", "GetBucketLocation");
        xmlReply(reply, `<LocationConstraint xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if ("tagging" in query) {
        const ctx = createRequestContext("s3", "GetBucketTagging");
        const tags = store.getBucketTags(bucket);
        const tagsXml = tags
          .map(
            (t) => `<Tag><Key>${escapeXml(t.Key)}</Key><Value>${escapeXml(t.Value)}</Value></Tag>`,
          )
          .join("");
        xmlReply(
          reply,
          `<Tagging xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><TagSet>${tagsXml}</TagSet></Tagging>`,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if ("policy" in query) {
        const ctx = createRequestContext("s3", "GetBucketPolicy");
        const policy = store.getBucketPolicy(bucket);
        if (!policy) {
          s3Error(reply, "NoSuchBucketPolicy", `The bucket policy does not exist: ${bucket}`, 404);
        } else {
          reply.status(200).header("Content-Type", "application/json").send(policy);
        }
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if ("notification" in query) {
        const ctx = createRequestContext("s3", "GetBucketNotificationConfiguration");
        const notifConfig = store.getBucketNotificationConfig(bucket);
        if (!notifConfig) {
          xmlReply(
            reply,
            `<NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`,
          );
        } else {
          const queueXml = notifConfig.queueConfigurations
            .map(
              (q) =>
                `<QueueConfiguration><Queue>${escapeXml(q.queueArn)}</Queue>${q.events.map((e) => `<Event>${escapeXml(e)}</Event>`).join("")}</QueueConfiguration>`,
            )
            .join("");
          const topicXml = notifConfig.topicConfigurations
            .map(
              (t) =>
                `<TopicConfiguration><Topic>${escapeXml(t.topicArn)}</Topic>${t.events.map((e) => `<Event>${escapeXml(e)}</Event>`).join("")}</TopicConfiguration>`,
            )
            .join("");
          const ebXml = notifConfig.eventBridgeConfiguration
            ? `<EventBridgeConfiguration><EventBusArn>${escapeXml(notifConfig.eventBridgeConfiguration.eventBusArn)}</EventBusArn></EventBridgeConfiguration>`
            : "";
          xmlReply(
            reply,
            `<NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">${queueXml}${topicXml}${ebXml}</NotificationConfiguration>`,
          );
        }
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if ("website" in query) {
        const ctx = createRequestContext("s3", "GetBucketWebsite");
        const website = store.getBucketWebsite(bucket);
        if (!website) {
          s3Error(
            reply,
            "NoSuchWebsiteConfiguration",
            `The specified bucket does not have a website configuration: ${bucket}`,
            404,
          );
        } else {
          xmlReply(
            reply,
            `<WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><IndexDocument><Suffix>${escapeXml(website.indexDocument)}</Suffix></IndexDocument></WebsiteConfiguration>`,
          );
        }
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (
        "acl" in query ||
        "cors" in query ||
        "versioning" in query ||
        "accelerate" in query ||
        "requestPayment" in query ||
        "logging" in query ||
        "replication" in query ||
        "lifecycle" in query ||
        "encryption" in query ||
        "ownershipControls" in query ||
        "publicAccessBlock" in query ||
        "intelligentTieringConfiguration" in query
      ) {
        // No-op bucket configuration operations - return empty/default response
        xmlReply(reply, `<Empty xmlns="http://s3.amazonaws.com/doc/2006-03-01/"/>`);
        return;
      }
      // Default: ListObjectsV2
      const ctx = createRequestContext("s3", "ListObjectsV2");
      if (await applyChaos(state, "s3", "ListObjectsV2", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyFake(state, "s3", "ListObjectsV2", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      try {
        const { objects, prefixes } = store.listObjects(bucket, query.prefix, query.delimiter);
        const maxKeys = parseInt(query["max-keys"] ?? "1000", 10);
        const truncated = objects.length > maxKeys;
        const sliced = objects.slice(0, maxKeys);
        const objectsXml = sliced
          .map(
            (o) =>
              `<Contents><Key>${escapeXml(o.key)}</Key><LastModified>${o.lastModified.toISOString()}</LastModified><ETag>${o.etag}</ETag><Size>${o.size}</Size><StorageClass>STANDARD</StorageClass></Contents>`,
          )
          .join("");
        const prefixesXml = prefixes
          .map((p) => `<CommonPrefixes><Prefix>${escapeXml(p)}</Prefix></CommonPrefixes>`)
          .join("");
        xmlReply(
          reply,
          `<ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Name>${bucket}</Name><Prefix>${escapeXml(query.prefix ?? "")}</Prefix><MaxKeys>${maxKeys}</MaxKeys><IsTruncated>${truncated}</IsTruncated><KeyCount>${sliced.length}</KeyCount>${objectsXml}${prefixesXml}</ListBucketResult>`,
        );
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        s3Error(reply, "NoSuchBucket", msg, 404);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    // ListParts: GET /:bucket/:key?uploadId=...
    if ("uploadId" in query) {
      const ctx = createRequestContext("s3", "ListParts");
      if (await applyChaos(state, "s3", "ListParts", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      xmlReply(
        reply,
        `<ListPartsResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <UploadId>${query.uploadId}</UploadId>
  <IsTruncated>false</IsTruncated>
</ListPartsResult>`,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const ctx = createRequestContext("s3", "GetObject");

    if (await applyChaos(state, "s3", "GetObject", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "s3", "GetObject", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const obj = store.getObject(bucket, key);
    if (!obj) {
      s3Error(reply, "NoSuchKey", `The specified key does not exist: ${key}`, 404);
    } else {
      reply
        .status(200)
        .header("Content-Type", obj.contentType)
        .header("ETag", obj.etag)
        .header("Last-Modified", obj.lastModified.toUTCString())
        .header("Content-Length", String(obj.size))
        .send(obj.body);
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const bucket = params.bucket;
    const key = params["*"];
    const query = req.query as Record<string, string>;

    // Bucket-level DELETE operations when key is empty
    if (!key || key === "") {
      if ("tagging" in query) {
        const ctx = createRequestContext("s3", "DeleteBucketTagging");
        store.deleteBucketTags(bucket);
        reply.status(204).send();
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if ("website" in query) {
        const ctx = createRequestContext("s3", "DeleteBucketWebsite");
        store.deleteBucketWebsite(bucket);
        reply.status(204).send();
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (
        "policy" in query ||
        "cors" in query ||
        "lifecycle" in query ||
        "replication" in query ||
        "encryption" in query ||
        "ownershipControls" in query ||
        "publicAccessBlock" in query
      ) {
        reply.status(204).send();
        return;
      }
      // DeleteBucket with trailing slash
      const ctx = createRequestContext("s3", "DeleteBucket");
      const bucketObjTrailing = store.getBucket(bucket);
      if (!bucketObjTrailing) {
        s3Error(reply, "NoSuchBucket", "The specified bucket does not exist", 404);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (bucketObjTrailing.objects.size > 0) {
        s3Error(reply, "BucketNotEmpty", "The bucket you tried to delete is not empty", 409);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      store.deleteBucket(bucket);
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    // AbortMultipartUpload: DELETE /:bucket/:key?uploadId=...
    if ("uploadId" in query) {
      const ctx = createRequestContext("s3", "AbortMultipartUpload");
      const upload = store.getUpload(query.uploadId);
      if (!upload || upload.status !== "IN_PROGRESS") {
        s3Error(reply, "NoSuchUpload", "The specified upload does not exist", 404);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      store.abortUpload(query.uploadId);
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const ctx = createRequestContext("s3", "DeleteObject");

    if (!store.getBucket(bucket)) {
      s3Error(reply, "NoSuchBucket", "The specified bucket does not exist", 404);
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (!store.getObject(bucket, key)) {
      s3Error(reply, "NoSuchKey", "The specified key does not exist", 404);
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    store.deleteObject(bucket, key);
    reply.status(204).send();
    store.dispatchNotification(bucket, "ObjectRemoved:Delete", key);

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.head("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const bucket = params.bucket;
    const key = params["*"];

    // HeadBucket: HEAD /bucket/ with empty key
    if (!key || key === "") {
      const bucketObj = store.getBucket(bucket);
      if (!bucketObj) {
        reply.status(404).send();
      } else {
        reply.status(200).send();
      }
      return;
    }

    const obj = store.getObject(bucket, key);
    if (!obj) {
      reply.status(404).send();
    } else {
      reply
        .status(200)
        .header("Content-Type", obj.contentType)
        .header("ETag", obj.etag)
        .header("Content-Length", String(obj.size))
        .send();
    }
  });

  // Multipart upload operations: POST /:bucket/:key?uploads or POST /:bucket/:key?uploadId=...
  app.post("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const bucket = params.bucket;
    const key = params["*"];
    const query = req.query as Record<string, string>;

    // DeleteObjects: POST /:bucket/?delete (empty key with trailing slash)
    if ((!key || key === "") && "delete" in query) {
      const ctx = createRequestContext("s3", "DeleteObjects");
      const body = req.body;
      const bodyStr = Buffer.isBuffer(body) ? body.toString() : String(body ?? "");
      const keyMatches = [...bodyStr.matchAll(/<Key>([^<]+)<\/Key>/g)];
      const deleted: string[] = [];
      for (const match of keyMatches) {
        const objKey = match[1];
        store.deleteObject(bucket, objKey);
        deleted.push(objKey);
      }
      const deletedXml = deleted
        .map((k) => `<Deleted><Key>${escapeXml(k)}</Key></Deleted>`)
        .join("");
      xmlReply(
        reply,
        `<DeleteResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">${deletedXml}</DeleteResult>`,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    if ("uploads" in query) {
      // CreateMultipartUpload
      const ctx = createRequestContext("s3", "CreateMultipartUpload");
      if (await applyChaos(state, "s3", "CreateMultipartUpload", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyFake(state, "s3", "CreateMultipartUpload", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (!store.getBucket(bucket)) {
        s3Error(reply, "NoSuchBucket", "The specified bucket does not exist", 404);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (store.hasActiveUpload(bucket, key)) {
        s3Error(
          reply,
          "MultipartUploadAlreadyExists",
          "An active multipart upload already exists for this key",
          409,
        );
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const uploadId = store.createUpload(bucket, key);
      xmlReply(
        reply,
        `<InitiateMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <UploadId>${uploadId}</UploadId>
</InitiateMultipartUploadResult>`,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    if ("uploadId" in query) {
      // CompleteMultipartUpload
      const ctx = createRequestContext("s3", "CompleteMultipartUpload");
      if (await applyChaos(state, "s3", "CompleteMultipartUpload", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyFake(state, "s3", "CompleteMultipartUpload", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const upload = store.getUpload(query.uploadId);
      if (!upload || upload.status !== "IN_PROGRESS") {
        s3Error(reply, "NoSuchUpload", "The specified upload does not exist", 404);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (store.countParts(query.uploadId) === 0) {
        s3Error(reply, "InvalidPart", "One or more of the specified parts could not be found", 400);
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      try {
        const combinedBody = store.completeParts(query.uploadId);
        store.putObject(bucket, key, combinedBody, {});
      } catch {
        // ignore
      }
      const location = `http://127.0.0.1/${bucket}/${key}`;
      xmlReply(
        reply,
        `<CompleteMultipartUploadResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <Location>${location}</Location>
  <Bucket>${bucket}</Bucket>
  <Key>${escapeXml(key)}</Key>
  <ETag>"${uuidv4().replace(/-/g, "")}"</ETag>
</CompleteMultipartUploadResult>`,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    reply.status(400).send();
  });

  // Delete objects batch
  app.post("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const query = req.query as Record<string, string>;

    if ("delete" in query) {
      const ctx = createRequestContext("s3", "DeleteObjects");
      // Parse XML body for delete operation
      const body = req.body;
      const bodyStr = Buffer.isBuffer(body) ? body.toString() : String(body ?? "");
      const keyMatches = [...bodyStr.matchAll(/<Key>([^<]+)<\/Key>/g)];
      const deleted: string[] = [];
      for (const match of keyMatches) {
        const key = match[1];
        store.deleteObject(bucket, key);
        deleted.push(key);
      }
      const deletedXml = deleted
        .map((k) => `<Deleted><Key>${escapeXml(k)}</Key></Deleted>`)
        .join("");
      xmlReply(
        reply,
        `<DeleteResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">${deletedXml}</DeleteResult>`,
      );
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    reply.status(400).send();
  });

  void ACCOUNT_ID;
  void REGION;

  return store;
}

function escapeXml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}
