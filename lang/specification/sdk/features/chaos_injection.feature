@sdk @chaos_injection
Feature: Chaos injection

  @happy
  Scenario: 100% error rate causes all calls to fail
    Given a running session
    And an OrderProcessor state machine is running
    When I set a 100% error rate on "stepfunctions"
    And I call "stepfunctions" "StartExecution"
    Then an AWS error is returned

  @happy
  Scenario: Clearing chaos restores normal behaviour
    Given a running session with 100% error rate on "stepfunctions"
    And an OrderProcessor state machine is running
    When I clear chaos for "stepfunctions"
    And I call "stepfunctions" "StartExecution"
    Then the call succeeds

  @happy
  Scenario: Chaos applies only to the configured service
    Given a running session
    And a DynamoDB table "Orders" with partition key "orderId"
    When I set a 100% error rate on "stepfunctions"
    And I call "dynamodb" "ListTables"
    Then the call succeeds
