"use strict";

const {
  DynamoDBClient,
  PutItemCommand,
  GetItemCommand,
  DeleteItemCommand,
  ScanCommand,
} = require("@aws-sdk/client-dynamodb");

class DynamoDBHelper {
  constructor(tableName, client) {
    this.tableName = tableName;
    this.client = client;
  }

  async put(item) {
    await this.client.send(new PutItemCommand({ TableName: this.tableName, Item: item }));
  }

  async get(key) {
    const response = await this.client.send(
      new GetItemCommand({ TableName: this.tableName, Key: key })
    );
    return response.Item;
  }

  async delete(key) {
    await this.client.send(
      new DeleteItemCommand({ TableName: this.tableName, Key: key })
    );
  }

  async scan() {
    const items = [];
    let lastKey;
    do {
      const result = await this.client.send(
        new ScanCommand({
          TableName: this.tableName,
          ...(lastKey ? { ExclusiveStartKey: lastKey } : {}),
        })
      );
      items.push(...(result.Items ?? []));
      lastKey = result.LastEvaluatedKey;
    } while (lastKey);
    return items;
  }

  async assertItemExists(key) {
    const item = await this.get(key);
    if (!item) {
      throw new Error(
        `Expected item with key ${JSON.stringify(key)} to exist in table "${this.tableName}", but it was not found.`
      );
    }
    return item;
  }

  async assertItemCount(expectedCount) {
    const items = await this.scan();
    if (items.length !== expectedCount) {
      throw new Error(
        `Expected ${expectedCount} item(s) in table "${this.tableName}", but found ${items.length}.`
      );
    }
  }
}

void DynamoDBClient;

module.exports = { DynamoDBHelper };
