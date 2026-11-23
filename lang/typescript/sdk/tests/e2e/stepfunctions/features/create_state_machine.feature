Feature: Step Functions - Create State Machine

  Background:
    Given the stepfunctions system is initialized

  Scenario: a "stepfunctions" "state machine" is created
    Given the "stepfunctions" "state machine" did not already exist
    When a "stepfunctions" "state machine" is created
    Then the "stepfunctions" "state machine" will exist

  Scenario: creating a "stepfunctions" "state machine" that already exists is rejected
    Given the "stepfunctions" "state machine" already existed
    When a "stepfunctions" "state machine" is created
    Then the operation is rejected
