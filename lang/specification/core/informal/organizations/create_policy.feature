@organizations @generated
Feature: Organizations - An "Organizations" "Policy" Is Created

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_policy
  Scenario: an "organizations" "policy" is created
    Given the "organizations" "organization" existed
    And the "organizations" "policy" did not already exist
    When an "organizations" "policy" is created
    Then the "organizations" "policy" will be "ACTIVE"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @create_policy
  Scenario: an "organizations" "policy" is created fails when the "organizations" "organization" did not exist
    Given the "organizations" "organization" did not exist
    When an "organizations" "policy" is created
    Then the operation is rejected

  @guard @negative @create_policy
  Scenario: an "organizations" "policy" is created fails when the "organizations" "policy" already existed
    Given the "organizations" "organization" existed
    And the "organizations" "policy" already existed
    When an "organizations" "policy" is created
    Then the operation is rejected
