@stepfunctions @start_sync_execution @dataplane
Feature: StepFunctions StartSyncExecution

  @happy
  Scenario: Start a synchronous execution on an EXPRESS state machine
    Given an EXPRESS state machine "e2e-start-sync" was created with a Pass definition
    When I start a sync execution on state machine "e2e-start-sync" with input "{}"
    Then the command will succeed
