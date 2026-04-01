@lambda @generated
Feature: lambda - Reserved Concurrency Is Set For A "Lambda" "Function"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @set_reserved_concurrency
  Scenario: reserved concurrency is set for a "lambda" "function"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When reserved concurrency is set for a "lambda" "function"
    Then the "lambda" "function" has an unreserved, throttled, or explicit concurrency limit
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @set_reserved_concurrency
  Scenario: reserved concurrency is set for a "lambda" "function" fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When reserved concurrency is set for a "lambda" "function"
    Then the operation is rejected

  @guard @negative @set_reserved_concurrency @lifecycle
  Scenario: reserved concurrency is set for a "lambda" "function" fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When reserved concurrency is set for a "lambda" "function"
    Then the operation is rejected
