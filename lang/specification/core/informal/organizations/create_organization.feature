@organizations @generated
Feature: Organizations - An "Organizations" "Organization" Is Created

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_organization
  Scenario: an "organizations" "organization" is created
    Given the "organizations" "organization" did not already exist
    When an "organizations" "organization" is created
    Then the "organizations" "organization" and its root will exist
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @create_organization
  Scenario: an "organizations" "organization" is created fails when the "organizations" "organization" already existed
    Given the "organizations" "organization" already existed
    When an "organizations" "organization" is created
    Then the operation is rejected
