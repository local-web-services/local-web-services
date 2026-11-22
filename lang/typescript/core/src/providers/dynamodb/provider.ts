/**
 * DynamoDB provider — in-memory tables.
 *
 * Mirrors `providers/dynamodb/provider.py`.
 */

import type { IProvider } from "../../interfaces/provider.js";
import type { DynamoAttributeValue, DynamoItem } from "./table.js";
import { LocalTable } from "./table.js";
import { applyUpdateExpression, evaluateFilterExpression } from "./expressions.js";
import type { ExpressionContext } from "./expressions.js";

export interface TableConfig {
  tableName: string;
  hashKey: string;
  hashKeyType?: string | undefined;
  sortKey?: string | undefined;
  sortKeyType?: string | undefined;
}

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "000000000000";

export class DynamoProvider implements IProvider {
  readonly name = "dynamodb";

  private _configs: Map<string, TableConfig>;
  private _preconfiguredNames: ReadonlySet<string>;
  private _tables = new Map<string, LocalTable>();
  private _running = false;

  constructor(tables: TableConfig[] = []) {
    this._configs = new Map(tables.map((t) => [t.tableName, t]));
    this._preconfiguredNames = new Set(tables.map((t) => t.tableName));
  }

  // ------------------------------------------------------------------
  // IProvider lifecycle
  // ------------------------------------------------------------------

  async start(): Promise<void> {
    for (const config of this._configs.values()) {
      this._tables.set(config.tableName, this._makeTable(config));
    }
    this._running = true;
  }

  async stop(): Promise<void> {
    this._tables.clear();
    this._running = false;
  }

