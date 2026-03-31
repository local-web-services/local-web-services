@apigatewaysns @generated
Feature: ApigatewaySns - A Request Is Received But The Sns Publish Fails Because The "Sns" "Topic" Has Been Deleted

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was "DELETED"
    And a request slot is available
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Then the request will be "FAILED" and no message will be published
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted fails when the "api gateway" "api" has no "SNS" integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no "SNS" integration configured
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted fails when the target topic was not "DELETED"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was not "DELETED"
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @request_fails @capacity
  Scenario: a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted fails when no request slot is available
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was "DELETED"
    And no request slot is available
    When a request is received but the "SNS" publish fails because the "sns" "topic" has been deleted
    Then the operation is rejected
