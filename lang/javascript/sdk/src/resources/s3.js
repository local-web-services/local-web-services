"use strict";

const {
  S3Client,
  PutObjectCommand,
  GetObjectCommand,
  DeleteObjectCommand,
  ListObjectsV2Command,
} = require("@aws-sdk/client-s3");

class S3Helper {
  constructor(bucketName, client) {
    this.bucketName = bucketName;
    this.client = client;
  }

  async put(key, body, contentType) {
    await this.client.send(
      new PutObjectCommand({
        Bucket: this.bucketName,
        Key: key,
        Body: typeof body === "string" ? Buffer.from(body) : body,
        ...(contentType ? { ContentType: contentType } : {}),
      })
    );
  }

  async get(key) {
    const result = await this.client.send(
      new GetObjectCommand({ Bucket: this.bucketName, Key: key })
    );
    const chunks = [];
    for await (const chunk of result.Body) {
      chunks.push(chunk);
    }
    return Buffer.concat(chunks);
  }

  async getText(key, encoding = "utf-8") {
    return (await this.get(key)).toString(encoding);
  }

  async delete(key) {
    await this.client.send(
      new DeleteObjectCommand({ Bucket: this.bucketName, Key: key })
    );
  }

  async listKeys(prefix) {
    const keys = [];
    let token;
    do {
      const result = await this.client.send(
        new ListObjectsV2Command({
          Bucket: this.bucketName,
          ...(prefix ? { Prefix: prefix } : {}),
          ...(token ? { ContinuationToken: token } : {}),
        })
      );
      keys.push(...(result.Contents ?? []).map((obj) => obj.Key));
      token = result.NextContinuationToken;
    } while (token);
    return keys;
  }

  async assertObjectExists(key) {
    const keys = await this.listKeys();
    if (!keys.includes(key)) {
      throw new Error(
        `Expected object "${key}" to exist in bucket "${this.bucketName}", ` +
          `but it was not found. Existing keys: ${JSON.stringify(keys)}`
      );
    }
  }

  async assertObjectCount(expectedCount, prefix) {
    const keys = await this.listKeys(prefix);
    if (keys.length !== expectedCount) {
      throw new Error(
        `Expected ${expectedCount} object(s) in bucket "${this.bucketName}"` +
          (prefix ? ` with prefix "${prefix}"` : "") +
          `, but found ${keys.length}.`
      );
    }
  }
}

void S3Client;

module.exports = { S3Helper };
