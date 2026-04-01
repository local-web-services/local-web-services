@stepfunctionssns @generated
Feature: StepfunctionsSns - An "Sns" Publish Task Is Configured On The "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions_sns.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ExecutionRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_n_s_task
  Scenario: an "sns" publish task is configured on the "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sns" task configured
    And the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the state machine will publish a "sns" "message" to the "sns" "topic" when it reaches the task state
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution"'s state machine targets an "ACTIVE" "sns" "topic"

  @guard @negative @configure_s_n_s_task
  Scenario: an "sns" publish task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: an "sns" publish task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: an "sns" publish task is configured on the "step functions" "state machine" fails when the "step functions" "state machine" already has an "sns" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" already has an "sns" task configured
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task
  Scenario: an "sns" publish task is configured on the "step functions" "state machine" fails when the "sns" "topic" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sns" task configured
    And the "sns" "topic" did not exist
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @configure_s_n_s_task @lifecycle
  Scenario: an "sns" publish task is configured on the "step functions" "state machine" fails when the "sns" "topic" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" has no "sns" task configured
    And the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When an "sns" publish task is configured on the "step functions" "state machine"
    Then the operation is rejected
