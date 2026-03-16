@lambda @generated
Feature: Lambda - An Async Invocation Fails And Is Retried

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @process_async_retry @internal
  Scenario: an async invocation fails and is retried
    Given the async slot is occupied
    And the async slot has a function assigned
    And the function exists
    And the function is "ACTIVE"
    And retry tracking is available for the slot
    And the retry count has not been exhausted
    When an async invocation fails and is retried
    Then the retry count increases
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the async slot is empty
    Given the async slot is empty
    When an async invocation fails and is retried
    Then the operation is rejected

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the async slot does not have a function assigned
    Given the async slot is occupied
    And the async slot does not have a function assigned
    When an async invocation fails and is retried
    Then the operation is rejected

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the function does not exist
    Given the async slot is occupied
    And the async slot has a function assigned
    And the function does not exist
    When an async invocation fails and is retried
    Then the operation is rejected

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the function is not "ACTIVE"
    Given the async slot is occupied
    And the async slot has a function assigned
    And the function exists
    And the function is not "ACTIVE"
    When an async invocation fails and is retried
    Then the operation is rejected

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when retry tracking is not available for the slot
    Given the async slot is occupied
    And the async slot has a function assigned
    And the function exists
    And the function is "ACTIVE"
    And retry tracking is not available for the slot
    When an async invocation fails and is retried
    Then the operation is rejected

  @standard @negative @process_async_retry @internal
  Scenario: an async invocation fails and is retried fails when the retry count has been exhausted
    Given the async slot is occupied
    And the async slot has a function assigned
    And the function exists
    And the function is "ACTIVE"
    And retry tracking is available for the slot
    And the retry count has been exhausted
    When an async invocation fails and is retried
    Then the operation is rejected
