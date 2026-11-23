/**
 * In-memory DynamoDB table storage.
 */

export type DynamoAttributeValue =
  | { S: string }
  | { N: string }
  | { BOOL: boolean }
  | { NULL: boolean }
  | { B: string }
  | { SS: string[] }
  | { NS: string[] }
  | { L: DynamoAttributeValue[] }
  | { M: Record<string, DynamoAttributeValue> };

export type DynamoItem = Record<string, DynamoAttributeValue>;

export interface TableConfig {
  tableName: string;
  hashKey: string;
  hashKeyType: string;
  sortKey?: string | undefined;
  sortKeyType?: string | undefined;
}

export interface TtlSpec {
  attributeName: string;
  enabled: boolean;
}

export class LocalTable {
  readonly tableName: string;
  readonly hashKey: string;
  readonly hashKeyType: string;
  readonly sortKey: string | undefined;
  readonly sortKeyType: string;
  tags: Record<string, string> = {};
  ttlSpec: TtlSpec = { attributeName: "", enabled: false };
  private _items = new Map<string, DynamoItem>();

  constructor(config: TableConfig) {
    this.tableName = config.tableName;
    this.hashKey = config.hashKey;
    this.hashKeyType = config.hashKeyType;
    this.sortKey = config.sortKey;
    this.sortKeyType = config.sortKeyType ?? "S";
  }

  itemKey(item: DynamoItem): string {
    const hk = extractScalar(item[this.hashKey]);
    if (this.sortKey !== undefined) {
      const sk = extractScalar(item[this.sortKey]);
      return `${hk}\0${sk}`;
    }
    return hk;
  }

  keyFromValues(hashValue: DynamoAttributeValue, sortValue?: DynamoAttributeValue): string {
    const hk = extractScalar(hashValue);
    if (this.sortKey !== undefined && sortValue !== undefined) {
      return `${hk}\0${extractScalar(sortValue)}`;
    }
    return hk;
  }

  put(item: DynamoItem): void {
    const key = this.itemKey(item);
    this._items.set(key, { ...item });
  }

  get(hashValue: DynamoAttributeValue, sortValue?: DynamoAttributeValue): DynamoItem | undefined {
    const key = this.keyFromValues(hashValue, sortValue);
    return this._items.get(key);
  }

  delete(hashValue: DynamoAttributeValue, sortValue?: DynamoAttributeValue): DynamoItem | undefined {
    const key = this.keyFromValues(hashValue, sortValue);
    const existing = this._items.get(key);
    if (existing !== undefined) this._items.delete(key);
    return existing;
  }

  scan(): DynamoItem[] {
    return [...this._items.values()].map((item) => ({ ...item }));
  }

  queryByHash(hashValue: DynamoAttributeValue): DynamoItem[] {
    const hk = extractScalar(hashValue);
    const results: DynamoItem[] = [];
    for (const [key, item] of this._items) {
      const itemHk = key.includes("\0") ? key.split("\0")[0] : key;
      if (itemHk === hk) {
        results.push({ ...item });
      }
    }
    return results;
  }

  purge(): void {
    this._items.clear();
  }

  get itemCount(): number {
    return this._items.size;
  }
}

export function extractScalar(val: DynamoAttributeValue | undefined): string {
  if (val === undefined) return "";
  if ("S" in val) return val.S;
  if ("N" in val) return val.N;
  if ("B" in val) return val.B;
  return "";
}
