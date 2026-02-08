## ADDED Requirements

### Requirement: Tree JSON Parsing
The parser SHALL read the `tree.json` file from the CDK cloud assembly and extract construct nodes with their CDK type information (`constructInfo.fqn`) and parent-child relationships.

#### Scenario: Extract construct hierarchy
- **WHEN** the parser processes a `tree.json` containing Lambda functions, API Gateway endpoints, and DynamoDB tables
- **THEN** each construct node SHALL be identified with its fully qualified CDK type name and its position in the construct hierarchy

### Requirement: CloudFormation Template Parsing
The parser SHALL read CloudFormation templates from the cloud assembly and extract resource properties including table key schemas, function handler paths, API route definitions, and environment variables.

#### Scenario: Extract resource properties
- **WHEN** the parser processes a CloudFormation template containing an `AWS::DynamoDB::Table` resource
- **THEN** the table's key schema, GSI definitions, and stream configuration SHALL be extracted

### Requirement: Reference Resolution
The parser SHALL resolve `Ref` and `Fn::GetAtt` references between resources in CloudFormation templates to build the dependency graph.

#### Scenario: Resolve cross-resource references
- **WHEN** a Lambda function's environment variable references a DynamoDB table name via `Ref`
- **THEN** the parser SHALL resolve the reference to the actual table resource and record the dependency

### Requirement: Asset Location
The parser SHALL locate Lambda code assets in the cloud assembly's asset directories by reading the asset manifest.

#### Scenario: Find Lambda code asset
- **WHEN** a Lambda function resource references a code asset
- **THEN** the parser SHALL resolve the asset path to the correct directory within `cdk.out` containing the handler code

### Requirement: Multi-Stack Support
The parser SHALL merge resource graphs from multiple CloudFormation stacks in the cloud assembly into a single unified application graph, resolving cross-stack references (exports and imports).

#### Scenario: Resolve cross-stack references
- **WHEN** the cloud assembly contains multiple stacks where Stack A exports a table name and Stack B imports it
- **THEN** the parser SHALL resolve the cross-stack reference so that Stack B's functions correctly reference Stack A's table

### Requirement: Language Agnostic Parsing
The parser SHALL work with cloud assemblies produced by CDK apps written in any CDK-supported language (TypeScript, Python, Java, C#, Go) by reading the cloud assembly output rather than language-specific CDK libraries.

#### Scenario: Parse Python CDK app output
- **WHEN** a CDK app is written in Python and `cdk synth` produces a cloud assembly
- **THEN** the parser SHALL extract the same application graph as it would from an equivalent TypeScript CDK app
