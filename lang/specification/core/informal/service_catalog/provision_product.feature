@servicecatalog @generated
Feature: ServiceCatalog - A "Service Catalog" "Product" Is Provisioned

  # Generated from FizzBee spec: service_catalog.fizz
  # Safety invariants: RecordAlwaysSucceeded, ProvisionedProductHasRecord

  Background:
    Given the system is initialized

  @minimal @happy @provision_product
  Scenario: a "service catalog" "product" is provisioned
    Given a "service catalog" "product" and "launch path" existed
    When a "service catalog" "product" is provisioned
    Then the "service catalog" "record" will be "SUCCEEDED"
    And every "service catalog" "record" has status "SUCCEEDED"
    And every "service catalog" "provisioned product" has an associated "record"

  @guard @negative @provision_product
  Scenario: a "service catalog" "product" is provisioned fails when the "service catalog" "product" did not exist
    Given the "service catalog" "product" did not exist
    When a "service catalog" "product" is provisioned
    Then the operation is rejected
