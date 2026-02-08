## MODIFIED Requirements
### Requirement: Tree JSON Parsing
The parser SHALL read the `tree.json` file from the CDK cloud assembly and extract construct nodes with their CDK type information (`constructInfo.fqn`) and parent-child relationships. The parser SHALL produce `ConstructNode` dataclasses and use `json.load()` for parsing. Each `ConstructNode` SHALL contain `path`, `id`, `fqn` (from `constructInfo.fqn`), `children` (list of child paths), and `cfn_type` (if it maps to a CloudFormation resource).

#### Scenario: Extract construct hierarchy
- **WHEN** the parser processes a `tree.json` containing Lambda functions, API Gateway endpoints, and DynamoDB tables
- **THEN** each construct node SHALL be identified with its fully qualified CDK type name and its position in the construct hierarchy

#### Scenario: Produce ConstructNode dataclasses
- **WHEN** the parser processes a `tree.json` file using `json.load()`
- **THEN** the output SHALL be a dict of `ConstructNode` dataclasses keyed by construct path, where each node contains `path`, `id`, `fqn`, `children`, and `cfn_type` fields
