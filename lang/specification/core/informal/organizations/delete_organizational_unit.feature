@organizations @generated
Feature: Organizations - An "Organizations" "Organizational Unit" Is Deleted

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_organizational_unit
  Scenario: an "organizations" "organizational unit" is deleted
    Given the "organizations" "organizational unit" existed and was "ACTIVE"
    And the "organizations" "organizational unit" has no child accounts
    And the "organizations" "organizational unit" has no child organizational units
    And the "organizations" "organizational unit" has no attached policies
    When an "organizations" "organizational unit" is deleted
    Then the "organizations" "organizational unit" will be "DELETED"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @delete_organizational_unit
  Scenario: an "organizations" "organizational unit" is deleted fails when the "organizations" "organizational unit" did not exist or was "ACTIVE"
    Given the "organizations" "organizational unit" did not exist or was "ACTIVE"
    When an "organizations" "organizational unit" is deleted
    Then the operation is rejected

  @guard @negative @delete_organizational_unit
  Scenario: an "organizations" "organizational unit" is deleted fails when the "organizations" "organizational unit" has child accounts
    Given the "organizations" "organizational unit" existed and was "ACTIVE"
    And the "organizations" "organizational unit" has child accounts
    When an "organizations" "organizational unit" is deleted
    Then the operation is rejected

  @guard @negative @delete_organizational_unit
  Scenario: an "organizations" "organizational unit" is deleted fails when the "organizations" "organizational unit" has child organizational units
    Given the "organizations" "organizational unit" existed and was "ACTIVE"
    And the "organizations" "organizational unit" has no child accounts
    And the "organizations" "organizational unit" has child organizational units
    When an "organizations" "organizational unit" is deleted
    Then the operation is rejected

  @guard @negative @delete_organizational_unit
  Scenario: an "organizations" "organizational unit" is deleted fails when the "organizations" "organizational unit" has attached policies
    Given the "organizations" "organizational unit" existed and was "ACTIVE"
    And the "organizations" "organizational unit" has no child accounts
    And the "organizations" "organizational unit" has no child organizational units
    And the "organizations" "organizational unit" has attached policies
    When an "organizations" "organizational unit" is deleted
    Then the operation is rejected
