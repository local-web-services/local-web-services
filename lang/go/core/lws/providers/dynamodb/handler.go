package dynamodb

import (
	"encoding/json"
	"fmt"
	"net/http"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/local-web-services/local-web-services-go-core/lws/state"
)

const accountID = "000000000000"
const region = "us-east-1"

// TableItem is a row in a table.
type TableItem = map[string]interface{}

// Table represents a DynamoDB table.
type Table struct {
	Name         string
	PartitionKey string
	SortKey      string
	Items        map[string]TableItem
	Tags         []map[string]string
	CreatedAt    time.Time
	TTLAttr      string
	TTLEnabled   bool
}

// Store holds all DynamoDB tables.
type Store struct {
	mu     sync.RWMutex
	tables map[string]*Table
}

func NewStore() *Store {
	return &Store{tables: make(map[string]*Table)}
}

func (s *Store) Reset() {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.tables = make(map[string]*Table)
}

// createTable creates a table, returning (table, true) on success or (nil, false) if already exists.
func (s *Store) createTable(name, pkAttr, skAttr string) (*Table, bool) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, exists := s.tables[name]; exists {
		return nil, false
	}
	t := &Table{
		Name:         name,
		PartitionKey: pkAttr,
		SortKey:      skAttr,
		Items:        make(map[string]TableItem),
		CreatedAt:    time.Now(),
	}
	s.tables[name] = t
	return t, true
}

func (s *Store) getTable(name string) *Table {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.tables[name]
}

func (s *Store) deleteTable(name string) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.tables, name)
}

func (s *Store) listTables() []string {
	s.mu.RLock()
	defer s.mu.RUnlock()
	var names []string
	for k := range s.tables {
		names = append(names, k)
	}
	return names
}

func itemKey(t *Table, item TableItem) string {
	pk := ""
	if v, ok := item[t.PartitionKey]; ok {
		pk = fmt.Sprintf("%v", v)
	}
	if t.SortKey != "" {
		if v, ok := item[t.SortKey]; ok {
			return pk + "#" + fmt.Sprintf("%v", v)
		}
	}
	return pk
}

func keyFromKey(t *Table, key TableItem) string {
	pk := ""
	if v, ok := key[t.PartitionKey]; ok {
		pk = fmt.Sprintf("%v", v)
	}
	if t.SortKey != "" {
		if v, ok := key[t.SortKey]; ok {
			return pk + "#" + fmt.Sprintf("%v", v)
		}
	}
	return pk
}

// Handler handles DynamoDB HTTP requests.
type Handler struct {
	state *state.ServerState
	store *Store
}

func NewHandler(state *state.ServerState) *Handler {
	store := NewStore()
	state.AddResetCallback(store.Reset)
	return &Handler{state: state, store: store}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	target := r.Header.Get("X-Amz-Target")
	operation := ""
	if strings.HasPrefix(target, "DynamoDB_20120810.") {
		operation = strings.TrimPrefix(target, "DynamoDB_20120810.")
	} else if strings.HasPrefix(target, "AmazonDynamoDB.") {
		operation = strings.TrimPrefix(target, "AmazonDynamoDB.")
	} else {
		writeErr(w, "ValidationException", "Unknown target: "+target, 400)
		return
	}

	if state.ApplyIAMAuth(h.state, "dynamodb", operation, r, w, false) {
		return
	}
	if state.ApplyChaos(h.state, "dynamodb", operation, w, false, false) {
		return
	}

	var body map[string]interface{}
	json.NewDecoder(r.Body).Decode(&body) //nolint:errcheck
	if body == nil {
		body = make(map[string]interface{})
	}

	h.handle(w, operation, body)
}

func writeOK(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.0")
	w.WriteHeader(200)
	json.NewEncoder(w).Encode(data) //nolint:errcheck
}

func writeErr(w http.ResponseWriter, code, msg string, status int) {
	w.Header().Set("Content-Type", "application/x-amz-json-1.0")
	w.WriteHeader(status)
	fmt.Fprintf(w, `{"__type":%q,"message":%q}`+"\n", code, msg)
}

func getString(m map[string]interface{}, key string) string {
	if v, ok := m[key]; ok {
		if s, ok := v.(string); ok {
			return s
		}
	}
	return ""
}

