@lambda @generated
Feature: lambda - An Async Invocation Fails And Is Retried

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @process_async_retry @internal
  Scenario: an async invocation fails and is retried
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And retry tracking is available for the slot
    And the retry count had not been exhausted
    When an async invocation fails and is retried
    Then the retry count increases
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the async slot was empty
    Given the async slot was empty
    When an async invocation fails and is retried
    Then the operation is rejected

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the async slot does not have a "lambda" "function" assigned
    Given the async slot is occupied
    And the async slot does not have a "lambda" "function" assigned
    When an async invocation fails and is retried
    Then the operation is rejected

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the "lambda" "function" did not exist
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" did not exist
    When an async invocation fails and is retried
    Then the operation is rejected

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the "lambda" "function" was not "ACTIVE"
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When an async invocation fails and is retried
    Then the operation is rejected

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when retry tracking is not available for the slot
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And retry tracking is not available for the slot
    When an async invocation fails and is retried
    Then the operation is rejected

  @guard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the retry count had been exhausted
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And retry tracking is available for the slot
    And the retry count had been exhausted
    When an async invocation fails and is retried
    Then the operation is rejected
