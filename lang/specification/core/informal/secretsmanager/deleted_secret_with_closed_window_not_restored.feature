@secretsmanager @generated
Feature: Secretsmanager - A deleted secret with a closed recovery window cannot be restored

  # Generated from FizzBee spec: secretsmanager.fizz

  Background:
    Given the system is initialized

  @invariant @deleted_secret_with_closed_window_not_restored
  Scenario: a deleted secret with a closed recovery window cannot be restored
    Then a deleted secret with a closed recovery window cannot be restored
