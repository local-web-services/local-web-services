/** SQLite-backed DynamoDB store. */
export declare function isDynamoJson(item: Record<string, unknown>): boolean;
export declare function toDynamoValue(val: unknown): Record<string, unknown>;
export declare function toDynamoItem(item: Record<string, unknown>): Record<string, unknown>;
export declare function fromDynamoValue(typed: Record<string, unknown>): unknown;
export declare function fromDynamoItem(item: Record<string, unknown>): Record<string, unknown>;
export interface KeyAttr {
    name: string;
    type: string;
}
export interface GsiDef {
    name: string;
    pk: KeyAttr;
    sk?: KeyAttr;
    projectionType: string;
}
export interface TableConfig {
    name: string;
    pk: KeyAttr;
    sk?: KeyAttr;
    gsis: GsiDef[];
}
type ExprNames = Record<string, string> | undefined;
type ExprValues = Record<string, Record<string, unknown>> | undefined;
export declare function evaluateFilter(item: Record<string, unknown>, expr: string, names: ExprNames, values: ExprValues): boolean;
interface KeyCondition {
    where: string;
    params: string[];
}
export declare function parseKeyCondition(expr: string, names: ExprNames, values: ExprValues): KeyCondition;
export declare function applyUpdateExpression(existing: Record<string, unknown>, updateExpr: string, names: ExprNames, values: ExprValues): Record<string, unknown>;
export declare class DynamoStore {
    private db;
    constructor(dbPath?: string);
    reset(): void;
    createTable(config: TableConfig): Record<string, unknown>;
    deleteTable(tableName: string): Record<string, unknown>;
    describeTable(tableName: string): Record<string, unknown>;
    listTables(): string[];
    getItem(tableName: string, key: Record<string, unknown>): Record<string, unknown> | null;
    putItem(tableName: string, item: Record<string, unknown>): void;
    deleteItem(tableName: string, key: Record<string, unknown>): void;
    updateItem(tableName: string, key: Record<string, unknown>, updateExpr: string, names: ExprNames, values: ExprValues): Record<string, unknown>;
    query(tableName: string, keyCondition: string, names: ExprNames, values: ExprValues, indexName?: string, filterExpression?: string, scanIndexForward?: boolean, limit?: number, exclusiveStartKey?: Record<string, unknown>): {
        items: Array<Record<string, unknown>>;
        lastEvaluatedKey?: Record<string, unknown>;
    };
    scan(tableName: string, filterExpression?: string, names?: ExprNames, values?: ExprValues, limit?: number, exclusiveStartKey?: Record<string, unknown>): {
        items: Array<Record<string, unknown>>;
        lastEvaluatedKey?: Record<string, unknown>;
    };
    batchGetItems(tableName: string, keys: Array<Record<string, unknown>>): Array<Record<string, unknown>>;
    batchWriteItems(tableName: string, putItems: Array<Record<string, unknown>>, deleteKeys: Array<Record<string, unknown>>): void;
    private _getConfig;
    private _updateGsis;
    private _tableDescription;
}
export {};
//# sourceMappingURL=store.d.ts.map