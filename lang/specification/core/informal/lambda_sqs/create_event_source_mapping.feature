@lambdasqs @generated
Feature: LambdaSqs - A Lambda Event Source Mapping Is Created Linking A Queue To A Function

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: a Lambda event source mapping is created linking a queue to a function
    Given the function exists
    And the function is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the event source mapping does not already exist
    When a Lambda event source mapping is created linking a queue to a function
    Then the event source mapping is "ENABLED" and will poll the queue for messages
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created linking a queue to a function fails when the function does not exist
    Given the function does not exist
    When a Lambda event source mapping is created linking a queue to a function
    Then the operation is rejected

  @standard @negative @create_event_source_mapping @lifecycle @internal
  Scenario: a Lambda event source mapping is created linking a queue to a function fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When a Lambda event source mapping is created linking a queue to a function
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created linking a queue to a function fails when the queue does not exist
    Given the function exists
    And the function is "ACTIVE"
    And the queue does not exist
    When a Lambda event source mapping is created linking a queue to a function
    Then the operation is rejected

  @standard @negative @create_event_source_mapping @lifecycle @internal
  Scenario: a Lambda event source mapping is created linking a queue to a function fails when the queue is not "ACTIVE"
    Given the function exists
    And the function is "ACTIVE"
    And the queue exists
    And the queue is not "ACTIVE"
    When a Lambda event source mapping is created linking a queue to a function
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: a Lambda event source mapping is created linking a queue to a function fails when the event source mapping already exists
    Given the function exists
    And the function is "ACTIVE"
    And the queue exists
    And the queue is "ACTIVE"
    And the event source mapping already exists
    When a Lambda event source mapping is created linking a queue to a function
    Then the operation is rejected
