## ADDED Requirements

### Requirement: Neptune Management API Uses AWS Query Protocol

The Neptune provider SHALL speak the AWS query protocol for all cluster and instance management operations. Requests SHALL be parsed as `application/x-www-form-urlencoded` bodies with an `Action` field identifying the operation. Responses SHALL be well-formed XML documents following the standard AWS query-protocol envelope: a root element named `{Action}Response` containing a `{Action}Result` child with the operation payload and a `ResponseMetadata` sibling with a `RequestId`.

#### Scenario: Describe clusters returns XML

- **WHEN** `describe_db_clusters` is called via the boto3 Neptune client
- **THEN** the response is valid XML that boto3 can parse without `ResponseParserError`

#### Scenario: Create cluster returns XML

- **WHEN** `create_db_cluster` is called via the boto3 Neptune client
- **THEN** the response is valid XML containing a `CreateDBClusterResult` element

#### Scenario: Reboot instance returns XML

- **WHEN** `reboot_db_instance` is called via the boto3 Neptune client
- **THEN** the response is valid XML containing a `RebootDBInstanceResult` element

#### Scenario: Error responses are XML-encoded

- **WHEN** a Neptune management operation is rejected (e.g. cluster does not exist)
- **THEN** the error is returned as an XML `ErrorResponse` document that boto3 can parse as a `ClientError`
