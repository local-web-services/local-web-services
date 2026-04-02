@organizations @generated
Feature: Organizations - An "Organizations" "Policy" Is Attached To A Target

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @attach_policy
  Scenario: an "organizations" "policy" is attached to a target
    Given the "organizations" "policy" existed and was "ACTIVE"
    And the "organizations" "target" existed and was "ACTIVE"
    And the "organizations" "policy" was not already attached to the "organizations" "target"
    When an "organizations" "policy" is attached to a target
    Then the "organizations" "policy" will be attached to the "organizations" "target"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @attach_policy
  Scenario: an "organizations" "policy" is attached to a target fails when the "organizations" "policy" did not exist or was "ACTIVE"
    Given the "organizations" "policy" did not exist or was "ACTIVE"
    When an "organizations" "policy" is attached to a target
    Then the operation is rejected

  @guard @negative @attach_policy
  Scenario: an "organizations" "policy" is attached to a target fails when the "organizations" "target" did not exist or was "ACTIVE"
    Given the "organizations" "policy" existed and was "ACTIVE"
    And the "organizations" "target" did not exist or was "ACTIVE"
    When an "organizations" "policy" is attached to a target
    Then the operation is rejected

  @guard @negative @attach_policy
  Scenario: an "organizations" "policy" is attached to a target fails when the "organizations" "policy" was already attached to the "organizations" "target"
    Given the "organizations" "policy" existed and was "ACTIVE"
    And the "organizations" "target" existed and was "ACTIVE"
    And the "organizations" "policy" was already attached to the "organizations" "target"
    When an "organizations" "policy" is attached to a target
    Then the operation is rejected
