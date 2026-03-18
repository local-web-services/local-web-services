/** DynamoDB step definitions. */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import {
  CreateTableCommand,
  DeleteTableCommand,
  DescribeTableCommand,
  ListTablesCommand,
  PutItemCommand,
  GetItemCommand,
  DeleteItemCommand,
  UpdateItemCommand,
  ScanCommand,
  QueryCommand,
  BatchGetItemCommand,
  BatchWriteItemCommand,
  TransactGetItemsCommand,
  TransactWriteItemsCommand,
  DescribeContinuousBackupsCommand,
  DescribeTimeToLiveCommand,
  UpdateTimeToLiveCommand,
  UpdateTableCommand,
  TagResourceCommand,
  UntagResourceCommand,
  ListTagsOfResourceCommand,
} from "@aws-sdk/client-dynamodb";
import type { LwsWorld } from "../support/world";

const TABLE_DEF = (tableName: string) => ({
  TableName: tableName,
  KeySchema: [{ AttributeName: "pk", KeyType: "HASH" as const }],
  AttributeDefinitions: [{ AttributeName: "pk", AttributeType: "S" as const }],
  BillingMode: "PAY_PER_REQUEST" as const,
});

async function createTable(world: LwsWorld, tableName: string): Promise<void> {
  const client = world.dynamodbClient();
  await client.send(new CreateTableCommand(TABLE_DEF(tableName)));
}

Given("a table {string} was created", async function (this: LwsWorld, tableName: string) {
  await createTable(this, tableName);
});

Given(
  "an item was put with key {string} into table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    await client.send(
      new PutItemCommand({
        TableName: tableName,
        Item: { pk: { S: key } },
      }),
    );
  },
);

Given(
  "an item was put with key {string} and data {string} into table {string}",
  async function (this: LwsWorld, key: string, data: string, tableName: string) {
    const client = this.dynamodbClient();
    await client.send(
      new PutItemCommand({
        TableName: tableName,
        Item: { pk: { S: key }, data: { S: data } },
      }),
    );
  },
);

Given(
  "an item was put with key {string} and status {string} into table {string}",
  async function (this: LwsWorld, key: string, status: string, tableName: string) {
    const client = this.dynamodbClient();
    await client.send(
      new PutItemCommand({
        TableName: tableName,
        Item: { pk: { S: key }, status: { S: status } },
      }),
    );
  },
);

Given(
  "table {string} was tagged with key {string} and value {string}",
  async function (this: LwsWorld, tableName: string, tagKey: string, tagValue: string) {
    const client = this.dynamodbClient();
    const desc = await client.send(new DescribeTableCommand({ TableName: tableName }));
    const arn = desc.Table?.TableArn!;
    await client.send(
      new TagResourceCommand({ ResourceArn: arn, Tags: [{ Key: tagKey, Value: tagValue }] }),
    );
  },
);

