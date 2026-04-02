@cloudformation @generated
Feature: Cloudformation - A "Cloudformation" "Stack" Is Deleted

  # Generated from FizzBee spec: cloudformation.fizz
  # Safety invariants: StackStatusValid, DeletedStackNotDescribable, UniqueStackNamesPerAccount

  Background:
    Given the system is initialized

  @minimal @happy @delete_stack
  Scenario: a "cloudformation" "stack" is deleted
    Given the "cloudformation" "stack" existed
    When a "cloudformation" "stack" is deleted
    Then the "cloudformation" "stack" will no longer exist
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @guard @negative @delete_stack
  Scenario: a "cloudformation" "stack" is deleted fails when the "cloudformation" "stack" did not exist
    Given the "cloudformation" "stack" did not exist
    When a "cloudformation" "stack" is deleted
    Then the operation is rejected
