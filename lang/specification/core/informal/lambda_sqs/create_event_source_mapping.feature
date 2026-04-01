@lambdasqs @generated
Feature: LambdaSqs - A "Lambda" "Event Source Mapping" Is Created Linking A Queue To A Function

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the event source mapping did not already exist
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the event source mapping will be "ENABLED" and will poll the queue for messages
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the operation is rejected

  @guard @negative @create_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function fails when the "sqs" "queue" did not exist
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "sqs" "queue" did not exist
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the operation is rejected

  @guard @negative @create_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function fails when the "sqs" "queue" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" "event source mapping" is created linking a queue to a function fails when the event source mapping already existed
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And the event source mapping already existed
    When a "lambda" "event source mapping" is created linking a queue to a function
    Then the operation is rejected
