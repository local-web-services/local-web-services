@eventssqs @generated
Feature: EventsSqs - An "Eventbridge" "Rule" Is Created To Route Matching Events To The "Sqs" "Queue"

  # Generated from FizzBee spec: events_sqs.fizz
  # Safety invariants: RuleReferencesActiveBus, MessagesReferenceActiveQueues

  Background:
    Given the system is initialized

  @minimal @happy @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the "eventbridge" "rule" will be "ENABLED" and will forward matching events to the "sqs" "queue"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue" fails when the "eventbridge" "bus" did not exist
    Given the "eventbridge" "bus" did not exist
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue" fails when the "eventbridge" "bus" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was not "ACTIVE"
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue" fails when the "sqs" "queue" did not exist
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sqs" "queue" did not exist
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_rule @lifecycle
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue" fails when the "sqs" "queue" was not "ACTIVE"
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_rule
  Scenario: an "eventbridge" "rule" is created to route matching events to the "sqs" "queue" fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "bus" existed
    And the "eventbridge" "bus" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created to route matching events to the "sqs" "queue"
    Then the operation is rejected
