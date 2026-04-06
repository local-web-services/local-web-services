# Spec: DynamoDB Scan FilterExpression

## MODIFIED Requirements

### Requirement: scan-filter-expression-match
The DynamoDB provider SHALL return only items that satisfy the `FilterExpression`
when one is supplied to a `Scan` request. Items whose attribute values do not
match the expression SHALL be excluded from the response, and `Count` SHALL
reflect the number of matching items.

#### Scenario: scan with equality filter returns matching items
Given a table containing items with attribute `status` values `"active"` and `"inactive"`
When a Scan is performed with `FilterExpression=Attr('status').eq('active')`
Then only items where `status = "active"` are returned
And `Count` equals the number of matching items

#### Scenario: scan with no matching items returns empty result
Given a table containing items where no item has `status = "deleted"`
When a Scan is performed with `FilterExpression=Attr('status').eq('deleted')`
Then the response contains `Count=0` and an empty `Items` list

#### Scenario: scan without filter returns all items
Given a table containing multiple items
When a Scan is performed without a `FilterExpression`
Then all items are returned unchanged

### Requirement: query-filter-expression-match
The DynamoDB provider SHALL apply `FilterExpression` post-key-condition filtering
during `Query`, returning only items that match both the key condition and the
filter expression.

#### Scenario: query with filter expression returns subset of key-matched items
Given a table with items sharing a partition key but different non-key attribute values
When a Query is performed with a `KeyConditionExpression` and a `FilterExpression`
Then only items satisfying both conditions are returned

### Requirement: filter-expression-dynamo-json-items
The FilterExpression evaluator SHALL correctly compare attribute values from
items stored in DynamoDB JSON format (e.g. `{"S": "value"}`) against expression
attribute values. Attribute paths resolved from stored items SHALL be unwrapped
to plain Python values before comparison, matching the behaviour of value
references resolved from `ExpressionAttributeValues`.

#### Scenario: equality comparison against DynamoDB-JSON-typed attribute succeeds
Given an item stored as `{"x": {"S": "hello"}}` (DynamoDB JSON)
And an expression `"x = :v"` with `ExpressionAttributeValues={":v": {"S": "hello"}}`
When the filter expression is applied
Then the item matches (evaluates to True)

#### Scenario: numeric comparison against DynamoDB-JSON-typed attribute succeeds
Given an item stored as `{"score": {"N": "42"}}`
And an expression `"score > :min"` with `ExpressionAttributeValues={":min": {"N": "10"}}`
When the filter expression is applied
Then the item matches (evaluates to True)
