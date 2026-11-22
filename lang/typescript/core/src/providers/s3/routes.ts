import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { makeLoggingHooks } from "../_shared/logging.js";
import type { S3Provider } from "./provider.js";

export interface S3RoutesOptions {
  provider: S3Provider;
}

function errorXml(code: string, message: string): string {
  return `<?xml version="1.0" encoding="UTF-8"?><Error><Code>${code}</Code><Message>${message}</Message></Error>`;
}

function toRfc7231(isoOrRfc: string): string {
  return new Date(isoOrRfc).toUTCString();
}

function escapeXml(s: string): string {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
}

function parseDeleteObjectsXml(xml: string): string[] {
  const keys: string[] = [];
  const keyRegex = /<Key>([^<]*)<\/Key>/g;
  let m: RegExpExecArray | null;
  while ((m = keyRegex.exec(xml)) !== null) {
    if (m[1] !== undefined) keys.push(m[1]);
  }
  return keys;
}

function parseCopySource(copySource: string): { bucket: string; key: string } {
  const cleaned = copySource.startsWith("/") ? copySource.slice(1) : copySource;
  const idx = cleaned.indexOf("/");
  if (idx === -1) return { bucket: cleaned, key: "" };
  return { bucket: cleaned.slice(0, idx), key: cleaned.slice(idx + 1) };
}

export async function s3RoutesPlugin(
  fastify: FastifyInstance,
  opts: S3RoutesOptions,
): Promise<void> {
  const { provider } = opts;

  fastify.addContentTypeParser("*", { parseAs: "buffer" }, (_req, body, done) => {
    done(null, body as Buffer);
  });

  const { onRequest, onResponse } = makeLoggingHooks("s3");
  fastify.addHook("onRequest", onRequest);
  fastify.addHook("onResponse", onResponse);

  fastify.get("/", async (_req: FastifyRequest, reply: FastifyReply) => {
    const buckets = provider.listBuckets();
    const bucketsXml = buckets
      .map((b) => `<Bucket><Name>${escapeXml(b.Name)}</Name><CreationDate>${escapeXml(b.CreationDate)}</CreationDate></Bucket>`)
      .join("");
    return reply
      .status(200)
      .header("content-type", "application/xml")
      .send(`<?xml version="1.0" encoding="UTF-8"?><ListAllMyBucketsResult><Buckets>${bucketsXml}</Buckets></ListAllMyBucketsResult>`);
  });

  fastify.put("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    try {
      provider.createBucket(bucket);
      return reply.status(200).header("content-type", "application/xml").send("");
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      return reply.status(409).header("content-type", "application/xml").send(errorXml("BucketAlreadyExists", msg));
    }
  });

  fastify.delete("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    try {
      provider.deleteBucket(bucket);
      return reply.status(204).send("");
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      const code = msg.startsWith("NoSuchBucket") ? "NoSuchBucket" : "BucketNotEmpty";
      const status = code === "NoSuchBucket" ? 404 : 409;
      return reply.status(status).header("content-type", "application/xml").send(errorXml(code, msg));
    }
  });

  fastify.get("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const query = req.query as Record<string, string>;
    const prefix = query["prefix"];
    const maxKeysStr = query["max-keys"];
    const maxKeys = maxKeysStr !== undefined ? parseInt(maxKeysStr, 10) : undefined;
    try {
      const result = provider.listObjectsV2(bucket, prefix, undefined, maxKeys);
      const contentsXml = result.Contents.map(
        (o) =>
          `<Contents><Key>${escapeXml(o.Key)}</Key><Size>${o.Size}</Size><ETag>${escapeXml(o.ETag)}</ETag><LastModified>${o.LastModified}</LastModified></Contents>`,
      ).join("");
      return reply
        .status(200)
        .header("content-type", "application/xml")
        .send(`<?xml version="1.0" encoding="UTF-8"?><ListBucketResult><Name>${escapeXml(bucket)}</Name><KeyCount>${result.KeyCount}</KeyCount><IsTruncated>false</IsTruncated>${contentsXml}</ListBucketResult>`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      return reply.status(404).header("content-type", "application/xml").send(errorXml("NoSuchBucket", msg));
    }
  });

  fastify.post("/:bucket", async (req: FastifyRequest, reply: FastifyReply) => {
    const { bucket } = req.params as { bucket: string };
    const query = req.query as Record<string, string>;
    if ("delete" in query) {
      const bodyBuf = req.body as Buffer;
      const xml = bodyBuf.toString("utf-8");
      const keys = parseDeleteObjectsXml(xml);
      const result = provider.deleteObjects(bucket, keys);
      const deletedXml = result.Deleted.map((d) => `<Deleted><Key>${escapeXml(d.Key)}</Key></Deleted>`).join("");
      return reply
        .status(200)
        .header("content-type", "application/xml")
        .send(`<?xml version="1.0" encoding="UTF-8"?><DeleteResult>${deletedXml}</DeleteResult>`);
    }
    return reply.status(400).header("content-type", "application/xml").send(errorXml("InvalidRequest", "Unsupported POST"));
  });

  fastify.put("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const { bucket } = params;
    const key = params["*"];
    const copySource = req.headers["x-amz-copy-source"] as string | undefined;
    if (copySource !== undefined) {
      const src = parseCopySource(copySource);
      try {
        const result = provider.copyObject(bucket, key, src.bucket, src.key);
        return reply
          .status(200)
          .header("content-type", "application/xml")
          .send(`<?xml version="1.0" encoding="UTF-8"?><CopyObjectResult><ETag>${escapeXml(result.ETag)}</ETag><LastModified>${result.LastModified}</LastModified></CopyObjectResult>`);
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        return reply.status(404).header("content-type", "application/xml").send(errorXml("NoSuchKey", msg));
      }
    }
    const body = req.body as Buffer;
    const contentType = (req.headers["content-type"] as string | undefined) ?? "application/octet-stream";
    try {
      const etag = provider.putObject(bucket, key, body, contentType);
      return reply.status(200).header("etag", etag).send("");
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      return reply.status(404).header("content-type", "application/xml").send(errorXml("NoSuchBucket", msg));
    }
  });

  fastify.get("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const { bucket } = params;
    const key = params["*"];
    try {
      const obj = provider.getObject(bucket, key);
      return reply
        .status(200)
        .header("content-type", obj.ContentType)
        .header("etag", obj.ETag)
        .header("content-length", String(obj.ContentLength))
        .header("last-modified", toRfc7231(obj.LastModified))
        .send(obj.Body);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      const code = msg.startsWith("NoSuchBucket") ? "NoSuchBucket" : "NoSuchKey";
      return reply.status(404).header("content-type", "application/xml").send(errorXml(code, msg));
    }
  });

  fastify.head("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const { bucket } = params;
    const key = params["*"];
    try {
      const meta = provider.headObject(bucket, key);
      return reply
        .status(200)
        .header("content-type", meta.ContentType)
        .header("etag", meta.ETag)
        .header("content-length", String(meta.ContentLength))
        .header("last-modified", toRfc7231(meta.LastModified))
        .send("");
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      return reply.status(404).header("content-type", "application/xml").send(errorXml("NoSuchKey", msg));
    }
  });

  fastify.delete("/:bucket/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const params = req.params as { bucket: string; "*": string };
    const { bucket } = params;
    const key = params["*"];
    provider.deleteObject(bucket, key);
    return reply.status(204).send("");
  });
}
