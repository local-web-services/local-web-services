@lambda @generated
Feature: Lambda - A "Lambda" "Function"'S Code Is Updated

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @update_function_code
  Scenario: a "lambda" "function"'s code is updated
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a "lambda" "function"'s code is updated
    Then the "lambda" "function" returns to "PENDING" state for redeployment
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @update_function_code
  Scenario: a "lambda" "function"'s code is updated fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function"'s code is updated
    Then the operation is rejected

  @guard @negative @update_function_code @lifecycle
  Scenario: a "lambda" "function"'s code is updated fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function"'s code is updated
    Then the operation is rejected
