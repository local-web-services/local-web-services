@organizations @generated
Feature: Organizations - A Policy Is Detached From A Target

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @detach_policy
  Scenario: a policy is detached from a target
    Given the policy is attached to the target
    When a policy is detached from a target
    Then the policy is no longer attached to the target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @detach_policy
  Scenario: a policy is detached from a target fails when the policy is not attached to the target
    Given the policy is not attached to the target
    When a policy is detached from a target
    Then the operation is rejected
