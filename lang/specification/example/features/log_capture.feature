@stepfunctions @log_capture @dataplane
Feature: Log capture records and filters AWS API calls

  @happy
  Scenario: Log capture records StartExecution call
    Given an OrderProcessor state machine is running
    And log capture is active
    When I process order "order-logged"
    Then the log capture will have recorded a "stepfunctions" "StartExecution" call
    And no errors will appear in the log capture

  @happy
  Scenario: Log filtering returns entries by service and operation
    Given an OrderProcessor state machine is running
    When I process order "order-filter-001"
    Then recent logs will be non-empty
    When I start log capture and process order "order-filter-002"
    Then the log capture will have recorded a "stepfunctions" "StartExecution" call
    And filtering logs by service "stepfunctions" will return entries
    And filtering logs by operation "StartExecution" will return entries
