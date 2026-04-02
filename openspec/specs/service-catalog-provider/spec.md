# service-catalog-provider Specification

## Purpose
TBD - created by archiving change add-agency-aws-api-surface. Update Purpose after archive.
## Requirements
### Requirement: Service Catalog SearchProductsAsAdmin

The Service Catalog provider SHALL implement `SearchProductsAsAdmin`. It SHALL return all
products in the account's product catalogue. When the catalogue is empty it SHALL return
an empty `ProductViewDetails` list.

#### Scenario: Products listed from catalogue

- **GIVEN** two products exist in the account's catalogue
- **WHEN** `SearchProductsAsAdmin` is called
- **THEN** both products are returned in `ProductViewDetails`

### Requirement: Service Catalog DescribeProduct

The Service Catalog provider SHALL implement `DescribeProduct`. It SHALL return the
product summary and provisioning artifact list for a known product ID. An unknown product
ID SHALL return `ResourceNotFoundException`.

#### Scenario: Product described successfully

- **GIVEN** a product with ID `prod-abc123` exists
- **WHEN** `DescribeProduct` is called with `Id=prod-abc123`
- **THEN** the product summary is returned

#### Scenario: Unknown product rejected

- **GIVEN** no product with ID `prod-missing` exists
- **WHEN** `DescribeProduct` is called with `Id=prod-missing`
- **THEN** the operation is rejected with `ResourceNotFoundException`

### Requirement: Service Catalog ListProvisioningArtifacts

The Service Catalog provider SHALL implement `ListProvisioningArtifacts`. It SHALL
return the list of provisioning artifact summaries for a given product ID.

#### Scenario: Artifacts listed for a product

- **GIVEN** a product with two provisioning artifacts exists
- **WHEN** `ListProvisioningArtifacts` is called with the product ID
- **THEN** both artifact summaries are returned

### Requirement: Service Catalog ListLaunchPaths

The Service Catalog provider SHALL implement `ListLaunchPaths`. It SHALL return at least
one launch path summary for a known product ID so that callers can proceed to
`ProvisionProduct`.

#### Scenario: Launch path returned for a product

- **GIVEN** a product exists
- **WHEN** `ListLaunchPaths` is called with the product ID
- **THEN** at least one `LaunchPathSummary` is returned

### Requirement: Service Catalog ProvisionProduct

The Service Catalog provider SHALL implement `ProvisionProduct`. It SHALL create a
provisioned product record with a unique `RecordId` and status `SUCCEEDED`. It SHALL
return the `RecordDetail` immediately.

#### Scenario: Product provisioned and record returned

- **GIVEN** a product and launch path exist
- **WHEN** `ProvisionProduct` is called
- **THEN** a `RecordId` is returned and `DescribeRecord` returns `Status=SUCCEEDED`

### Requirement: Service Catalog DescribeRecord

The Service Catalog provider SHALL implement `DescribeRecord`. It SHALL return the
record detail for a known `RecordId`. An unknown `RecordId` SHALL return
`ResourceNotFoundException`.

#### Scenario: Record described after provisioning

- **GIVEN** a provisioned product with `RecordId=rec-123` exists
- **WHEN** `DescribeRecord` is called with `Id=rec-123`
- **THEN** `Status=SUCCEEDED` is returned

#### Scenario: Unknown record rejected

- **GIVEN** no record with ID `rec-missing` exists
- **WHEN** `DescribeRecord` is called with `Id=rec-missing`
- **THEN** the operation is rejected with `ResourceNotFoundException`

### Requirement: Service Catalog FizzBee Formal Spec

The project SHALL include a FizzBee formal spec at
`lang/specification/core/formal/service_catalog/service_catalog.fizz` that models the
Service Catalog provisioning lifecycle. The spec SHALL cover `ProvisionProduct` and
`DescribeRecord`. Safety invariants SHALL include `RecordAlwaysSucceeded` and
`ProvisionedProductHasRecord`.

#### Scenario: FizzBee model checker passes all invariants

- **GIVEN** the FizzBee spec is written
- **WHEN** `fizz service_catalog.fizz` is run
- **THEN** all safety invariants pass with no counter-examples

