/**
 * S3 helper for seeding and asserting bucket state.
 */

import {
  S3Client,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
  ListObjectsV2Command,
} from "@aws-sdk/client-s3";

export class S3Helper {
  constructor(
    private readonly bucketName: string,
    private readonly client: S3Client,
  ) {}

  async put(key: string, body: Buffer | string, contentType?: string): Promise<void> {
    await this.client.send(
      new PutObjectCommand({
        Bucket: this.bucketName,
        Key: key,
        Body: typeof body === "string" ? Buffer.from(body) : body,
        ...(contentType ? { ContentType: contentType } : {}),
      }),
    );
  }

  async get(key: string): Promise<Buffer> {
    const result = await this.client.send(
      new GetObjectCommand({ Bucket: this.bucketName, Key: key }),
    );
    const chunks: Uint8Array[] = [];
    for await (const chunk of result.Body as AsyncIterable<Uint8Array>) {
      chunks.push(chunk);
    }
    return Buffer.concat(chunks);
  }

  async getText(key: string, encoding: BufferEncoding = "utf-8"): Promise<string> {
    return (await this.get(key)).toString(encoding);
  }

  async delete(key: string): Promise<void> {
    await this.client.send(new DeleteObjectCommand({ Bucket: this.bucketName, Key: key }));
  }

  async listKeys(prefix?: string): Promise<string[]> {
    const keys: string[] = [];
    let token: string | undefined;
    do {
      const result = await this.client.send(
        new ListObjectsV2Command({
          Bucket: this.bucketName,
          ...(prefix ? { Prefix: prefix } : {}),
          ...(token ? { ContinuationToken: token } : {}),
        }),
      );
      keys.push(...(result.Contents ?? []).map((obj) => obj.Key!));
      token = result.NextContinuationToken;
    } while (token);
    return keys;
  }

  async assertObjectExists(key: string): Promise<void> {
    const keys = await this.listKeys();
    if (!keys.includes(key)) {
      throw new Error(
        `Expected object "${key}" to exist in bucket "${this.bucketName}", ` +
          `but it was not found. Existing keys: ${JSON.stringify(keys)}`,
      );
    }
  }

  async assertObjectCount(expectedCount: number, prefix?: string): Promise<void> {
    const keys = await this.listKeys(prefix);
    if (keys.length !== expectedCount) {
      throw new Error(
        `Expected ${expectedCount} object(s) in bucket "${this.bucketName}"` +
          (prefix ? ` with prefix "${prefix}"` : "") +
          `, but found ${keys.length}.`,
      );
    }
  }
}
