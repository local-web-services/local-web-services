@sdk @iam_enforce
Feature: IAM enforce mode

  @happy
  Scenario: Wildcard allow policy permits calls
    Given a running session
    And an OrderProcessor state machine is running
    And IAM is in enforce mode with identity "test-user" allowed all "states:*" actions
    When I call "stepfunctions" "StartExecution"
    Then the call succeeds

  @error
  Scenario: No matching policy denies the call in enforce mode
    Given a running session
    And an OrderProcessor state machine is running
    And IAM is in enforce mode with identity "test-user" and no permissions
    When I call "stepfunctions" "StartExecution"
    Then an IAM access denied error is returned

  @happy
  Scenario: Returning to disabled mode allows all calls again
    Given a running session with IAM enforce mode active
    And an OrderProcessor state machine is running
    When I set IAM mode to "disabled"
    And I call "stepfunctions" "StartExecution"
    Then the call succeeds
