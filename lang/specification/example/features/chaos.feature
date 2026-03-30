@stepfunctions @chaos @dataplane
Feature: Chaos engineering injects errors into AWS calls

  @error @guard
  Scenario: 100% error rate causes process order to fail
    Given an OrderProcessor state machine is running
    And stepfunctions chaos is set to 100% error rate
    When I process order "order-chaos"
    Then an AWS error is returned
