@organizations @generated
Feature: Organizations - An "Organizations" "Policy" Is Detached From A Target

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @detach_policy
  Scenario: an "organizations" "policy" is detached from a target
    Given the "organizations" "policy" is attached to the "organizations" "target"
    When an "organizations" "policy" is detached from a target
    Then the "organizations" "policy" will no longer be attached to the "organizations" "target"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @detach_policy
  Scenario: an "organizations" "policy" is detached from a target fails when the "organizations" "policy" is not attached to the "organizations" "target"
    Given the "organizations" "policy" is not attached to the "organizations" "target"
    When an "organizations" "policy" is detached from a target
    Then the operation is rejected