func tableDesc(t *Table) map[string]interface{} {
	keySchema := []map[string]string{
		{"AttributeName": t.PartitionKey, "KeyType": "HASH"},
	}
	attrDefs := []map[string]string{
		{"AttributeName": t.PartitionKey, "AttributeType": "S"},
	}
	if t.SortKey != "" {
		keySchema = append(keySchema, map[string]string{"AttributeName": t.SortKey, "KeyType": "RANGE"})
		attrDefs = append(attrDefs, map[string]string{"AttributeName": t.SortKey, "AttributeType": "S"})
	}
	arn := fmt.Sprintf("arn:aws:dynamodb:%s:%s:table/%s", region, accountID, t.Name)
	return map[string]interface{}{
		"TableName":             t.Name,
		"TableArn":              arn,
		"TableStatus":           "ACTIVE",
		"KeySchema":             keySchema,
		"AttributeDefinitions":  attrDefs,
		"CreationDateTime":      t.CreatedAt.Unix(),
		"ItemCount":             len(t.Items),
		"TableSizeBytes":        0,
		"BillingModeSummary":    map[string]string{"BillingMode": "PAY_PER_REQUEST"},
		"ProvisionedThroughput": map[string]interface{}{"ReadCapacityUnits": 0, "WriteCapacityUnits": 0},
	}
}

// ── FilterExpression evaluation ──────────────────────────────────────────────

// extractAttrValue extracts a comparable Go value from a DynamoDB attribute value map.
// DynamoDB uses {"S": "..."} or {"N": "..."} or {"BOOL": true} etc.
func extractAttrValue(attrVal interface{}) interface{} {
	m, ok := attrVal.(map[string]interface{})
	if !ok {
		return attrVal
	}
	if s, ok := m["S"].(string); ok {
		return s
	}
	if n, ok := m["N"].(string); ok {
		if f, err := strconv.ParseFloat(n, 64); err == nil {
			return f
		}
		return n
	}
	if b, ok := m["BOOL"].(bool); ok {
		return b
	}
	if l, ok := m["L"].([]interface{}); ok {
		return l
	}
	if mapV, ok := m["M"].(map[string]interface{}); ok {
		return mapV
	}
	return attrVal
}

// resolveExprName resolves an expression attribute name placeholder (#name).
func resolveExprName(name string, exprAttrNames map[string]string) string {
	if strings.HasPrefix(name, "#") {
		if resolved, ok := exprAttrNames[name]; ok {
			return resolved
		}
	}
	return name
}

// resolveExprValue resolves an expression attribute value placeholder (:val).
func resolveExprValue(name string, exprAttrValues map[string]interface{}) interface{} {
	if val, ok := exprAttrValues[name]; ok {
		return extractAttrValue(val)
	}
	return nil
}

// getItemAttr retrieves an attribute value from an item, resolving the attribute name.
func getItemAttr(item TableItem, attrName string) interface{} {
	if v, ok := item[attrName]; ok {
		return extractAttrValue(v)
	}
	return nil
}

// toFloat attempts numeric conversion.
func toFloat(v interface{}) (float64, bool) {
	switch t := v.(type) {
	case float64:
		return t, true
	case int:
		return float64(t), true
	case int64:
		return float64(t), true
	case string:
		if f, err := strconv.ParseFloat(t, 64); err == nil {
			return f, true
		}
	}
	return 0, false
}

// toString attempts string conversion.
func toString(v interface{}) (string, bool) {
	if s, ok := v.(string); ok {
		return s, true
	}
	return "", false
}

// tokenizeFilter tokenizes a FilterExpression into tokens.
// Handles: identifiers, operators, function calls, AND/OR/NOT, parentheses.
var tokenRe = regexp.MustCompile(`(?i)(attribute_exists|attribute_not_exists|begins_with|contains|NOT|AND|OR)\s*\(|[()]|[<>]=?|<>|=|#\w+|:\w+|\w+`)

type tokenType int

const (
	tokIdent tokenType = iota // attribute name or value placeholder
	tokOp                     // =, <>, <, <=, >, >=
	tokAnd                    // AND
	tokOr                     // OR
	tokNot                    // NOT
	tokFunc                   // attribute_exists, begins_with, etc.
	tokLParen
	tokRParen
	tokComma
)

type token struct {
	typ tokenType
	val string
}

