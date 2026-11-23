import type { IProvider } from "../../interfaces/provider.js";
import { createHash } from "crypto";
import { mkdirSync, rmSync, existsSync, readdirSync, statSync, readFileSync, writeFileSync, mkdtempSync } from "fs";
import { join, dirname } from "path";
import { tmpdir } from "os";

export interface BucketConfig {
  name: string;
}

interface ObjectMeta {
  ContentType: string;
  ETag: string;
  ContentLength: number;
  LastModified: string;
}

export interface ObjectInfo {
  Key: string;
  Size: number;
  ETag: string;
  LastModified: string;
}

interface MultipartUpload {
  bucket: string;
  key: string;
  contentType: string;
  parts: Map<number, Buffer>;
}

export class S3Provider implements IProvider {
  readonly name = "s3";

  private _baseDir: string;
  private _preconfiguredNames: ReadonlySet<string>;
  private _buckets = new Set<string>();
  private _creationDates = new Map<string, string>();
  private _uploads = new Map<string, MultipartUpload>();
  private _running = false;

  constructor(private readonly configs: BucketConfig[] = []) {
    this._baseDir = "";
    this._preconfiguredNames = new Set(configs.map((c) => c.name));
  }

  async start(): Promise<void> {
    this._baseDir = mkdtempSync(join(tmpdir(), "lws-s3-"));
    for (const c of this.configs) {
      this._mkBucketDir(c.name);
      this._buckets.add(c.name);
      this._creationDates.set(c.name, new Date().toISOString());
    }
    this._running = true;
  }

