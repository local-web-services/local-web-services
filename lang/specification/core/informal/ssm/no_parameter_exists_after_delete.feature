@ssm @generated
Feature: Ssm - No parameter exists after it has been deleted

  # Generated from FizzBee spec: ssm.fizz

  Background:
    Given the system is initialized

  @invariant @no_parameter_exists_after_delete
  Scenario: no parameter exists after it has been deleted
    Then no parameter exists after it has been deleted
