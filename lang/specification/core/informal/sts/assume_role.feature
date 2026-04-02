@sts @generated
Feature: Sts - An "Sts" "Role" Is Assumed For An Account

  # Generated from FizzBee spec: sts.fizz
  # Safety invariants: SessionTokenContainsAccountId, CallerIdentityMatchesSession

  Background:
    Given the system is initialized

  @minimal @happy @assume_role
  Scenario: an "sts" "role" is assumed for an account
    Given an "sts" "session" "slot" was "available"
    When an "sts" "role" is assumed for an account
    Then the "sts" "session" will be created with the account id embedded in the token
    And every "sts" "session" token maps to a valid account id
    And the "sts" "caller identity" account matches the "sts" "session" account

  @guard @negative @assume_role @capacity
  Scenario: an "sts" "role" is assumed for an account fails when no "sts" "session" "slot" was "available"
    Given no "sts" "session" "slot" was "available"
    When an "sts" "role" is assumed for an account
    Then the operation is rejected
