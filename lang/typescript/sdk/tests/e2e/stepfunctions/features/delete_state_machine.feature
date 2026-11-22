Feature: Step Functions - Delete State Machine

  Background:
    Given the stepfunctions system is initialized

  Scenario: a "stepfunctions" "state machine" is deleted
    Given the "stepfunctions" "state machine" existed
    When a "stepfunctions" "state machine" is deleted
    Then the "stepfunctions" "state machine" will not exist

  Scenario: deleting a "stepfunctions" "state machine" that does not exist is rejected
    Given the "stepfunctions" "state machine" did not already exist
    When a "stepfunctions" "state machine" is deleted
    Then the stepfunctions operation is rejected