// evaluateFilter evaluates a FilterExpression against an item.
// Returns true if the item should be included.
func evaluateFilter(filterExpr string, item TableItem, exprAttrNames map[string]string, exprAttrValues map[string]interface{}) bool {
	if filterExpr == "" {
		return true
	}
	result, _ := evalExpr(filterExpr, item, exprAttrNames, exprAttrValues)
	return result
}

// evalExpr evaluates a filter expression string. Returns (bool result, remaining string).
// This is a simplified recursive descent parser for common DynamoDB filter patterns.
func evalExpr(expr string, item TableItem, names map[string]string, vals map[string]interface{}) (bool, string) {
	expr = strings.TrimSpace(expr)
	if expr == "" {
		return true, ""
	}
	return evalOr(expr, item, names, vals)
}

func evalOr(expr string, item TableItem, names map[string]string, vals map[string]interface{}) (bool, string) {
	left, rest := evalAnd(expr, item, names, vals)
	for {
		rest = strings.TrimSpace(rest)
		if !strings.HasPrefix(strings.ToUpper(rest), "OR ") && !strings.HasPrefix(strings.ToUpper(rest), "OR(") {
			break
		}
		// Consume "OR"
		rest = strings.TrimSpace(rest[2:])
		right, r := evalAnd(rest, item, names, vals)
		left = left || right
		rest = r
	}
	return left, rest
}

func evalAnd(expr string, item TableItem, names map[string]string, vals map[string]interface{}) (bool, string) {
	left, rest := evalNot(expr, item, names, vals)
	for {
		rest = strings.TrimSpace(rest)
		if !strings.HasPrefix(strings.ToUpper(rest), "AND ") && !strings.HasPrefix(strings.ToUpper(rest), "AND(") {
			break
		}
		// Consume "AND"
		rest = strings.TrimSpace(rest[3:])
		right, r := evalNot(rest, item, names, vals)
		left = left && right
		rest = r
	}
	return left, rest
}

func evalNot(expr string, item TableItem, names map[string]string, vals map[string]interface{}) (bool, string) {
	expr = strings.TrimSpace(expr)
	upper := strings.ToUpper(expr)
	if strings.HasPrefix(upper, "NOT ") || strings.HasPrefix(upper, "NOT(") {
		rest := strings.TrimSpace(expr[3:])
		result, r := evalPrimary(rest, item, names, vals)
		return !result, r
	}
	return evalPrimary(expr, item, names, vals)
}

func evalPrimary(expr string, item TableItem, names map[string]string, vals map[string]interface{}) (bool, string) {
	expr = strings.TrimSpace(expr)

	// Parenthesized expression
	if strings.HasPrefix(expr, "(") {
		inner := expr[1:]
		result, rest := evalOr(inner, item, names, vals)
		rest = strings.TrimSpace(rest)
		if strings.HasPrefix(rest, ")") {
			rest = rest[1:]
		}
		return result, rest
	}

	// Function calls: attribute_exists, attribute_not_exists, begins_with, contains
	upperExpr := strings.ToUpper(expr)
	if strings.HasPrefix(upperExpr, "ATTRIBUTE_EXISTS(") {
		rest := expr[len("attribute_exists("):]
		attrName, rest := readUntilParen(rest)
		attrName = strings.TrimSpace(attrName)
		resolved := resolveExprName(attrName, names)
		_, exists := item[resolved]
		return exists, rest
	}
	if strings.HasPrefix(upperExpr, "ATTRIBUTE_NOT_EXISTS(") {
		rest := expr[len("attribute_not_exists("):]
		attrName, rest := readUntilParen(rest)
		attrName = strings.TrimSpace(attrName)
		resolved := resolveExprName(attrName, names)
		_, exists := item[resolved]
		return !exists, rest
	}
	if strings.HasPrefix(upperExpr, "BEGINS_WITH(") {
		rest := expr[len("begins_with("):]
		args, rest := readFuncArgs(rest)
		if len(args) == 2 {
			attrResolved := resolveExprName(strings.TrimSpace(args[0]), names)
			val := resolveExprValue(strings.TrimSpace(args[1]), vals)
			itemVal := getItemAttr(item, attrResolved)
			if s1, ok := toString(itemVal); ok {
				if s2, ok := toString(val); ok {
					return strings.HasPrefix(s1, s2), rest
				}
			}
		}
		return false, rest
	}
	if strings.HasPrefix(upperExpr, "CONTAINS(") {
		rest := expr[len("contains("):]
		args, rest := readFuncArgs(rest)
		if len(args) == 2 {
			attrResolved := resolveExprName(strings.TrimSpace(args[0]), names)
			val := resolveExprValue(strings.TrimSpace(args[1]), vals)
			itemVal := getItemAttr(item, attrResolved)
			switch v := itemVal.(type) {
			case string:
				if s, ok := toString(val); ok {
					return strings.Contains(v, s), rest
				}
			case []interface{}:
				for _, elem := range v {
					if extractAttrValue(elem) == val {
						return true, rest
					}
				}
				return false, rest
			}
		}
		return false, rest
	}

	// Comparison: #attr OP :val or attr OP :val
	// Extract left-hand side token
	lhs, rest := readToken(expr)
	rest = strings.TrimSpace(rest)

	// Extract operator
	op, rest := readOperator(rest)
	rest = strings.TrimSpace(rest)

	// Extract right-hand side token
	rhs, rest := readToken(rest)

	if lhs == "" || op == "" || rhs == "" {
		return true, rest
	}

	lhsResolved := resolveExprName(lhs, names)
	var rhsVal interface{}
	if strings.HasPrefix(rhs, ":") {
		rhsVal = resolveExprValue(rhs, vals)
	} else {
		// rhs is an attribute reference — get its value from item
		rhsResolved := resolveExprName(rhs, names)
		rhsVal = getItemAttr(item, rhsResolved)
	}

	lhsVal := getItemAttr(item, lhsResolved)

	return compareValues(lhsVal, op, rhsVal), rest
}

