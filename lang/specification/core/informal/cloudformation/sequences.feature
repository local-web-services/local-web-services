@cloudformation @generated
Feature: Cloudformation - Action Sequences

  # Generated from FizzBee spec: cloudformation.fizz
  # Safety invariants: StackStatusValid, DeletedStackNotDescribable, UniqueStackNamesPerAccount

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "cloudformation" "stack" is created then a "cloudformation" "stack" is updated
    Given sid not in stack_status
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is updated
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is created then a "cloudformation" "stack" is deleted
    Given sid not in stack_status
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is deleted
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is updated then a "cloudformation" "stack" is created
    Given sid in stack_status
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is created
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is updated then a "cloudformation" "stack" is deleted
    Given sid in stack_status
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is deleted
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is created
    Given sid in stack_status
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is created
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is updated
    Given sid in stack_status
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is updated
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is created then a "cloudformation" "stack" is updated then a "cloudformation" "stack" is deleted
    Given sid not in stack_status
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is deleted
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is created then a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is updated
    Given sid not in stack_status
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is updated
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is updated then a "cloudformation" "stack" is created then a "cloudformation" "stack" is deleted
    Given sid in stack_status
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is deleted
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is updated then a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is created
    Given sid in stack_status
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is created
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is created then a "cloudformation" "stack" is updated
    Given sid in stack_status
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is created
    When a "cloudformation" "stack" is updated
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @sequence
  Scenario: a "cloudformation" "stack" is deleted then a "cloudformation" "stack" is updated then a "cloudformation" "stack" is created
    Given sid in stack_status
    When a "cloudformation" "stack" is deleted
    When a "cloudformation" "stack" is updated
    When a "cloudformation" "stack" is created
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account
