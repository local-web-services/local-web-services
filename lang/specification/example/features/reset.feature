@stepfunctions @reset @controlplane
Feature: Session reset clears runtime state

  @happy @minimal
  Scenario: Session remains functional after reset
    Given an OrderProcessor state machine is running
    And order "order-before-reset" has been processed
    When I reset the session
    Then the session accepts a second reset without error
