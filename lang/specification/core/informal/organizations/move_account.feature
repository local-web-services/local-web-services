@organizations @generated
Feature: Organizations - An "Organizations" "Account" Is Moved To A New Parent

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @move_account
  Scenario: an "organizations" "account" is moved to a new parent
    Given the "organizations" "account" existed and was "ACTIVE"
    And the source parent matched the "organizations" "account"'s current parent
    And the destination "organizations" "parent" was "ACTIVE"
    When an "organizations" "account" is moved to a new parent
    Then the "organizations" "account" will be under the new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @move_account
  Scenario: an "organizations" "account" is moved to a new parent fails when the "organizations" "account" did not exist or was "ACTIVE"
    Given the "organizations" "account" did not exist or was "ACTIVE"
    When an "organizations" "account" is moved to a new parent
    Then the operation is rejected

  @guard @negative @move_account
  Scenario: an "organizations" "account" is moved to a new parent fails when the source parent did not match the "organizations" "account"'s current parent
    Given the "organizations" "account" existed and was "ACTIVE"
    And the source parent did not match the "organizations" "account"'s current parent
    When an "organizations" "account" is moved to a new parent
    Then the operation is rejected

  @guard @negative @move_account
  Scenario: an "organizations" "account" is moved to a new parent fails when the destination "organizations" "parent" was not "ACTIVE"
    Given the "organizations" "account" existed and was "ACTIVE"
    And the source parent matched the "organizations" "account"'s current parent
    And the destination "organizations" "parent" was not "ACTIVE"
    When an "organizations" "account" is moved to a new parent
    Then the operation is rejected
