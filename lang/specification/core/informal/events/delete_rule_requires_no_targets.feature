@events @generated
Feature: Events - A rule can only be deleted when it has no targets

  # Generated from FizzBee spec: events.fizz

  Background:
    Given the system is initialized

  @invariant @delete_rule_requires_no_targets
  Scenario: a rule can only be deleted when it has no targets
    Then a rule can only be deleted when it has no targets
