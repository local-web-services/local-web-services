@lambda @generated
Feature: Lambda - An Active "Lambda" "Function" Is Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: an active "lambda" "function" is deleted
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had no active executions
    When an active "lambda" "function" is deleted
    Then the "lambda" "function" will be in "DELETING" state
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @delete_function
  Scenario: an active "lambda" "function" is deleted fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When an active "lambda" "function" is deleted
    Then the operation is rejected

  @guard @negative @delete_function @lifecycle
  Scenario: an active "lambda" "function" is deleted fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When an active "lambda" "function" is deleted
    Then the operation is rejected

  @guard @negative @delete_function
  Scenario: an active "lambda" "function" is deleted fails when the "lambda" "function" had active executions
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had active executions
    When an active "lambda" "function" is deleted
    Then the operation is rejected
