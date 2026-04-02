@service_catalog
Feature: SERVICE_CATALOG - A "Service Catalog" "Record" Is Described

  Background:
    Given the system is initialized

  @minimal @happy @describe_record
  Scenario: a "service catalog" "record" is described after provisioning
    Given a "service catalog" "provisioned product" with a known "service catalog" "record" exists
    When a "service catalog" "record" is described
    Then the "service catalog" "record" will be "SUCCEEDED"

  @guard @negative @describe_record
  Scenario: a "service catalog" "record" is described fails when the "service catalog" "record" did not exist
    Given no "service catalog" "record" exists
    When a "service catalog" "record" is described
    Then the operation is rejected
