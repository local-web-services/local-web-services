@apigatewaysns @generated
Feature: ApigatewaySns - An "Api Gateway" "Api" Is Created

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created
    Given the "api gateway" "API" did not already exist
    When an "api gateway" "api" is created
    Then the "api gateway" "api" will be "ACTIVE" with no "SNS" integration configured
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When an "api gateway" "api" is created
    Then the operation is rejected