When("I create a table {string}", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new CreateTableCommand(TABLE_DEF(tableName)));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I list tables", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new ListTablesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I delete table {string}", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new DeleteTableCommand({ TableName: tableName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When("I describe table {string}", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new DescribeTableCommand({ TableName: tableName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I put an item with key {string} and data {string} into table {string}",
  async function (this: LwsWorld, key: string, data: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new PutItemCommand({
          TableName: tableName,
          Item: { pk: { S: key }, data: { S: data } },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I get item with key {string} from table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new GetItemCommand({ TableName: tableName, Key: { pk: { S: key } } }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I delete item with key {string} from table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new DeleteItemCommand({ TableName: tableName, Key: { pk: { S: key } } }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I update item with key {string} setting data to {string} in table {string}",
  async function (this: LwsWorld, key: string, data: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new UpdateItemCommand({
          TableName: tableName,
          Key: { pk: { S: key } },
          UpdateExpression: "SET #d = :d",
          ExpressionAttributeNames: { "#d": "data" },
          ExpressionAttributeValues: { ":d": { S: data } },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I scan table {string}", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new ScanCommand({ TableName: tableName }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

When(
  "I query table {string} for key {string}",
  async function (this: LwsWorld, tableName: string, key: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new QueryCommand({
          TableName: tableName,
          KeyConditionExpression: "pk = :pk",
          ExpressionAttributeValues: { ":pk": { S: key } },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I batch get item with key {string} from table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new BatchGetItemCommand({
          RequestItems: {
            [tableName]: { Keys: [{ pk: { S: key } }] },
          },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I batch write items with keys {string} and {string} into table {string}",
  async function (this: LwsWorld, key1: string, key2: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new BatchWriteItemCommand({
          RequestItems: {
            [tableName]: [
              { PutRequest: { Item: { pk: { S: key1 } } } },
              { PutRequest: { Item: { pk: { S: key2 } } } },
            ],
          },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I transact get item with key {string} from table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new TransactGetItemsCommand({
          TransactItems: [{ Get: { TableName: tableName, Key: { pk: { S: key } } } }],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I transact write with condition check on key {string} and put key {string} with data {string} in table {string}",
  async function (
    this: LwsWorld,
    conditionKey: string,
    putKey: string,
    data: string,
    tableName: string,
  ) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new TransactWriteItemsCommand({
          TransactItems: [
            {
              ConditionCheck: {
                TableName: tableName,
                Key: { pk: { S: conditionKey } },
                ConditionExpression: "attribute_exists(pk)",
              },
            },
            {
              Put: {
                TableName: tableName,
                Item: { pk: { S: putKey }, data: { S: data } },
              },
            },
          ],
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err: unknown) {
      // TransactionCanceledException is expected in some scenarios
      this.lastResult = { success: true, output: err, error: err };
    }
  },
);

When(
  "I describe continuous backups for table {string}",
  async function (this: LwsWorld, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new DescribeContinuousBackupsCommand({ TableName: tableName }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I describe time to live for table {string}",
  async function (this: LwsWorld, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(new DescribeTimeToLiveCommand({ TableName: tableName }));
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I update time to live for table {string}",
  async function (this: LwsWorld, tableName: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new UpdateTimeToLiveCommand({
          TableName: tableName,
          TimeToLiveSpecification: { AttributeName: "ttl", Enabled: true },
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I update table {string} with billing mode {string}",
  async function (this: LwsWorld, tableName: string, billingMode: string) {
    const client = this.dynamodbClient();
    try {
      const result = await client.send(
        new UpdateTableCommand({
          TableName: tableName,
          BillingMode: billingMode as "PAY_PER_REQUEST" | "PROVISIONED",
        }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I tag table {string} with key {string} and value {string}",
  async function (this: LwsWorld, tableName: string, tagKey: string, tagValue: string) {
    const client = this.dynamodbClient();
    try {
      const desc = await client.send(new DescribeTableCommand({ TableName: tableName }));
      const arn = desc.Table?.TableArn!;
      const result = await client.send(
        new TagResourceCommand({ ResourceArn: arn, Tags: [{ Key: tagKey, Value: tagValue }] }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When(
  "I untag table {string} removing key {string}",
  async function (this: LwsWorld, tableName: string, tagKey: string) {
    const client = this.dynamodbClient();
    try {
      const desc = await client.send(new DescribeTableCommand({ TableName: tableName }));
      const arn = desc.Table?.TableArn!;
      const result = await client.send(
        new UntagResourceCommand({ ResourceArn: arn, TagKeys: [tagKey] }),
      );
      this.lastResult = { success: true, output: result };
    } catch (err) {
      this.lastResult = { success: false, output: err, error: err };
    }
  },
);

When("I list tags of table {string}", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  try {
    const desc = await client.send(new DescribeTableCommand({ TableName: tableName }));
    const arn = desc.Table?.TableArn!;
    const result = await client.send(new ListTagsOfResourceCommand({ ResourceArn: arn }));
    this.lastResult = { success: true, output: result };
  } catch (err) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Timed variants
When("I list DynamoDB tables with timing", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  const start = Date.now();
  try {
    const result = await client.send(new ListTablesCommand({}));
    this.timedResult = { success: true, output: result, elapsedMs: Date.now() - start };
  } catch (err) {
    this.timedResult = { success: false, output: err, elapsedMs: Date.now() - start };
  }
});

When("I list DynamoDB tables", async function (this: LwsWorld) {
  const client = this.dynamodbClient();
  try {
    const result = await client.send(new ListTablesCommand({}));
    this.lastResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastResult = { success: false, output: err, error: err };
  }
});

// Then assertions
Then("the output will contain table name {string}", function (this: LwsWorld, tableName: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes(tableName),
    `Expected output to contain table name "${tableName}" but got: ${actualOutput}`,
  );
});

Then("table {string} will exist", async function (this: LwsWorld, tableName: string) {
  const client = this.dynamodbClient();
  const result = await client.send(new ListTablesCommand({}));
  const actualTables = result.TableNames ?? [];
  assert.ok(
    actualTables.includes(tableName),
    `Expected table "${tableName}" to exist but tables are: ${actualTables.join(", ")}`,
  );
});

Then("the table list will include {string}", function (this: LwsWorld, tableName: string) {
  const output = this.lastResult.output as { TableNames?: string[] };
  const actualTables = output?.TableNames ?? [];
  assert.ok(
    actualTables.includes(tableName),
    `Expected table list to include "${tableName}" but got: ${actualTables.join(", ")}`,
  );
});

Then(
  "table {string} will not appear in list-tables",
  async function (this: LwsWorld, tableName: string) {
    const client = this.dynamodbClient();
    const result = await client.send(new ListTablesCommand({}));
    const actualTables = result.TableNames ?? [];
    assert.ok(
      !actualTables.includes(tableName),
      `Expected table "${tableName}" to not exist but it's in: ${actualTables.join(", ")}`,
    );
  },
);

Then(
  "table {string} will have {int} items",
  async function (this: LwsWorld, tableName: string, expectedCount: number) {
    const client = this.dynamodbClient();
    const result = await client.send(new ScanCommand({ TableName: tableName }));
    const actualCount = result.Count ?? 0;
    assert.strictEqual(actualCount, expectedCount);
  },
);

Then(
  "item with key {string} in table {string} will have data {string}",
  async function (this: LwsWorld, key: string, tableName: string, expectedData: string) {
    const client = this.dynamodbClient();
    const result = await client.send(
      new GetItemCommand({ TableName: tableName, Key: { pk: { S: key } } }),
    );
    const actualData = result.Item?.data?.S;
    assert.strictEqual(actualData, expectedData);
  },
);

Then(
  "item with key {string} will not exist in table {string}",
  async function (this: LwsWorld, key: string, tableName: string) {
    const client = this.dynamodbClient();
    const result = await client.send(
      new GetItemCommand({ TableName: tableName, Key: { pk: { S: key } } }),
    );
    assert.ok(!result.Item, `Expected item "${key}" to not exist but it does`);
  },
);

Then("the output will contain item data {string}", function (this: LwsWorld, expectedData: string) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes(expectedData),
    `Expected output to contain "${expectedData}" but got: ${actualOutput}`,
  );
});

Then(
  "the query result will contain at least {int} item",
  function (this: LwsWorld, minItems: number) {
    const output = this.lastResult.output as { Count?: number; Items?: unknown[] };
    const actualCount = output?.Count ?? output?.Items?.length ?? 0;
    assert.ok(
      actualCount >= minItems,
      `Expected at least ${minItems} items but got ${actualCount}`,
    );
  },
);

Then(
  "the first query result will have data {string}",
  function (this: LwsWorld, expectedData: string) {
    const output = this.lastResult.output as { Items?: Array<{ data?: { S?: string } }> };
    const firstItem = output?.Items?.[0];
    const actualData = firstItem?.data?.S;
    assert.strictEqual(actualData, expectedData);
  },
);

Then(
  "the scan result will contain at least {int} items",
  function (this: LwsWorld, minItems: number) {
    const output = this.lastResult.output as { Count?: number; Items?: unknown[] };
    const actualCount = output?.Count ?? output?.Items?.length ?? 0;
    assert.ok(
      actualCount >= minItems,
      `Expected at least ${minItems} items but got ${actualCount}`,
    );
  },
);

Then("the scan result will include key {string}", function (this: LwsWorld, expectedKey: string) {
  const output = this.lastResult.output as { Items?: Array<{ pk?: { S?: string } }> };
  const keys = (output?.Items ?? []).map((item) => item.pk?.S);
  assert.ok(
    keys.includes(expectedKey),
    `Expected scan result to include key "${expectedKey}" but got: ${keys.join(", ")}`,
  );
});

Then("the output will contain a TransactionCanceledException", function (this: LwsWorld) {
  const actualOutput = JSON.stringify(this.lastResult.output);
  assert.ok(
    actualOutput.includes("TransactionCanceledException") ||
      actualOutput.includes("TransactionConflict"),
    `Expected TransactionCanceledException but got: ${actualOutput}`,
  );
});
