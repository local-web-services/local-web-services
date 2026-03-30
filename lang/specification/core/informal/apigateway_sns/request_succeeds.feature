@apigatewaysns @generated
Feature: ApigatewaySns - A Request Is Received, The Api Publishes To The Sns Topic, And Returns 200

  # Generated from FizzBee spec: apigateway_sns.fizz
  # Safety invariants: PublishedMessageReferencesExistingTopic, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_succeeds
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is "ACTIVE"
    And a request slot is available
    And a message slot is available
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the message is "PUBLISHED" and the request is "SUCCESS"
    And every "PUBLISHED" message references a topic that exists
    And every successful request references an "API" that exists

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 fails when the "API" has no "SNS" integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no "SNS" integration configured
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 fails when the target topic is not "ACTIVE"
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is not "ACTIVE"
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the operation is rejected

  @guard @negative @internal @request_succeeds @capacity
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is "ACTIVE"
    And no request slot is available
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the operation is rejected

  @guard @negative @internal @request_succeeds @capacity
  Scenario: a request is received, the "API" publishes to the "SNS" topic, and returns 200 fails when no message slot is available
    Given the "API" is "ACTIVE"
    And the "API" has an "SNS" integration configured
    And the target topic is "ACTIVE"
    And a request slot is available
    And no message slot is available
    When a request is received, the "API" publishes to the "SNS" topic, and returns 200
    Then the operation is rejected
