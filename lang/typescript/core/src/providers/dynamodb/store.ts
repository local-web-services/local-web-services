/** SQLite-backed DynamoDB store. */

import Database from "better-sqlite3";

// ─── DynamoDB JSON helpers ───────────────────────────────────────────────────

const DYNAMO_TYPE_KEYS = new Set(["S", "N", "B", "BOOL", "NULL", "L", "M", "SS", "NS", "BS"]);

export function isDynamoJson(item: Record<string, unknown>): boolean {
  if (!item || Object.keys(item).length === 0) return false;
  for (const val of Object.values(item)) {
    if (typeof val !== "object" || val === null) return false;
    const keys = Object.keys(val as object);
    if (!keys.some((k) => DYNAMO_TYPE_KEYS.has(k))) return false;
  }
  return true;
}

export function toDynamoValue(val: unknown): Record<string, unknown> {
  if (val === null || val === undefined) return { NULL: true };
  if (typeof val === "boolean") return { BOOL: val };
  if (typeof val === "number") return { N: String(val) };
  if (typeof val === "string") return { S: val };
  if (Array.isArray(val)) return { L: val.map(toDynamoValue) };
  if (typeof val === "object") return { M: toDynamoItem(val as Record<string, unknown>) };
  return { S: String(val) };
}

export function toDynamoItem(item: Record<string, unknown>): Record<string, unknown> {
  if (isDynamoJson(item)) return item;
  const result: Record<string, unknown> = {};
  for (const [k, v] of Object.entries(item)) {
    result[k] = toDynamoValue(v);
  }
  return result;
}

export function fromDynamoValue(typed: Record<string, unknown>): unknown {
  if ("S" in typed) return typed.S;
  if ("N" in typed) {
    const n = String(typed.N);
    return n.includes(".") ? parseFloat(n) : parseInt(n, 10);
  }
  if ("B" in typed) return typed.B;
  if ("BOOL" in typed) return typed.BOOL;
  if ("NULL" in typed) return null;
  if ("L" in typed) return (typed.L as Array<Record<string, unknown>>).map(fromDynamoValue);
  if ("M" in typed) return fromDynamoItem(typed.M as Record<string, unknown>);
  if ("SS" in typed) return typed.SS;
  if ("NS" in typed) return (typed.NS as string[]).map((n) => parseFloat(n));
  return typed;
}

export function fromDynamoItem(item: Record<string, unknown>): Record<string, unknown> {
  if (!isDynamoJson(item)) return item;
  const result: Record<string, unknown> = {};
  for (const [k, v] of Object.entries(item)) {
    result[k] = fromDynamoValue(v as Record<string, unknown>);
  }
  return result;
}

function extractKeyValue(item: Record<string, unknown>, keyName: string): string {
  const raw = item[keyName];
  if (raw === null || raw === undefined) return "";
  if (typeof raw === "object" && raw !== null) {
    const typed = raw as Record<string, unknown>;
    if ("S" in typed) return String(typed.S);
    if ("N" in typed) return String(typed.N);
    if ("B" in typed) return String(typed.B);
  }
  return String(raw);
}

// ─── Table config ────────────────────────────────────────────────────────────

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

// ─── Filter expression evaluator ─────────────────────────────────────────────

type ExprNames = Record<string, string> | undefined;
type ExprValues = Record<string, Record<string, unknown>> | undefined;

function resolveName(token: string, names: ExprNames): string {
  if (names && token.startsWith("#")) return names[token] ?? token;
  return token;
}

function resolveValue(token: string, values: ExprValues): unknown {
  if (values && token.startsWith(":")) {
    const raw = values[token];
    if (raw && typeof raw === "object") {
      return fromDynamoValue(raw as Record<string, unknown>);
    }
    return raw;
  }
  return token;
}

function dynamoCompare(a: unknown, b: unknown): number {
  if (typeof a === "number" && typeof b === "number") return a - b;
  return String(a).localeCompare(String(b));
}

export function evaluateFilter(
  item: Record<string, unknown>,
  expr: string,
  names: ExprNames,
  values: ExprValues,
): boolean {
  try {
    return evalExpr(item, expr.trim(), names, values);
  } catch {
    return true;
  }
}

