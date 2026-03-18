@sdk @fake_responses
Feature: Fake AWS API responses

  @happy
  Scenario: Fake a successful response for an operation
    Given a running session
    When I configure a fake success response for "stepfunctions" "StartExecution"
    And I call "stepfunctions" "StartExecution"
    Then the faked response body is returned

  @happy
  Scenario: Fake an error response for an operation
    Given a running session
    When I configure a fake error "ExecutionLimitExceeded" for "stepfunctions" "StartExecution"
    And I call "stepfunctions" "StartExecution"
    Then an AWS error "ExecutionLimitExceeded" is returned

  @happy
  Scenario: Fake a response with a delay
    Given a running session
    When I configure a fake success response for "stepfunctions" "StartExecution" with a 50ms delay
    And I call "stepfunctions" "StartExecution"
    Then the faked response body is returned

  @happy
  Scenario: Clearing fakes restores normal behaviour
    Given a running session with a fake success response on "stepfunctions" "StartExecution"
    When I clear fakes for "stepfunctions"
    And I call "stepfunctions" "StartExecution" against a real state machine
    Then the real response is returned

  @happy
  Scenario: Fake only intercepts the configured operation, others pass through
    Given a running session
    And an OrderProcessor state machine is running
    When I configure a fake success response for "stepfunctions" "StartExecution"
    And I call "stepfunctions" "ListStateMachines"
    Then the real response is returned
