@service_catalog @generated
Feature: SERVICE_CATALOG - A Product Is Provisioned

  # Generated from FizzBee spec: service_catalog.fizz
  # Safety invariants: RecordAlwaysSucceeded, ProvisionedProductHasRecord

  Background:
    Given the system is initialized

  @minimal @happy @provision_product
  Scenario: a product is provisioned
    Given a product and launch path exist
    When a product is provisioned
    Then the "service_catalog" "record" will be "SUCCEEDED"
    And every provisioned record has status "SUCCEEDED"
    And every provisioned product has an associated record

  @guard @negative @provision_product
  Scenario: a product is provisioned fails when a product did not exist
    Given a product did not exist
    When a product is provisioned
    Then the operation is rejected
