@organizations @generated
Feature: Organizations - An "Organizations" "Policy" Is Detached From A Target

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @detach_policy
  Scenario: an "organizations" "policy" is detached from a target
    Given the "organizations" "policy" is attached to the "organizations" "target"
    When an "organizations" "policy" is detached from a target
    Then the "organizations" "policy" will no longer be attached to the "organizations" "target"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @detach_policy
  Scenario: an "organizations" "policy" is detached from a target fails when the "organizations" "policy" is not attached to the "organizations" "target"
    Given the "organizations" "policy" is not attached to the "organizations" "target"
    When an "organizations" "policy" is detached from a target
    Then the operation is rejected
