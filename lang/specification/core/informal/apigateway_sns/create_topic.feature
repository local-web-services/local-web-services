@apigatewaysns @generated
Feature: ApigatewaySns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the "sns" "topic" did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the "sns" "topic" already existed
    Given the "sns" "topic" already existed
    When a "sns" "topic" is created
    Then the operation is rejected
