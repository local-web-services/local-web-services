@cloudformation @generated
Feature: CLOUDFORMATION - A Cloudformation Stack Is Updated

  # Generated from FizzBee spec: cloudformation.fizz
  # Safety invariants: StackStatusValid, DeletedStackNotDescribable, UniqueStackNamesPerAccount

  Background:
    Given the system is initialized

  @minimal @happy @update_stack
  Scenario: a cloudformation stack is updated
    Given the cloudformation stack existed
    When a cloudformation stack is updated
    Then the "cloudformation" "stack" will be "UPDATE_COMPLETE"
    And every cloudformation stack has a valid status
    And deleted cloudformation stacks are not describable
    And stack names are unique per account

  @guard @negative @update_stack
  Scenario: a cloudformation stack is updated fails when the cloudformation stack did not exist
    Given the cloudformation stack did not exist
    When a cloudformation stack is updated
    Then the operation is rejected
