Feature: Step Functions - Get Execution History

  Background:
    Given the stepfunctions system is initialized

  Scenario: "stepfunctions" "execution" history is retrieved
    Given the "stepfunctions" "state machine" existed
    And a "stepfunctions" "execution" was started
    When "stepfunctions" "execution" history is retrieved
    Then "stepfunctions" "execution" history will contain events
