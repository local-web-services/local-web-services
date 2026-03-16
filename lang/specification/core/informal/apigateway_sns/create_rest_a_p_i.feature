@apigatewaysns @generated
Feature: ApigatewaySns - An Api Gateway Rest Api Is Created

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_a_p_i
  Scenario: an "API" Gateway "REST" "API" is created
    Given the "API" does not already exist
    When an "API" Gateway "REST" "API" is created
    Then the "API" is "ACTIVE" with no "SNS" integration configured
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @standard @negative @create_rest_a_p_i
  Scenario: an "API" Gateway "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When an "API" Gateway "REST" "API" is created
    Then the operation is rejected
