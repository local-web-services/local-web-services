@apigatewaysns @generated
Feature: ApigatewaySns - A Direct Sns Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no "SNS" integration configured
    And the "sns" "topic" existed and was "ACTIVE"
    When a direct "SNS" integration is configured on the "api gateway" "API"
    Then the "api gateway" "API" will publish to the "sns" "topic" when requests are received
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" fails when the "api gateway" "API" did not exist or was "ACTIVE"
    Given the "api gateway" "API" did not exist or was "ACTIVE"
    When a direct "SNS" integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" fails when the "api gateway" "API" already has a "SNS" integration configured
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "API" already has a "SNS" integration configured
    When a direct "SNS" integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "api gateway" "API" fails when the "sns" "topic" did not exist or was "ACTIVE"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no "SNS" integration configured
    And the "sns" "topic" did not exist or was "ACTIVE"
    When a direct "SNS" integration is configured on the "api gateway" "API"
    Then the operation is rejected
