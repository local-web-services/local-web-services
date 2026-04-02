@cloudformation @generated
Feature: Cloudformation - A "Cloudformation" "Stack" Is Created

  # Generated from FizzBee spec: cloudformation.fizz
  # Safety invariants: StackStatusValid, DeletedStackNotDescribable, UniqueStackNamesPerAccount

  Background:
    Given the system is initialized

  @minimal @happy @create_stack
  Scenario: a "cloudformation" "stack" is created
    Given the "cloudformation" "stack" did not already exist
    When a "cloudformation" "stack" is created
    Then the "cloudformation" "stack" will be "CREATE_COMPLETE"
    And every "cloudformation" "stack" has a valid status
    And deleted "cloudformation" "stacks" are not describable
    And "cloudformation" "stack" names are unique per account

  @guard @negative @create_stack
  Scenario: a "cloudformation" "stack" is created fails when the "cloudformation" "stack" already existed
    Given the "cloudformation" "stack" already existed
    When a "cloudformation" "stack" is created
    Then the operation is rejected
