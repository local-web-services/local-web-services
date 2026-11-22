/**
 * DynamoDB expression evaluation helpers (subset for local testing).
 *
 * Supports:
 *   - UpdateExpression: SET a = :v, REMOVE a
 *   - FilterExpression / ConditionExpression: attribute_exists, attribute_not_exists,
 *     =, <>, <, <=, >, >=, begins_with, contains
 */

import type { DynamoAttributeValue, DynamoItem } from "./table.js";
import { extractScalar } from "./table.js";

export interface ExpressionContext {
  expressionAttributeNames?: Record<string, string> | undefined;
  expressionAttributeValues?: Record<string, DynamoAttributeValue> | undefined;
}

// ------------------------------------------------------------------
// Update expression
// ------------------------------------------------------------------

export function applyUpdateExpression(
  item: DynamoItem,
  expression: string,
  ctx: ExpressionContext,
): DynamoItem {
  const result = { ...item };
  const resolved = resolveNames(expression, ctx.expressionAttributeNames ?? {});

  const setMatch = /SET\s+(.+?)(?=\s+REMOVE\s|$)/i.exec(resolved);
  const removeMatch = /REMOVE\s+(.+?)(?=\s+SET\s|$)/i.exec(resolved);

  if (setMatch !== null) {
    const setClause = setMatch[1]!.trim();
    for (const assignment of setClause.split(",")) {
      const eqIdx = assignment.indexOf("=");
      if (eqIdx === -1) continue;
      const attrName = assignment.slice(0, eqIdx).trim();
      const valToken = assignment.slice(eqIdx + 1).trim();
      const val = resolveValue(valToken, item, ctx.expressionAttributeValues ?? {});
      if (val !== undefined) {
        result[attrName] = val;
      }
    }
  }

  if (removeMatch !== null) {
    const removeClause = removeMatch[1]!.trim();
    for (const attrName of removeClause.split(",")) {
      delete result[attrName.trim()];
    }
  }

  return result;
}

// ------------------------------------------------------------------
// Filter / condition expression
// ------------------------------------------------------------------

export function evaluateFilterExpression(
  item: DynamoItem,
  expression: string,
  ctx: ExpressionContext,
): boolean {
  const resolved = resolveNames(expression, ctx.expressionAttributeNames ?? {});
  const values = ctx.expressionAttributeValues ?? {};
  return evaluateNode(resolved.trim(), item, values);
}

function evaluateNode(expr: string, item: DynamoItem, values: Record<string, DynamoAttributeValue>): boolean {
  // Strip outer parens
  while (expr.startsWith("(") && expr.endsWith(")") && matchingParen(expr, 0) === expr.length - 1) {
    expr = expr.slice(1, -1).trim();
  }

  // AND / OR (low precedence — split from right)
  const andIdx = findLogicalOp(expr, " AND ");
  if (andIdx !== -1) {
    return (
      evaluateNode(expr.slice(0, andIdx).trim(), item, values) &&
      evaluateNode(expr.slice(andIdx + 5).trim(), item, values)
    );
  }

  const orIdx = findLogicalOp(expr, " OR ");
  if (orIdx !== -1) {
    return (
      evaluateNode(expr.slice(0, orIdx).trim(), item, values) ||
      evaluateNode(expr.slice(orIdx + 4).trim(), item, values)
    );
  }

  // NOT
  if (/^NOT\s+/i.test(expr)) {
    return !evaluateNode(expr.slice(4).trim(), item, values);
  }

  // attribute_exists / attribute_not_exists
  const aeMatch = /^attribute_exists\s*\(([^)]+)\)$/i.exec(expr);
  if (aeMatch !== null) return item[aeMatch[1]!.trim()] !== undefined;

  const aneMatch = /^attribute_not_exists\s*\(([^)]+)\)$/i.exec(expr);
  if (aneMatch !== null) return item[aneMatch[1]!.trim()] === undefined;

  // begins_with
  const bwMatch = /^begins_with\s*\(([^,]+),\s*([^)]+)\)$/i.exec(expr);
  if (bwMatch !== null) {
    const attrVal = item[bwMatch[1]!.trim()];
    const prefix = resolveScalar(bwMatch[2]!.trim(), values);
    if (attrVal === undefined) return false;
    return extractScalar(attrVal).startsWith(prefix);
  }

  // contains
  const cMatch = /^contains\s*\(([^,]+),\s*([^)]+)\)$/i.exec(expr);
  if (cMatch !== null) {
    const attrVal = item[cMatch[1]!.trim()];
    const sub = resolveScalar(cMatch[2]!.trim(), values);
    if (attrVal === undefined) return false;
    return extractScalar(attrVal).includes(sub);
  }

  // Comparison operators
  for (const op of ["<>", "<=", ">=", "<", ">", "="]) {
    const idx = expr.indexOf(op);
    if (idx === -1) continue;
    const lhs = expr.slice(0, idx).trim();
    const rhs = expr.slice(idx + op.length).trim();
    const lhsVal = resolveOperand(lhs, item, values);
    const rhsVal = resolveOperand(rhs, item, values);
    if (lhsVal === undefined || rhsVal === undefined) return false;
    return compareValues(lhsVal, op, rhsVal);
  }

  return true;
}

function compareValues(left: DynamoAttributeValue, op: string, right: DynamoAttributeValue): boolean {
  const ls = extractScalar(left);
  const rs = extractScalar(right);

  // Numeric comparison when both sides look numeric
  const ln = Number(ls);
  const rn = Number(rs);
  const useNumeric = !Number.isNaN(ln) && !Number.isNaN(rn);

  switch (op) {
    case "=": return ls === rs;
    case "<>": return ls !== rs;
    case "<": return useNumeric ? ln < rn : ls < rs;
    case "<=": return useNumeric ? ln <= rn : ls <= rs;
    case ">": return useNumeric ? ln > rn : ls > rs;
    case ">=": return useNumeric ? ln >= rn : ls >= rs;
    default: return false;
  }
}

// ------------------------------------------------------------------
// Internal helpers
// ------------------------------------------------------------------

function resolveNames(expr: string, names: Record<string, string>): string {
  return expr.replace(/#[A-Za-z_][A-Za-z0-9_]*/g, (token) => names[token] ?? token);
}

function resolveValue(
  token: string,
  _item: DynamoItem,
  values: Record<string, DynamoAttributeValue>,
): DynamoAttributeValue | undefined {
  if (token.startsWith(":")) return values[token];
  return undefined;
}

function resolveOperand(
  token: string,
  item: DynamoItem,
  values: Record<string, DynamoAttributeValue>,
): DynamoAttributeValue | undefined {
  if (token.startsWith(":")) return values[token];
  return item[token];
}

function resolveScalar(token: string, values: Record<string, DynamoAttributeValue>): string {
  if (token.startsWith(":")) {
    const val = values[token];
    return val !== undefined ? extractScalar(val) : token;
  }
  return token.replace(/^["']|["']$/g, "");
}

function findLogicalOp(expr: string, op: string): number {
  let depth = 0;
  const upper = expr.toUpperCase();
  const target = op.toUpperCase();
  for (let i = 0; i < expr.length; i++) {
    if (expr[i] === "(") depth++;
    else if (expr[i] === ")") depth--;
    else if (depth === 0 && upper.startsWith(target, i)) return i;
  }
  return -1;
}

function matchingParen(expr: string, open: number): number {
  let depth = 0;
  for (let i = open; i < expr.length; i++) {
    if (expr[i] === "(") depth++;
    else if (expr[i] === ")") {
      depth--;
      if (depth === 0) return i;
    }
  }
  return -1;
}