  async stop(): Promise<void> {
    if (this._baseDir !== "" && existsSync(this._baseDir)) {
      rmSync(this._baseDir, { recursive: true, force: true });
    }
    this._buckets.clear();
    this._creationDates.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const name of [...this._buckets]) {
      if (!this._preconfiguredNames.has(name)) {
        rmSync(join(this._baseDir, name), { recursive: true, force: true });
        this._buckets.delete(name);
        this._creationDates.delete(name);
      } else {
        const bucketDir = join(this._baseDir, name);
        const metaDir = join(bucketDir, ".meta");
        for (const f of this._listObjects(name)) {
          rmSync(join(bucketDir, f.Key), { force: true });
          rmSync(join(metaDir, `${f.Key}.json`), { force: true });
        }
      }
    }
  }

  createBucket(name: string): void {
    if (this._buckets.has(name)) throw new Error(`BucketAlreadyExists: Bucket ${name} already exists`);
    this._mkBucketDir(name);
    this._buckets.add(name);
    this._creationDates.set(name, new Date().toISOString());
  }

  deleteBucket(name: string): void {
    if (!this._buckets.has(name)) throw new Error(`NoSuchBucket: Bucket ${name} does not exist`);
    if (this._listObjects(name).length > 0) throw new Error(`BucketNotEmpty: Bucket ${name} is not empty`);
    rmSync(join(this._baseDir, name), { recursive: true, force: true });
    this._buckets.delete(name);
    this._creationDates.delete(name);
  }

  listBuckets(): Array<{ Name: string; CreationDate: string }> {
    return [...this._buckets].sort().map((n) => ({ Name: n, CreationDate: this._creationDates.get(n) ?? "" }));
  }

  putObject(bucket: string, key: string, body: Buffer, contentType?: string): string {
    if (!this._buckets.has(bucket)) throw new Error(`NoSuchBucket: Bucket ${bucket} does not exist`);
    const objPath = join(this._baseDir, bucket, key);
    mkdirSync(dirname(objPath), { recursive: true });
    writeFileSync(objPath, body);
    const etag = `"${createHash("md5").update(body).digest("hex")}"`;
    const meta: ObjectMeta = {
      ContentType: contentType ?? "application/octet-stream",
      ETag: etag,
      ContentLength: body.length,
      LastModified: new Date().toISOString(),
    };
    const metaPath = join(this._baseDir, bucket, ".meta", `${key}.json`);
    mkdirSync(dirname(metaPath), { recursive: true });
    writeFileSync(metaPath, JSON.stringify(meta));
    return etag;
  }

  getObject(bucket: string, key: string): { Body: Buffer; ContentType: string; ETag: string; ContentLength: number; LastModified: string } {
    if (!this._buckets.has(bucket)) throw new Error(`NoSuchBucket: Bucket ${bucket} does not exist`);
    const objPath = join(this._baseDir, bucket, key);
    if (!existsSync(objPath)) throw new Error(`NoSuchKey: Key ${key} does not exist in bucket ${bucket}`);
    const body = readFileSync(objPath);
    const meta = this._readMeta(bucket, key);
    return { Body: body, ...meta };
  }

  deleteObject(bucket: string, key: string): void {
    if (!this._buckets.has(bucket)) return;
    const objPath = join(this._baseDir, bucket, key);
    if (existsSync(objPath)) rmSync(objPath);
    const metaPath = join(this._baseDir, bucket, ".meta", `${key}.json`);
    if (existsSync(metaPath)) rmSync(metaPath);
  }

  deleteObjects(bucket: string, keys: string[]): { Deleted: Array<{ Key: string }>; Errors: unknown[] } {
    const Deleted: Array<{ Key: string }> = [];
    for (const key of keys) {
      this.deleteObject(bucket, key);
      Deleted.push({ Key: key });
    }
    return { Deleted, Errors: [] };
  }

  listObjectsV2(bucket: string, prefix?: string, _delimiter?: string, maxKeys?: number): {
    Contents: ObjectInfo[];
    IsTruncated: boolean;
    KeyCount: number;
  } {
    if (!this._buckets.has(bucket)) throw new Error(`NoSuchBucket: Bucket ${bucket} does not exist`);
    let items = this._listObjects(bucket);
    if (prefix !== undefined && prefix !== "") items = items.filter((i) => i.Key.startsWith(prefix));
    if (maxKeys !== undefined) items = items.slice(0, maxKeys);
    return { Contents: items, IsTruncated: false, KeyCount: items.length };
  }

  headObject(bucket: string, key: string): ObjectMeta {
    if (!this._buckets.has(bucket)) throw new Error(`NoSuchBucket: Bucket ${bucket} does not exist`);
    const objPath = join(this._baseDir, bucket, key);
    if (!existsSync(objPath)) throw new Error(`NoSuchKey: Key ${key} does not exist in bucket ${bucket}`);
    return this._readMeta(bucket, key);
  }

  copyObject(bucket: string, key: string, sourceBucket: string, sourceKey: string): { ETag: string; LastModified: string } {
    const src = this.getObject(sourceBucket, sourceKey);
    const etag = this.putObject(bucket, key, src.Body, src.ContentType);
    return { ETag: etag, LastModified: new Date().toISOString() };
  }

  headBucket(name: string): boolean {
    return this._buckets.has(name);
  }

  createMultipartUpload(bucket: string, key: string, contentType?: string): string {
    if (!this._buckets.has(bucket)) throw new Error(`NoSuchBucket: Bucket ${bucket} does not exist`);
    const uploadId = `upload-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`;
    this._uploads.set(uploadId, { bucket, key, contentType: contentType ?? "application/octet-stream", parts: new Map() });
    return uploadId;
  }

  uploadPart(uploadId: string, partNumber: number, body: Buffer): string {
    const upload = this._uploads.get(uploadId);
    if (upload === undefined) throw new Error(`NoSuchUpload: Upload ${uploadId} not found`);
    upload.parts.set(partNumber, body);
    return `"${createHash("md5").update(body).digest("hex")}"`;
  }

  completeMultipartUpload(uploadId: string): { ETag: string; Location: string; Bucket: string; Key: string } {
    const upload = this._uploads.get(uploadId);
    if (upload === undefined) throw new Error(`NoSuchUpload: Upload ${uploadId} not found`);
    const sortedParts = [...upload.parts.entries()].sort(([a], [b]) => a - b).map(([, v]) => v);
    const assembled = Buffer.concat(sortedParts);
    const etag = this.putObject(upload.bucket, upload.key, assembled, upload.contentType);
    this._uploads.delete(uploadId);
    return { ETag: etag, Location: `/${upload.bucket}/${upload.key}`, Bucket: upload.bucket, Key: upload.key };
  }

  abortMultipartUpload(uploadId: string): void {
    this._uploads.delete(uploadId);
  }

  private _mkBucketDir(name: string): void {
    mkdirSync(join(this._baseDir, name), { recursive: true });
    mkdirSync(join(this._baseDir, name, ".meta"), { recursive: true });
  }

  private _readMeta(bucket: string, key: string): ObjectMeta {
    const metaPath = join(this._baseDir, bucket, ".meta", `${key}.json`);
    if (!existsSync(metaPath)) {
      const stat = statSync(join(this._baseDir, bucket, key));
      return { ContentType: "application/octet-stream", ETag: '""', ContentLength: stat.size, LastModified: stat.mtime.toISOString() };
    }
    return JSON.parse(readFileSync(metaPath, "utf-8")) as ObjectMeta;
  }

  private _listObjects(bucket: string): ObjectInfo[] {
    const bucketDir = join(this._baseDir, bucket);
    if (!existsSync(bucketDir)) return [];
    const results: ObjectInfo[] = [];
    this._walkDir(bucketDir, "", results);
    return results.sort((a, b) => a.Key.localeCompare(b.Key));
  }

  private _walkDir(base: string, prefix: string, results: ObjectInfo[]): void {
    const entries = readdirSync(join(base, prefix || ".") === base ? base : join(base, prefix));
    for (const entry of entries) {
      if (entry === ".meta") continue;
      const rel = prefix !== "" ? `${prefix}/${entry}` : entry;
      const full = join(base, rel);
      const stat = statSync(full);
      if (stat.isDirectory()) {
        this._walkDir(base, rel, results);
      } else {
        const metaPath = join(base, ".meta", `${rel}.json`);
        const meta = existsSync(metaPath)
          ? (JSON.parse(readFileSync(metaPath, "utf-8")) as ObjectMeta)
          : { ETag: '""', ContentLength: stat.size, LastModified: stat.mtime.toISOString(), ContentType: "" };
        results.push({ Key: rel, Size: meta.ContentLength, ETag: meta.ETag, LastModified: meta.LastModified });
      }
    }
  }
}
