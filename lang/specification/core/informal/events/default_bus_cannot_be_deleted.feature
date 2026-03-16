@events @generated
Feature: Events - The default event bus cannot be deleted

  # Generated from FizzBee spec: events.fizz

  Background:
    Given the system is initialized

  @invariant @default_bus_cannot_be_deleted
  Scenario: the default event bus cannot be deleted
    Then the default event bus cannot be deleted
