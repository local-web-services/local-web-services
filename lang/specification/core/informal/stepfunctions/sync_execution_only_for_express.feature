@stepfunctions @generated
Feature: Stepfunctions - Synchronous executions only run on express state machines

  # Generated from FizzBee spec: stepfunctions.fizz

  Background:
    Given the system is initialized

  @invariant @sync_execution_only_for_express
  Scenario: synchronous executions only run on express state machines
    Then synchronous executions only run on express state machines
