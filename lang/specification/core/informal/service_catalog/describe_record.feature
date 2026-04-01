@service_catalog
Feature: SERVICE_CATALOG - A Record Is Described

  Background:
    Given the system is initialized

  @minimal @happy @describe_record
  Scenario: a record is described after provisioning
    Given a provisioned product with a known record exists
    When a record is described
    Then the "service_catalog" "record" will be "SUCCEEDED"

  @guard @negative @describe_record
  Scenario: a record is described fails when the record did not exist
    Given no record exists
    When a record is described
    Then the operation is rejected
