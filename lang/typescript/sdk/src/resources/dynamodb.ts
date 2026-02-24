/**
 * DynamoDB helper for seeding and asserting table state.
 */

import {
  DynamoDBClient,
  PutItemCommand,
  GetItemCommand,
  DeleteItemCommand,
  ScanCommand,
  AttributeValue,
} from "@aws-sdk/client-dynamodb";

export class DynamoDBHelper {
  constructor(
    private readonly tableName: string,
    private readonly client: DynamoDBClient
  ) {}

  async put(item: Record<string, AttributeValue>): Promise<void> {
    await this.client.send(new PutItemCommand({ TableName: this.tableName, Item: item }));
  }

  async get(
    key: Record<string, AttributeValue>
  ): Promise<Record<string, AttributeValue> | undefined> {
    const response = await this.client.send(
      new GetItemCommand({ TableName: this.tableName, Key: key })
    );
    return response.Item;
  }

  async delete(key: Record<string, AttributeValue>): Promise<void> {
    await this.client.send(
      new DeleteItemCommand({ TableName: this.tableName, Key: key })
    );
  }

  async scan(): Promise<Array<Record<string, AttributeValue>>> {
    const items: Array<Record<string, AttributeValue>> = [];
    let lastKey: Record<string, AttributeValue> | undefined;
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

  async assertItemExists(
    key: Record<string, AttributeValue>
  ): Promise<Record<string, AttributeValue>> {
    const item = await this.get(key);
    if (!item) {
      throw new Error(
        `Expected item with key ${JSON.stringify(key)} to exist in table "${this.tableName}", but it was not found.`
      );
    }
    return item;
  }

  async assertItemCount(expectedCount: number): Promise<void> {
    const items = await this.scan();
    if (items.length !== expectedCount) {
      throw new Error(
        `Expected ${expectedCount} item(s) in table "${this.tableName}", but found ${items.length}.`
      );
    }
  }
}