function evalExpr(
  item: Record<string, unknown>,
  expr: string,
  names: ExprNames,
  values: ExprValues,
): boolean {
  // Handle OR (lowest precedence)
  const orParts = splitTopLevel(expr, /\bOR\b/i);
  if (orParts.length > 1) {
    return orParts.some((p) => evalExpr(item, p.trim(), names, values));
  }

  // Handle AND
  const andParts = splitTopLevel(expr, /\bAND\b/i);
  if (andParts.length > 1) {
    return andParts.every((p) => evalExpr(item, p.trim(), names, values));
  }

  // Handle NOT
  const notMatch = /^NOT\s+(.+)$/i.exec(expr);
  if (notMatch) {
    return !evalExpr(item, notMatch[1].trim(), names, values);
  }

  // Handle parentheses
  if (expr.startsWith("(") && expr.endsWith(")")) {
    return evalExpr(item, expr.slice(1, -1).trim(), names, values);
  }

  // Function expressions
  const attrExistsMatch = /^attribute_exists\s*\(\s*([#\w.[\]]+)\s*\)$/i.exec(expr);
  if (attrExistsMatch) {
    const name = resolveName(attrExistsMatch[1], names);
    return getNestedAttr(item, name) !== undefined;
  }

  const attrNotExistsMatch = /^attribute_not_exists\s*\(\s*([#\w.[\]]+)\s*\)$/i.exec(expr);
  if (attrNotExistsMatch) {
    const name = resolveName(attrNotExistsMatch[1], names);
    return getNestedAttr(item, name) === undefined;
  }

  const beginsWithMatch = /^begins_with\s*\(\s*([#\w.]+)\s*,\s*([:\w]+)\s*\)$/i.exec(expr);
  if (beginsWithMatch) {
    const name = resolveName(beginsWithMatch[1], names);
    const prefix = resolveValue(beginsWithMatch[2], values);
    const val = getNestedAttr(item, name);
    return String(val ?? "").startsWith(String(prefix ?? ""));
  }

  const containsMatch = /^contains\s*\(\s*([#\w.]+)\s*,\s*([:\w]+)\s*\)$/i.exec(expr);
  if (containsMatch) {
    const name = resolveName(containsMatch[1], names);
    const sub = resolveValue(containsMatch[2], values);
    const val = getNestedAttr(item, name);
    if (typeof val === "string") return val.includes(String(sub));
    if (Array.isArray(val)) return val.some((v) => v === sub);
    return false;
  }

  const betweenMatch = /^([#\w.]+)\s+BETWEEN\s+([:\w]+)\s+AND\s+([:\w]+)$/i.exec(expr);
  if (betweenMatch) {
    const name = resolveName(betweenMatch[1], names);
    const lo = resolveValue(betweenMatch[2], values);
    const hi = resolveValue(betweenMatch[3], values);
    const val = getNestedAttr(item, name);
    return dynamoCompare(val, lo) >= 0 && dynamoCompare(val, hi) <= 0;
  }

  const inMatch = /^([#\w.]+)\s+IN\s+\((.+)\)$/i.exec(expr);
  if (inMatch) {
    const name = resolveName(inMatch[1], names);
    const candidates = inMatch[2].split(",").map((t) => resolveValue(t.trim(), values));
    const val = getNestedAttr(item, name);
    return candidates.some((c) => c === val);
  }

  // Comparison
  const cmpMatch = /^([#\w.]+)\s*(=|<>|!=|<=|>=|<|>)\s*([:\w]+)$/.exec(expr);
  if (cmpMatch) {
    const name = resolveName(cmpMatch[1], names);
    const op = cmpMatch[2];
    const rhs = resolveValue(cmpMatch[3], values);
    const lhs = getNestedAttr(item, name);
    switch (op) {
      case "=":
        return lhs === rhs;
      case "<>":
      case "!=":
        return lhs !== rhs;
      case "<":
        return dynamoCompare(lhs, rhs) < 0;
      case ">":
        return dynamoCompare(lhs, rhs) > 0;
      case "<=":
        return dynamoCompare(lhs, rhs) <= 0;
      case ">=":
        return dynamoCompare(lhs, rhs) >= 0;
    }
  }

  return true;
}

function getNestedAttr(item: Record<string, unknown>, path: string): unknown {
  const parts = path.split(".");
  let cur: unknown = item;
  for (const p of parts) {
    if (cur === null || cur === undefined || typeof cur !== "object") return undefined;
    cur = (cur as Record<string, unknown>)[p];
  }
  return cur;
}

function splitTopLevel(expr: string, pattern: RegExp): string[] {
  const parts: string[] = [];
  let depth = 0;
  let current = "";
  let i = 0;

  while (i < expr.length) {
    if (expr[i] === "(") {
      depth++;
      current += expr[i++];
      continue;
    }
    if (expr[i] === ")") {
      depth--;
      current += expr[i++];
      continue;
    }

    if (depth === 0) {
      const remaining = expr.slice(i);
      const match = pattern.exec(remaining);
      if (match && match.index === 0) {
        parts.push(current);
        current = "";
        i += match[0].length;
        continue;
      }
    }

    current += expr[i++];
  }
  parts.push(current);
  return parts.length > 1 ? parts : [expr];
}

// ─── Key condition parsing for SQL ──────────────────────────────────────────

function resolveScalarValue(token: string, values: ExprValues): string {
  if (values && token.startsWith(":")) {
    const raw = values[token];
    if (raw && typeof raw === "object") {
      const typed = raw as Record<string, unknown>;
      if ("S" in typed) return String(typed.S);
      if ("N" in typed) return String(typed.N);
      if ("B" in typed) return String(typed.B);
    }
    return String(raw ?? "");
  }
  return token;
}

interface KeyCondition {
  where: string;
  params: string[];
}

export function parseKeyCondition(
  expr: string,
  names: ExprNames,
  values: ExprValues,
): KeyCondition {
  const andParts = expr.split(/\bAND\b/i);
  const sqlParts: string[] = [];
  const params: string[] = [];

  let i = 0;
  while (i < andParts.length) {
    const part = andParts[i].trim();

    const beginsWithMatch = /^begins_with\s*\(\s*([#\w]+)\s*,\s*([:\w]+)\s*\)$/i.exec(part);
    if (beginsWithMatch) {
      const col = sqlParts.length === 0 ? "pk" : "sk";
      const val = resolveScalarValue(beginsWithMatch[2], values);
      sqlParts.push(`${col} LIKE ? || '%'`);
      params.push(val);
      i++;
      continue;
    }

    const betweenMatch = /^([#\w]+)\s+BETWEEN\s+([:\w]+)\s*$/.exec(part);
    if (betweenMatch && i + 1 < andParts.length) {
      const col = sqlParts.length === 0 ? "pk" : "sk";
      const valA = resolveScalarValue(betweenMatch[2], values);
      const valB = resolveScalarValue(andParts[i + 1].trim(), values);
      sqlParts.push(`${col} BETWEEN ? AND ?`);
      params.push(valA, valB);
      i += 2;
      continue;
    }

    const cmpMatch = /^([#\w]+)\s*(=|<>|<=|>=|<|>)\s*([:\w]+)$/.exec(part);
    if (cmpMatch) {
      const col = sqlParts.length === 0 ? "pk" : "sk";
      const val = resolveScalarValue(cmpMatch[3], values);
      sqlParts.push(`${col} ${cmpMatch[2]} ?`);
      params.push(val);
      i++;
      continue;
    }

    i++;
  }

  return {
    where: sqlParts.length > 0 ? sqlParts.join(" AND ") : "1=1",
    params,
  };
}

// ─── UpdateExpression evaluator ──────────────────────────────────────────────

export function applyUpdateExpression(
  existing: Record<string, unknown>,
  updateExpr: string,
  names: ExprNames,
  values: ExprValues,
): Record<string, unknown> {
  const item = { ...existing };

  // Parse SET, REMOVE, ADD, DELETE clauses
  const clauses: Array<{ type: string; content: string }> = [];
  const clausePattern = /\b(SET|REMOVE|ADD|DELETE)\s+/gi;
  let match: RegExpExecArray | null;
  const positions: Array<{ type: string; start: number }> = [];

  while ((match = clausePattern.exec(updateExpr)) !== null) {
    positions.push({ type: match[1].toUpperCase(), start: match.index + match[0].length });
  }

  for (let i = 0; i < positions.length; i++) {
    const start = positions[i].start;
    const end =
      i + 1 < positions.length
        ? positions[i + 1].start - positions[i + 1].type.length - 1
        : updateExpr.length;
    clauses.push({ type: positions[i].type, content: updateExpr.slice(start, end).trim() });
  }

  for (const clause of clauses) {
    const assignments = clause.content.split(",").map((s) => s.trim());

    if (clause.type === "SET") {
      for (const assignment of assignments) {
        // Handle: #attr = :val or attr = :val or attr = attr + :val etc.
        const eqMatch = /^([#\w.[\]]+)\s*=\s*(.+)$/.exec(assignment);
        if (!eqMatch) continue;

        const attrName = resolveName(eqMatch[1].trim(), names);
        const rhs = eqMatch[2].trim();

        // Handle list_append(attr, :val)
        const listAppendMatch = /^list_append\s*\(\s*([#\w.]+)\s*,\s*([:\w]+)\s*\)$/i.exec(rhs);
        if (listAppendMatch) {
          const existingList = (item[resolveName(listAppendMatch[1], names)] ?? []) as unknown[];
          const appendVal = resolveValue(listAppendMatch[2], values);
          item[attrName] = [
            ...existingList,
            ...(Array.isArray(appendVal) ? appendVal : [appendVal]),
          ];
          continue;
        }

        // Handle if_not_exists(attr, :val)
        const ifNotExistsMatch = /^if_not_exists\s*\(\s*([#\w.]+)\s*,\s*([:\w]+)\s*\)$/i.exec(rhs);
        if (ifNotExistsMatch) {
          const checkName = resolveName(ifNotExistsMatch[1], names);
          if (item[checkName] === undefined) {
            item[attrName] = resolveValue(ifNotExistsMatch[2], values);
          }
          continue;
        }

        // Handle attr + :val or attr - :val
        const arithMatch = /^([#\w]+)\s*([+-])\s*([:\w]+)$/.exec(rhs);
        if (arithMatch) {
          const baseName = resolveName(arithMatch[1], names);
          const op = arithMatch[2];
          const delta = Number(resolveValue(arithMatch[3], values) ?? 0);
          const baseVal = Number(item[baseName] ?? 0);
          item[attrName] = op === "+" ? baseVal + delta : baseVal - delta;
          continue;
        }

        item[attrName] = resolveValue(rhs, values);
      }
    } else if (clause.type === "REMOVE") {
      for (const attrToken of assignments) {
        const attrName = resolveName(attrToken.trim(), names);
        delete item[attrName];
      }
    } else if (clause.type === "ADD") {
      for (const assignment of assignments) {
        const addMatch = /^([#\w.]+)\s+([:\w]+)$/.exec(assignment);
        if (!addMatch) continue;
        const attrName = resolveName(addMatch[1], names);
        const delta = Number(resolveValue(addMatch[2], values) ?? 0);
        item[attrName] = Number(item[attrName] ?? 0) + delta;
      }
    } else if (clause.type === "DELETE") {
      for (const assignment of assignments) {
        const delMatch = /^([#\w.]+)\s+([:\w]+)$/.exec(assignment);
        if (!delMatch) continue;
        const attrName = resolveName(delMatch[1], names);
        const toRemove = resolveValue(delMatch[2], values);
        const existing2 = item[attrName];
        if (Array.isArray(existing2) && Array.isArray(toRemove)) {
          item[attrName] = existing2.filter((v) => !toRemove.includes(v));
        }
      }
    }
  }

  return item;
}

// ─── DynamoDB Store ──────────────────────────────────────────────────────────

export class DynamoStore {
  private db: Database.Database;

  constructor(dbPath: string = ":memory:") {
    this.db = new Database(dbPath);
    this.db.pragma("journal_mode = WAL");
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS _tables (
        name TEXT PRIMARY KEY,
        config_json TEXT NOT NULL
      );
    `);
  }

  reset(): void {
    // Get all table names and drop their item tables
    const tables = this.db.prepare("SELECT name FROM _tables").all() as Array<{ name: string }>;
    for (const { name } of tables) {
      const safe = safeName(name);
      this.db.exec(`DROP TABLE IF EXISTS "items_${safe}"`);
      // Drop GSI tables
      const rows = this.db
        .prepare(`SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'gsi_${safe}_%'`)
        .all() as Array<{ name: string }>;
      for (const row of rows) {
        this.db.exec(`DROP TABLE IF EXISTS "${row.name}"`);
      }
    }
    this.db.exec("DELETE FROM _tables");
  }

  // ── Table management ───────────────────────────────────────────────────────

  createTable(config: TableConfig): Record<string, unknown> {
    const safe = safeName(config.name);
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS "items_${safe}" (
        pk TEXT NOT NULL,
        sk TEXT NOT NULL DEFAULT '',
        item_json TEXT NOT NULL,
        PRIMARY KEY (pk, sk)
      );
    `);

    // Create GSI tables
    for (const gsi of config.gsis) {
      const gsiSafe = safeName(gsi.name);
      this.db.exec(`
        CREATE TABLE IF NOT EXISTS "gsi_${safe}_${gsiSafe}" (
          pk TEXT NOT NULL,
          sk TEXT NOT NULL DEFAULT '',
          item_json TEXT NOT NULL,
          PRIMARY KEY (pk, sk)
        );
      `);
    }

    this.db
      .prepare("INSERT OR REPLACE INTO _tables (name, config_json) VALUES (?, ?)")
      .run(config.name, JSON.stringify(config));

    return this._tableDescription(config);
  }

  deleteTable(tableName: string): Record<string, unknown> {
    const config = this._getConfig(tableName);
    const safe = safeName(tableName);
    this.db.exec(`DROP TABLE IF EXISTS "items_${safe}"`);
    this.db.prepare("DELETE FROM _tables WHERE name = ?").run(tableName);
    return this._tableDescription(config);
  }

  describeTable(tableName: string): Record<string, unknown> {
    const config = this._getConfig(tableName);
    return { Table: this._tableDescription(config) };
  }

  listTables(): string[] {
    const rows = this.db.prepare("SELECT name FROM _tables ORDER BY name").all() as Array<{
      name: string;
    }>;
    return rows.map((r) => r.name);
  }

  tableExists(tableName: string): boolean {
    const row = this.db.prepare("SELECT name FROM _tables WHERE name = ?").get(tableName) as
      | { name: string }
      | undefined;
    return row !== undefined;
  }

  // ── Item operations ───────────────────────────────────────────────────────

  getItem(tableName: string, key: Record<string, unknown>): Record<string, unknown> | null {
    const config = this._getConfig(tableName);
    const pkVal = extractKeyValue(key, config.pk.name);
    const skVal = config.sk ? extractKeyValue(key, config.sk.name) : "";
    const safe = safeName(tableName);
    const row = this.db
      .prepare(`SELECT item_json FROM "items_${safe}" WHERE pk = ? AND sk = ?`)
      .get(pkVal, skVal) as { item_json: string } | undefined;
    return row ? JSON.parse(row.item_json) : null;
  }

  putItem(tableName: string, item: Record<string, unknown>): void {
    const config = this._getConfig(tableName);
    const normalized = toDynamoItem(item);
    const pkVal = extractKeyValue(normalized, config.pk.name);
    const skVal = config.sk ? extractKeyValue(normalized, config.sk.name) : "";
    const safe = safeName(tableName);
    this.db
      .prepare(`INSERT OR REPLACE INTO "items_${safe}" (pk, sk, item_json) VALUES (?, ?, ?)`)
      .run(pkVal, skVal, JSON.stringify(normalized));
    this._updateGsis(config, normalized, "put");
  }

  deleteItem(tableName: string, key: Record<string, unknown>): void {
    const config = this._getConfig(tableName);
    const pkVal = extractKeyValue(key, config.pk.name);
    const skVal = config.sk ? extractKeyValue(key, config.sk.name) : "";
    const safe = safeName(tableName);
    this.db.prepare(`DELETE FROM "items_${safe}" WHERE pk = ? AND sk = ?`).run(pkVal, skVal);
    this._updateGsis(config, key, "delete");
  }

  updateItem(
    tableName: string,
    key: Record<string, unknown>,
    updateExpr: string,
    names: ExprNames,
    values: ExprValues,
  ): Record<string, unknown> {
    const existing = this.getItem(tableName, key) ?? toDynamoItem(key);
    const existingPlain = fromDynamoItem(existing as Record<string, unknown>);
    const updated = applyUpdateExpression(existingPlain, updateExpr, names, values);
    const updatedDynamo = toDynamoItem(updated);
    // Preserve key attributes from the original key
    const config = this._getConfig(tableName);
    if (!updatedDynamo[config.pk.name]) {
      updatedDynamo[config.pk.name] = existing[config.pk.name];
    }
    if (config.sk && !updatedDynamo[config.sk.name]) {
      updatedDynamo[config.sk.name] = existing[config.sk.name];
    }
    this.putItem(tableName, updatedDynamo);
    return updatedDynamo;
  }

  query(
    tableName: string,
    keyCondition: string,
    names: ExprNames,
    values: ExprValues,
    indexName?: string,
    filterExpression?: string,
    scanIndexForward: boolean = true,
    limit?: number,
    exclusiveStartKey?: Record<string, unknown>,
  ): { items: Array<Record<string, unknown>>; lastEvaluatedKey?: Record<string, unknown> } {
    const config = this._getConfig(tableName);
    const safe = safeName(tableName);

    let tableSql: string;
    if (indexName) {
      const gsiSafe = safeName(indexName);
      tableSql = `"gsi_${safe}_${gsiSafe}"`;
    } else {
      tableSql = `"items_${safe}"`;
    }

    const { where, params } = parseKeyCondition(keyCondition, names, values);
    const order = scanIndexForward ? "ASC" : "DESC";
    const rows = this.db
      .prepare(`SELECT item_json FROM ${tableSql} WHERE ${where} ORDER BY pk ${order}, sk ${order}`)
      .all(...params) as Array<{ item_json: string }>;

    let items = rows.map((r) => JSON.parse(r.item_json) as Record<string, unknown>);

    // Apply filter expression
    if (filterExpression) {
      const plainValues = values
        ? Object.fromEntries(Object.entries(values).map(([k, v]) => [k, v]))
        : undefined;
      items = items.filter((item) => {
        const plain = fromDynamoItem(item);
        return evaluateFilter(plain, filterExpression, names, plainValues as ExprValues);
      });
    }

    // Handle pagination
    if (exclusiveStartKey) {
      const startPk = extractKeyValue(exclusiveStartKey, config.pk.name);
      const startSk = config.sk ? extractKeyValue(exclusiveStartKey, config.sk.name) : "";
      const idx = items.findIndex((item) => {
        const pk = extractKeyValue(item, config.pk.name);
        const sk = config.sk ? extractKeyValue(item, config.sk.name) : "";
        return pk === startPk && sk === startSk;
      });
      if (idx >= 0) items = items.slice(idx + 1);
    }

    let lastEvaluatedKey: Record<string, unknown> | undefined;
    if (limit && items.length > limit) {
      const lastItem = items[limit - 1];
      lastEvaluatedKey = {};
      lastEvaluatedKey[config.pk.name] = lastItem[config.pk.name];
      if (config.sk) lastEvaluatedKey[config.sk.name] = lastItem[config.sk.name];
      items = items.slice(0, limit);
    }

    return { items, lastEvaluatedKey };
  }

  scan(
    tableName: string,
    filterExpression?: string,
    names?: ExprNames,
    values?: ExprValues,
    limit?: number,
    exclusiveStartKey?: Record<string, unknown>,
  ): { items: Array<Record<string, unknown>>; lastEvaluatedKey?: Record<string, unknown> } {
    const config = this._getConfig(tableName);
    const safe = safeName(tableName);
    const rows = this.db
      .prepare(`SELECT item_json FROM "items_${safe}" ORDER BY pk, sk`)
      .all() as Array<{ item_json: string }>;

    let items = rows.map((r) => JSON.parse(r.item_json) as Record<string, unknown>);

    if (filterExpression) {
      items = items.filter((item) => {
        const plain = fromDynamoItem(item);
        return evaluateFilter(plain, filterExpression, names, values);
      });
    }

    if (exclusiveStartKey) {
      const startPk = extractKeyValue(exclusiveStartKey, config.pk.name);
      const startSk = config.sk ? extractKeyValue(exclusiveStartKey, config.sk.name) : "";
      const idx = items.findIndex((item) => {
        const pk = extractKeyValue(item, config.pk.name);
        const sk = config.sk ? extractKeyValue(item, config.sk.name) : "";
        return pk === startPk && sk === startSk;
      });
      if (idx >= 0) items = items.slice(idx + 1);
    }

    let lastEvaluatedKey: Record<string, unknown> | undefined;
    if (limit && items.length > limit) {
      const lastItem = items[limit - 1];
      lastEvaluatedKey = {};
      lastEvaluatedKey[config.pk.name] = lastItem[config.pk.name];
      if (config.sk) lastEvaluatedKey[config.sk.name] = lastItem[config.sk.name];
      items = items.slice(0, limit);
    }

    return { items, lastEvaluatedKey };
  }

  batchGetItems(
    tableName: string,
    keys: Array<Record<string, unknown>>,
  ): Array<Record<string, unknown>> {
    return keys.map((key) => this.getItem(tableName, key)).filter(Boolean) as Array<
      Record<string, unknown>
    >;
  }

  batchWriteItems(
    tableName: string,
    putItems: Array<Record<string, unknown>>,
    deleteKeys: Array<Record<string, unknown>>,
  ): void {
    for (const item of putItems) this.putItem(tableName, item);
    for (const key of deleteKeys) this.deleteItem(tableName, key);
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  private _getConfig(tableName: string): TableConfig {
    const row = this.db.prepare("SELECT config_json FROM _tables WHERE name = ?").get(tableName) as
      | { config_json: string }
      | undefined;
    if (!row) throw new Error(`ResourceNotFoundException: Table ${tableName} not found`);
    return JSON.parse(row.config_json) as TableConfig;
  }

  private _updateGsis(
    config: TableConfig,
    item: Record<string, unknown>,
    op: "put" | "delete",
  ): void {
    const safe = safeName(config.name);
    for (const gsi of config.gsis) {
      const gsiSafe = safeName(gsi.name);
      const normalized = toDynamoItem(item);
      const pkVal = extractKeyValue(normalized, gsi.pk.name);
      if (!pkVal) continue;
      const skVal = gsi.sk ? extractKeyValue(normalized, gsi.sk.name) : "";

      if (op === "put") {
        this.db
          .prepare(
            `INSERT OR REPLACE INTO "gsi_${safe}_${gsiSafe}" (pk, sk, item_json) VALUES (?, ?, ?)`,
          )
          .run(pkVal, skVal, JSON.stringify(normalized));
      } else {
        this.db
          .prepare(`DELETE FROM "gsi_${safe}_${gsiSafe}" WHERE pk = ? AND sk = ?`)
          .run(pkVal, skVal);
      }
    }
  }

  private _tableDescription(config: TableConfig): Record<string, unknown> {
    const keySchema: Array<Record<string, string>> = [
      { AttributeName: config.pk.name, KeyType: "HASH" },
    ];
    const attrDefs: Array<Record<string, string>> = [
      { AttributeName: config.pk.name, AttributeType: config.pk.type },
    ];
    if (config.sk) {
      keySchema.push({ AttributeName: config.sk.name, KeyType: "RANGE" });
      attrDefs.push({ AttributeName: config.sk.name, AttributeType: config.sk.type });
    }

    const nowEpoch = Date.now() / 1000;
    return {
      TableName: config.name,
      TableStatus: "ACTIVE",
      KeySchema: keySchema,
      AttributeDefinitions: attrDefs,
      BillingModeSummary: {
        BillingMode: "PAY_PER_REQUEST",
        LastUpdateToPayPerRequestDateTime: nowEpoch,
      },
      ProvisionedThroughput: {
        NumberOfDecreasesToday: 0,
        ReadCapacityUnits: 0,
        WriteCapacityUnits: 0,
        LastIncreaseDateTime: nowEpoch,
        LastDecreaseDateTime: nowEpoch,
      },
      TableArn: `arn:aws:dynamodb:us-east-1:000000000000:table/${config.name}`,
      ItemCount: 0,
      TableSizeBytes: 0,
      CreationDateTime: nowEpoch,
      GlobalSecondaryIndexes: config.gsis.map((gsi) => ({
        IndexName: gsi.name,
        KeySchema: [
          { AttributeName: gsi.pk.name, KeyType: "HASH" },
          ...(gsi.sk ? [{ AttributeName: gsi.sk.name, KeyType: "RANGE" }] : []),
        ],
        Projection: { ProjectionType: gsi.projectionType },
        IndexStatus: "ACTIVE",
        IndexArn: `arn:aws:dynamodb:us-east-1:000000000000:table/${config.name}/index/${gsi.name}`,
        ProvisionedThroughput: {
          NumberOfDecreasesToday: 0,
          ReadCapacityUnits: 0,
          WriteCapacityUnits: 0,
        },
        ItemCount: 0,
        IndexSizeBytes: 0,
      })),
    };
  }
}

function safeName(name: string): string {
  return name.replace(/[^a-zA-Z0-9_]/g, "_");
}
