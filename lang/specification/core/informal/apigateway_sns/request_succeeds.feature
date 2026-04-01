@apigatewaysns @generated
Feature: ApigatewaySns - A Request Is Received, The "Api Gateway" "Api" Publishes To The "Sns" "Topic", And Returns 200

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_succeeds
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was "ACTIVE"
    And a request slot is available
    And a message slot is available
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the message will be "PUBLISHED" and the request will be "SUCCESS"
    And every "PUBLISHED" message references a "sns" "topic" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 fails when the "api gateway" "api" has no "SNS" integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no "SNS" integration configured
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 fails when the target topic was not "ACTIVE"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was not "ACTIVE"
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @capacity
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 fails when no request slot is available
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was "ACTIVE"
    And no request slot is available
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @capacity
  Scenario: a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200 fails when no message slot is available
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "SNS" integration configured
    And the target topic was "ACTIVE"
    And a request slot is available
    And no message slot is available
    When a request is received, the "api gateway" "API" publishes to the "sns" "topic", and returns 200
    Then the operation is rejected
