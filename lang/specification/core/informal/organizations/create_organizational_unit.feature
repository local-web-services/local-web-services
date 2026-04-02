@organizations @generated
Feature: Organizations - An "Organizations" "Organizational Unit" Is Created Under A Parent

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_organizational_unit
  Scenario: an "organizations" "organizational unit" is created under a parent
    Given the "organizations" "organization" existed
    And the "organizations" "parent" existed and was "ACTIVE"
    And the "organizations" "organizational unit" did not already exist
    When an "organizations" "organizational unit" is created under a parent
    Then the "organizations" "organizational unit" will be "ACTIVE"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @create_organizational_unit
  Scenario: an "organizations" "organizational unit" is created under a parent fails when the "organizations" "organization" did not exist
    Given the "organizations" "organization" did not exist
    When an "organizations" "organizational unit" is created under a parent
    Then the operation is rejected

  @guard @negative @create_organizational_unit
  Scenario: an "organizations" "organizational unit" is created under a parent fails when the "organizations" "parent" did not exist or was "ACTIVE"
    Given the "organizations" "organization" existed
    And the "organizations" "parent" did not exist or was "ACTIVE"
    When an "organizations" "organizational unit" is created under a parent
    Then the operation is rejected

  @guard @negative @create_organizational_unit
  Scenario: an "organizations" "organizational unit" is created under a parent fails when the "organizations" "organizational unit" already existed
    Given the "organizations" "organization" existed
    And the "organizations" "parent" existed and was "ACTIVE"
    And the "organizations" "organizational unit" already existed
    When an "organizations" "organizational unit" is created under a parent
    Then the operation is rejected