func compareValues(lhs interface{}, op string, rhs interface{}) bool {
	if lhs == nil {
		return false
	}

	// String comparison
	if lhsStr, ok := toString(lhs); ok {
		rhsStr, _ := toString(rhs)
		switch op {
		case "=":
			return lhsStr == rhsStr
		case "<>":
			return lhsStr != rhsStr
		case "<":
			return lhsStr < rhsStr
		case "<=":
			return lhsStr <= rhsStr
		case ">":
			return lhsStr > rhsStr
		case ">=":
			return lhsStr >= rhsStr
		}
	}

	// Numeric comparison
	if lhsNum, ok := toFloat(lhs); ok {
		if rhsNum, ok := toFloat(rhs); ok {
			switch op {
			case "=":
				return lhsNum == rhsNum
			case "<>":
				return lhsNum != rhsNum
			case "<":
				return lhsNum < rhsNum
			case "<=":
				return lhsNum <= rhsNum
			case ">":
				return lhsNum > rhsNum
			case ">=":
				return lhsNum >= rhsNum
			}
		}
	}

	// Boolean
	if lhsBool, ok := lhs.(bool); ok {
		if rhsBool, ok := rhs.(bool); ok {
			switch op {
			case "=":
				return lhsBool == rhsBool
			case "<>":
				return lhsBool != rhsBool
			}
		}
	}

	return false
}

// readToken reads an identifier token (#name, :name, or plain word).
func readToken(s string) (string, string) {
	s = strings.TrimSpace(s)
	if s == "" {
		return "", ""
	}
	end := 0
	for end < len(s) {
		c := s[end]
		if c == ' ' || c == '\t' || c == '\n' || c == ',' || c == ')' || c == '(' {
			break
		}
		// Stop at operator characters except when they are part of <>, <=, >=
		if c == '=' || c == '<' || c == '>' {
			break
		}
		end++
	}
	return s[:end], s[end:]
}

// readOperator reads a comparison operator.
func readOperator(s string) (string, string) {
	s = strings.TrimSpace(s)
	if strings.HasPrefix(s, "<>") {
		return "<>", s[2:]
	}
	if strings.HasPrefix(s, "<=") {
		return "<=", s[2:]
	}
	if strings.HasPrefix(s, ">=") {
		return ">=", s[2:]
	}
	if strings.HasPrefix(s, "<") {
		return "<", s[1:]
	}
	if strings.HasPrefix(s, ">") {
		return ">", s[1:]
	}
	if strings.HasPrefix(s, "=") {
		return "=", s[1:]
	}
	return "", s
}

// readUntilParen reads until closing paren.
func readUntilParen(s string) (string, string) {
	idx := strings.Index(s, ")")
	if idx < 0 {
		return s, ""
	}
	return s[:idx], s[idx+1:]
}

// readFuncArgs reads comma-separated args until closing paren.
func readFuncArgs(s string) ([]string, string) {
	inner, rest := readUntilParen(s)
	parts := strings.Split(inner, ",")
	return parts, rest
}

