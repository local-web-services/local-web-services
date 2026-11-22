Feature: Step Functions - Start Execution

  Background:
    Given the stepfunctions system is initialized

  Scenario: a "stepfunctions" "execution" is started on the "stepfunctions" "state machine"
    Given the "stepfunctions" "state machine" existed
    When a "stepfunctions" "execution" is started on the "stepfunctions" "state machine"
    Then the "stepfunctions" "execution" will be "SUCCEEDED"