  async reset(): Promise<void> {
    for (const name of [...this._tables.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._tables.delete(name);
        this._configs.delete(name);
      }
    }
    for (const table of this._tables.values()) {
      table.purge();
    }
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  // ------------------------------------------------------------------
  // Table management
  // ------------------------------------------------------------------

  createTable(config: TableConfig): LocalTable {
    if (this._tables.has(config.tableName)) {
      throw new Error(`ResourceInUseException: Table already exists: ${config.tableName}`);
    }
    const table = this._makeTable(config);
    this._tables.set(config.tableName, table);
    this._configs.set(config.tableName, config);
    return table;
  }

  deleteTable(tableName: string): void {
    if (!this._tables.has(tableName)) {
      throw new Error(`ResourceNotFoundException: Table not found: ${tableName}`);
    }
    this._tables.delete(tableName);
    this._configs.delete(tableName);
  }

  describeTable(tableName: string): object {
    const table = this._requireTable(tableName);
    return this._tableDescription(table);
  }

  listTables(): string[] {
    return [...this._tables.keys()].sort();
  }

  // ------------------------------------------------------------------
  // Item operations
  // ------------------------------------------------------------------

  putItem(tableName: string, item: DynamoItem): void {
    const table = this._requireTable(tableName);
    table.put(item);
  }

  getItem(
    tableName: string,
    key: DynamoItem,
  ): DynamoItem | undefined {
    const table = this._requireTable(tableName);
    const hv = key[table.hashKey];
    const sv = table.sortKey !== undefined ? key[table.sortKey] : undefined;
    if (hv === undefined) return undefined;
    return table.get(hv, sv);
  }

  deleteItem(
    tableName: string,
    key: DynamoItem,
  ): DynamoItem | undefined {
    const table = this._requireTable(tableName);
    const hv = key[table.hashKey];
    const sv = table.sortKey !== undefined ? key[table.sortKey] : undefined;
    if (hv === undefined) return undefined;
    return table.delete(hv, sv);
  }

  updateItem(
    tableName: string,
    key: DynamoItem,
    updateExpression: string,
    ctx: ExpressionContext = {},
  ): DynamoItem {
    const table = this._requireTable(tableName);
    const hv = key[table.hashKey];
    const sv = table.sortKey !== undefined ? key[table.sortKey] : undefined;
    if (hv === undefined) throw new Error("ValidationException: Missing hash key");
    const existing = table.get(hv, sv) ?? { ...key };
    const updated = applyUpdateExpression(existing, updateExpression, ctx);
    table.put(updated);
    return updated;
  }

  scan(
    tableName: string,
    filterExpression?: string,
    ctx: ExpressionContext = {},
  ): DynamoItem[] {
    const table = this._requireTable(tableName);
    const items = table.scan();
    if (filterExpression === undefined) return items;
    return items.filter((item) => evaluateFilterExpression(item, filterExpression, ctx));
  }

  query(
    tableName: string,
    keyConditionExpression: string,
    ctx: ExpressionContext = {},
    filterExpression?: string,
  ): DynamoItem[] {
    const table = this._requireTable(tableName);
    const values = ctx.expressionAttributeValues ?? {};
    const names = ctx.expressionAttributeNames ?? {};

    const resolved = keyConditionExpression.replace(
      /#[A-Za-z_][A-Za-z0-9_]*/g,
      (token) => names[token] ?? token,
    );

    const hashKeyVal = extractHashKeyValue(resolved, table.hashKey, values);
    if (hashKeyVal === undefined) {
      throw new Error("ValidationException: Query must have a key condition for the partition key");
    }

    let results = table.queryByHash(hashKeyVal);

    if (table.sortKey !== undefined) {
      const skCondition = extractSortKeyCondition(resolved, table.sortKey);
      if (skCondition !== null) {
        results = results.filter((item) =>
          evaluateFilterExpression(item, skCondition, { expressionAttributeValues: values }),
        );
      }
    }

    if (filterExpression !== undefined) {
      results = results.filter((item) => evaluateFilterExpression(item, filterExpression, ctx));
    }

    return results;
  }

  tableArn(tableName: string): string {
    return `arn:aws:dynamodb:${FAKE_REGION}:${FAKE_ACCOUNT}:table/${tableName}`;
  }

  // ------------------------------------------------------------------
  // Internal
  // ------------------------------------------------------------------

  private _makeTable(config: TableConfig): LocalTable {
    return new LocalTable({
      tableName: config.tableName,
      hashKey: config.hashKey,
      hashKeyType: config.hashKeyType ?? "S",
      sortKey: config.sortKey,
      sortKeyType: config.sortKeyType ?? "S",
    });
  }

  private _requireTable(tableName: string): LocalTable {
    const table = this._tables.get(tableName);
    if (table === undefined) {
      throw new Error(`ResourceNotFoundException: Table not found: ${tableName}`);
    }
    return table;
  }

  private _tableDescription(table: LocalTable): object {
    const keySchema: object[] = [{ AttributeName: table.hashKey, KeyType: "HASH" }];
    const attrDefs: object[] = [{ AttributeName: table.hashKey, AttributeType: table.hashKeyType }];
    if (table.sortKey !== undefined) {
      keySchema.push({ AttributeName: table.sortKey, KeyType: "RANGE" });
      attrDefs.push({ AttributeName: table.sortKey, AttributeType: table.sortKeyType });
    }
    return {
      TableName: table.tableName,
      TableStatus: "ACTIVE",
      TableArn: this.tableArn(table.tableName),
      ItemCount: table.itemCount,
      KeySchema: keySchema,
      AttributeDefinitions: attrDefs,
      ProvisionedThroughput: { ReadCapacityUnits: 5, WriteCapacityUnits: 5 },
      CreationDateTime: Date.now() / 1000,
    };
  }
}

// ------------------------------------------------------------------
// Key condition helpers
// ------------------------------------------------------------------

function extractHashKeyValue(
  expr: string,
  hashKey: string,
  values: Record<string, DynamoAttributeValue>,
): DynamoAttributeValue | undefined {
  const escaped = hashKey.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  const patterns = [
    new RegExp(`${escaped}\\s*=\\s*(:?[A-Za-z_][A-Za-z0-9_]*)`),
    new RegExp(`(:?[A-Za-z_][A-Za-z0-9_]*)\\s*=\\s*${escaped}`),
  ];
  for (const pat of patterns) {
    const m = pat.exec(expr);
    if (m !== null) {
      const token = m[1]!;
      if (token.startsWith(":")) return values[token];
    }
  }
  return undefined;
}

function extractSortKeyCondition(
  expr: string,
  sortKey: string,
): string | null {
  const andIdx = expr.toUpperCase().indexOf(" AND ");
  if (andIdx === -1) return null;
  const afterAnd = expr.slice(andIdx + 5).trim();
  if (afterAnd.includes(sortKey)) return afterAnd;
  return null;
}
