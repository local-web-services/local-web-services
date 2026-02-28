@sdk @log_capture
Feature: Log capture

  @happy
  Scenario: Log capture records a call made within the capture window
    Given a running session
    And an OrderProcessor state machine is running
    When I start log capture and call "stepfunctions" "StartExecution"
    Then the log capture will contain a "stepfunctions" "StartExecution" entry

  @happy
  Scenario: Log capture reports no errors when all calls succeed
    Given a running session
    And an OrderProcessor state machine is running
    When I start log capture and call "stepfunctions" "StartExecution"
    Then no errors will appear in the log capture

  @happy
  Scenario: Log capture can be filtered by service
    Given a running session
    And an OrderProcessor state machine is running
    And a DynamoDB table "Orders" with partition key "orderId"
    When I start log capture and call both "stepfunctions" "StartExecution" and "dynamodb" "ListTables"
    Then filtering by service "stepfunctions" returns only stepfunctions entries
    And filtering by service "dynamodb" returns only dynamodb entries

  @happy
  Scenario: Log capture can be filtered by operation
    Given a running session
    And an OrderProcessor state machine is running
    When I start log capture and call "stepfunctions" "StartExecution"
    Then filtering by operation "StartExecution" returns at least one entry

  @happy
  Scenario: Log capture call count assertion passes for the expected count
    Given a running session
    And an OrderProcessor state machine is running
    When I start log capture and call "stepfunctions" "StartExecution" twice
    Then the log capture will contain exactly 2 "stepfunctions" "StartExecution" entries

  @happy
  Scenario: Recent logs returns entries from the whole session
    Given a running session
    And an OrderProcessor state machine is running
    When I call "stepfunctions" "StartExecution"
    Then recent logs are non-empty