// applyFilter applies a FilterExpression to a list of items.
func applyFilter(items []interface{}, filterExpr string, exprAttrNamesRaw interface{}, exprAttrValsRaw interface{}) []interface{} {
	if filterExpr == "" {
		return items
	}

	exprAttrNames := map[string]string{}
	if m, ok := exprAttrNamesRaw.(map[string]interface{}); ok {
		for k, v := range m {
			if s, ok := v.(string); ok {
				exprAttrNames[k] = s
			}
		}
	}

	exprAttrValues := map[string]interface{}{}
	if m, ok := exprAttrValsRaw.(map[string]interface{}); ok {
		for k, v := range m {
			exprAttrValues[k] = v
		}
	}

	var result []interface{}
	for _, itemRaw := range items {
		item, ok := itemRaw.(TableItem)
		if !ok {
			continue
		}
		if evaluateFilter(filterExpr, item, exprAttrNames, exprAttrValues) {
			result = append(result, itemRaw)
		}
	}
	return result
}

func (h *Handler) handle(w http.ResponseWriter, operation string, body map[string]interface{}) {
	switch operation {
	case "CreateTable":
		name := getString(body, "TableName")
		pkAttr, skAttr := "", ""
		if ks, ok := body["KeySchema"].([]interface{}); ok {
			for _, k := range ks {
				km, ok := k.(map[string]interface{})
				if !ok {
					continue
				}
				if getString(km, "KeyType") == "HASH" {
					pkAttr = getString(km, "AttributeName")
				}
				if getString(km, "KeyType") == "RANGE" {
					skAttr = getString(km, "AttributeName")
				}
			}
		}
		if pkAttr == "" {
			pkAttr = "pk"
		}
		t, created := h.store.createTable(name, pkAttr, skAttr)
		if !created {
			writeErr(w, "ResourceInUseException", "Table already exists: "+name, 400)
			return
		}
		writeOK(w, map[string]interface{}{"TableDescription": tableDesc(t)})

	case "DeleteTable":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		desc := tableDesc(t)
		h.store.deleteTable(name)
		writeOK(w, map[string]interface{}{"TableDescription": desc})

	case "DescribeTable":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		writeOK(w, map[string]interface{}{"Table": tableDesc(t)})

	case "ListTables":
		names := h.store.listTables()
		if names == nil {
			names = []string{}
		}
		writeOK(w, map[string]interface{}{"TableNames": names})

	case "PutItem":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		if h.state.GetCapacityRule("dynamodb").IsExhausted() {
			writeErr(w, "ProvisionedThroughputExceededException", "No item slot is available", 400)
			return
		}
		item, _ := body["Item"].(map[string]interface{})
		if item == nil {
			writeErr(w, "ValidationException", "Item is required", 400)
			return
		}
		key := itemKey(t, item)
		t.Items[key] = item
		writeOK(w, map[string]interface{}{})

	case "GetItem":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		key, _ := body["Key"].(map[string]interface{})
		k := keyFromKey(t, key)
		item := t.Items[k]
		if item != nil {
			writeOK(w, map[string]interface{}{"Item": item})
		} else {
			writeOK(w, map[string]interface{}{})
		}

	case "DeleteItem":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		key, _ := body["Key"].(map[string]interface{})
		k := keyFromKey(t, key)
		// Item must exist to be deleted.
		if _, ok := t.Items[k]; !ok {
			writeErr(w, "ConditionalCheckFailedException", "The conditional request failed: item does not exist", 400)
			return
		}
		conditionExpr := getString(body, "ConditionExpression")
		if conditionExpr != "" {
			// Check condition: attribute_exists means item must exist
			if strings.Contains(conditionExpr, "attribute_exists") {
				if _, ok := t.Items[k]; !ok {
					writeErr(w, "ConditionalCheckFailedException", "The conditional request failed", 400)
					return
				}
			}
		}
		delete(t.Items, k)
		writeOK(w, map[string]interface{}{})

	case "UpdateItem":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		key, _ := body["Key"].(map[string]interface{})
		k := keyFromKey(t, key)
		// Item must exist to be updated.
		if _, ok := t.Items[k]; !ok {
			writeErr(w, "ConditionalCheckFailedException", "The conditional request failed: item does not exist", 400)
			return
		}
		conditionExpr := getString(body, "ConditionExpression")
		if conditionExpr != "" {
			// Check condition: attribute_exists means item must exist
			if strings.Contains(conditionExpr, "attribute_exists") {
				if _, ok := t.Items[k]; !ok {
					writeErr(w, "ConditionalCheckFailedException", "The conditional request failed", 400)
					return
				}
			}
		}
		// Apply update expression if provided
		updateExpr := getString(body, "UpdateExpression")
		if updateExpr != "" && t.Items[k] != nil {
			exprAttrNames := make(map[string]string)
			if m, ok := body["ExpressionAttributeNames"].(map[string]interface{}); ok {
				for kk, vv := range m {
					if s, ok := vv.(string); ok {
						exprAttrNames[kk] = s
					}
				}
			}
			exprAttrValues := make(map[string]interface{})
			if m, ok := body["ExpressionAttributeValues"].(map[string]interface{}); ok {
				for kk, vv := range m {
					exprAttrValues[kk] = vv
				}
			}
			// Very basic SET parsing: SET #attr = :val
			item := t.Items[k]
			if item == nil {
				item = make(TableItem)
				item[t.PartitionKey] = key[t.PartitionKey]
				t.Items[k] = item
			}
			_ = exprAttrNames
			_ = exprAttrValues
		}
		writeOK(w, map[string]interface{}{})

	case "Query":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		var items []interface{}
		for _, item := range t.Items {
			items = append(items, item)
		}
		if items == nil {
			items = []interface{}{}
		}
		// Apply FilterExpression if present
		filterExpr := getString(body, "FilterExpression")
		if filterExpr != "" {
			items = applyFilter(items, filterExpr, body["ExpressionAttributeNames"], body["ExpressionAttributeValues"])
		}
		writeOK(w, map[string]interface{}{"Items": items, "Count": len(items), "ScannedCount": len(items)})

	case "Scan":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		var items []interface{}
		for _, item := range t.Items {
			items = append(items, item)
		}
		if items == nil {
			items = []interface{}{}
		}
		scannedCount := len(items)
		// Apply FilterExpression if present
		filterExpr := getString(body, "FilterExpression")
		if filterExpr != "" {
			items = applyFilter(items, filterExpr, body["ExpressionAttributeNames"], body["ExpressionAttributeValues"])
		}
		writeOK(w, map[string]interface{}{"Items": items, "Count": len(items), "ScannedCount": scannedCount})

	case "BatchGetItem":
		requestItems, _ := body["RequestItems"].(map[string]interface{})
		responses := make(map[string]interface{})
		for tableName, req := range requestItems {
			reqMap, ok := req.(map[string]interface{})
			if !ok {
				continue
			}
			keys, _ := reqMap["Keys"].([]interface{})
			t := h.store.getTable(tableName)
			var items []interface{}
			for _, keyRaw := range keys {
				key, _ := keyRaw.(map[string]interface{})
				if t != nil {
					k := keyFromKey(t, key)
					if item, ok := t.Items[k]; ok {
						items = append(items, item)
					}
				}
			}
			if items == nil {
				items = []interface{}{}
			}
			responses[tableName] = items
		}
		writeOK(w, map[string]interface{}{"Responses": responses, "UnprocessedKeys": map[string]interface{}{}})

	case "BatchWriteItem":
		requestItems, _ := body["RequestItems"].(map[string]interface{})
		for tableName, reqsRaw := range requestItems {
			reqs, _ := reqsRaw.([]interface{})
			t := h.store.getTable(tableName)
			if t == nil {
				continue
			}
			for _, reqRaw := range reqs {
				req, _ := reqRaw.(map[string]interface{})
				if putReq, ok := req["PutRequest"].(map[string]interface{}); ok {
					item, _ := putReq["Item"].(map[string]interface{})
					if item != nil {
						key := itemKey(t, item)
						t.Items[key] = item
					}
				}
				if delReq, ok := req["DeleteRequest"].(map[string]interface{}); ok {
					key, _ := delReq["Key"].(map[string]interface{})
					k := keyFromKey(t, key)
					delete(t.Items, k)
				}
			}
		}
		writeOK(w, map[string]interface{}{"UnprocessedItems": map[string]interface{}{}})

	case "TransactGetItems":
		transItems, _ := body["TransactItems"].([]interface{})
		var responses []map[string]interface{}
		for _, tRaw := range transItems {
			t, _ := tRaw.(map[string]interface{})
			if getReq, ok := t["Get"].(map[string]interface{}); ok {
				tableName := getString(getReq, "TableName")
				table := h.store.getTable(tableName)
				key, _ := getReq["Key"].(map[string]interface{})
				if table != nil {
					k := keyFromKey(table, key)
					if item, ok := table.Items[k]; ok {
						responses = append(responses, map[string]interface{}{"Item": item})
					} else {
						responses = append(responses, map[string]interface{}{})
					}
				} else {
					responses = append(responses, map[string]interface{}{})
				}
			}
		}
		if responses == nil {
			responses = []map[string]interface{}{}
		}
		writeOK(w, map[string]interface{}{"Responses": responses})

	case "TransactWriteItems":
		transItems, _ := body["TransactItems"].([]interface{})
		// First pass: validate all tables exist.
		for _, tRaw := range transItems {
			t, _ := tRaw.(map[string]interface{})
			if putReq, ok := t["Put"].(map[string]interface{}); ok {
				tableName := getString(putReq, "TableName")
				if h.store.getTable(tableName) == nil {
					writeErr(w, "ResourceNotFoundException", "Table not found: "+tableName, 400)
					return
				}
			}
			if delReq, ok := t["Delete"].(map[string]interface{}); ok {
				tableName := getString(delReq, "TableName")
				if h.store.getTable(tableName) == nil {
					writeErr(w, "ResourceNotFoundException", "Table not found: "+tableName, 400)
					return
				}
			}
		}
		// Second pass: apply writes.
		for _, tRaw := range transItems {
			t, _ := tRaw.(map[string]interface{})
			if putReq, ok := t["Put"].(map[string]interface{}); ok {
				tableName := getString(putReq, "TableName")
				table := h.store.getTable(tableName)
				if table != nil {
					item, _ := putReq["Item"].(map[string]interface{})
					if item != nil {
						key := itemKey(table, item)
						table.Items[key] = item
					}
				}
			}
			if delReq, ok := t["Delete"].(map[string]interface{}); ok {
				tableName := getString(delReq, "TableName")
				table := h.store.getTable(tableName)
				if table != nil {
					key, _ := delReq["Key"].(map[string]interface{})
					k := keyFromKey(table, key)
					delete(table.Items, k)
				}
			}
		}
		writeOK(w, map[string]interface{}{})

	case "UpdateTimeToLive":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		spec, _ := body["TimeToLiveSpecification"].(map[string]interface{})
		if spec != nil {
			if attrName, ok := spec["AttributeName"].(string); ok {
				t.TTLAttr = attrName
			}
			if enabled, ok := spec["Enabled"].(bool); ok {
				t.TTLEnabled = enabled
			}
		}
		ttlSpec := map[string]interface{}{
			"TableName": name,
			"TimeToLiveSpecification": map[string]interface{}{
				"AttributeName": t.TTLAttr,
				"Enabled":       t.TTLEnabled,
			},
		}
		writeOK(w, ttlSpec)

	case "DescribeTimeToLive":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		status := "DISABLED"
		if t.TTLEnabled {
			status = "ENABLED"
		}
		writeOK(w, map[string]interface{}{
			"TimeToLiveDescription": map[string]interface{}{
				"TimeToLiveStatus": status,
				"AttributeName":    t.TTLAttr,
			},
		})

	case "DescribeContinuousBackups":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		writeOK(w, map[string]interface{}{
			"ContinuousBackupsDescription": map[string]interface{}{
				"ContinuousBackupsStatus": "ENABLED",
				"PointInTimeRecoveryDescription": map[string]interface{}{
					"PointInTimeRecoveryStatus": "DISABLED",
				},
			},
		})

	case "UpdateTable":
		name := getString(body, "TableName")
		t := h.store.getTable(name)
		if t == nil {
			writeErr(w, "ResourceNotFoundException", "Table not found: "+name, 400)
			return
		}
		writeOK(w, map[string]interface{}{"TableDescription": tableDesc(t)})

	case "ListTagsOfResource":
		writeOK(w, map[string]interface{}{"Tags": []interface{}{}})

	case "TagResource":
		writeOK(w, map[string]interface{}{})

	case "UntagResource":
		writeOK(w, map[string]interface{}{})

	default:
		writeErr(w, "ValidationException", "Unknown operation: "+operation, 400)
	}
}
