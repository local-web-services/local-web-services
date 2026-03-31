@lambda @generated
Feature: Lambda - A "Lambda" "Function" Is Created

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @create_function
  Scenario: a "lambda" "function" is created
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is created
    Then the "lambda" "function" will be in "PENDING" state
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @create_function
  Scenario: a "lambda" "function" is created fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "function" is created
    Then the operation is rejected
