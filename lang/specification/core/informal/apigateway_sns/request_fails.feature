@apigatewaysns @generated
Feature: ApigatewaySns - A Request Is Received But The Sns Publish Fails Because The Topic Has Been Deleted

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is "DELETED"
    And a request slot is available
    When a request is received but the "SNS" publish fails because the topic has been deleted
    Then the request is "FAILED" and no message is published
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    Then the operation is rejected

  @guard @negative @request_fails
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted fails when the "API" has no "SNS" integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no "SNS" integration configured
    When a request is received but the "SNS" publish fails because the topic has been deleted
    Then the operation is rejected

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted fails when the target topic is not "DELETED"
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is not "DELETED"
    When a request is received but the "SNS" publish fails because the topic has been deleted
    Then the operation is rejected

  @guard @negative @internal @request_fails @capacity
  Scenario: a request is received but the "SNS" publish fails because the topic has been deleted fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is "DELETED"
    And no request slot is available
    When a request is received but the "SNS" publish fails because the topic has been deleted
    Then the operation is rejected
