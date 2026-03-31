@lambda @generated
Feature: Lambda - A Tag Is Added To A "Lambda" "Function"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: a tag is added to a "lambda" "function"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "DELETING"
    And the "lambda" "function" was "DELETED"
    When a tag is added to a "lambda" "function"
    Then the "lambda" "function" has the tag set
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @tag_resource
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a tag is added to a "lambda" "function"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" was not "DELETING"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "DELETING"
    When a tag is added to a "lambda" "function"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" was not "DELETED"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "DELETING"
    And the "lambda" "function" was not "DELETED"
    When a tag is added to a "lambda" "function"
    Then the operation is rejected
