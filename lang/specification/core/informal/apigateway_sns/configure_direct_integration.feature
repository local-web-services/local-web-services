@apigatewaysns @generated
Feature: ApigatewaySns - A Direct Sns Integration Is Configured On The Api

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "API"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no "SNS" integration configured
    And the topic exists and is "ACTIVE"
    When a direct "SNS" integration is configured on the "API"
    Then the "API" will publish to the topic when requests are received
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @standard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "API" fails when the "API" does not exist or is not "ACTIVE"
    Given the "API" does not exist or is not "ACTIVE"
    When a direct "SNS" integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "API" fails when the "API" already has an "SNS" integration configured
    Given the "API" exists and is "ACTIVE"
    And the "API" already has an "SNS" integration configured
    When a direct "SNS" integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_direct_integration
  Scenario: a direct "SNS" integration is configured on the "API" fails when the topic does not exist or is not "ACTIVE"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no "SNS" integration configured
    And the topic does not exist or is not "ACTIVE"
    When a direct "SNS" integration is configured on the "API"
    Then the operation is rejected
