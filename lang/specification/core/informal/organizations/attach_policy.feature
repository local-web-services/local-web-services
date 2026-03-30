@organizations @generated
Feature: Organizations - A Policy Is Attached To A Target

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @attach_policy
  Scenario: a policy is attached to a target
    Given the policy exists and is "ACTIVE"
    And the target exists and is "ACTIVE"
    And the policy is not already attached to the target
    When a policy is attached to a target
    Then the policy is attached to the target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @attach_policy
  Scenario: a policy is attached to a target fails when the policy does not exist or is not "ACTIVE"
    Given the policy does not exist or is not "ACTIVE"
    When a policy is attached to a target
    Then the operation is rejected

  @guard @negative @attach_policy
  Scenario: a policy is attached to a target fails when the target does not exist or is not "ACTIVE"
    Given the policy exists and is "ACTIVE"
    And the target does not exist or is not "ACTIVE"
    When a policy is attached to a target
    Then the operation is rejected

  @guard @negative @attach_policy
  Scenario: a policy is attached to a target fails when the policy is already attached to the target
    Given the policy exists and is "ACTIVE"
    And the target exists and is "ACTIVE"
    And the policy is already attached to the target
    When a policy is attached to a target
    Then the operation is rejected
