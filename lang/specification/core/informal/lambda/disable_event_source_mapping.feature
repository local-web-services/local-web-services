@lambda @generated
Feature: Lambda - An Enabled Lambda Event Source Mapping Was "Disabled"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @disable_event_source_mapping
  Scenario: an enabled lambda event source mapping was "DISABLED"
    Given the "lambda" "event source mapping" existed
    And the mapping was "ENABLED"
    When an enabled lambda event source mapping was "DISABLED"
    Then the mapping will be "DISABLED" and inactive
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @disable_event_source_mapping
  Scenario: an enabled lambda event source mapping was "DISABLED" fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When an enabled lambda event source mapping was "DISABLED"
    Then the operation is rejected

  @guard @negative @disable_event_source_mapping @lifecycle
  Scenario: an enabled lambda event source mapping was "DISABLED" fails when the mapping was not "ENABLED"
    Given the "lambda" "event source mapping" existed
    And the mapping was not "ENABLED"
    When an enabled lambda event source mapping was "DISABLED"
    Then the operation is rejected
