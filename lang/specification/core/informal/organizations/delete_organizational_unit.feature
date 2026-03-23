@organizations @generated
Feature: Organizations - An Organizational Unit Is Deleted

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_organizational_unit
  Scenario: an organizational unit is deleted
    Given the organizational unit exists and is "ACTIVE"
    And the organizational unit has no child accounts
    And the organizational unit has no child organizational units
    And the organizational unit has no attached policies
    When an organizational unit is deleted
    Then the organizational unit is "DELETED"
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @standard @negative @delete_organizational_unit
  Scenario: an organizational unit is deleted fails when the organizational unit does not exist or is not "ACTIVE"
    Given the organizational unit does not exist or is not "ACTIVE"
    When an organizational unit is deleted
    Then the operation is rejected

  @standard @negative @delete_organizational_unit
  Scenario: an organizational unit is deleted fails when the organizational unit has child accounts
    Given the organizational unit exists and is "ACTIVE"
    And the organizational unit has child accounts
    When an organizational unit is deleted
    Then the operation is rejected

  @standard @negative @delete_organizational_unit
  Scenario: an organizational unit is deleted fails when the organizational unit has child organizational units
    Given the organizational unit exists and is "ACTIVE"
    And the organizational unit has no child accounts
    And the organizational unit has child organizational units
    When an organizational unit is deleted
    Then the operation is rejected

  @standard @negative @delete_organizational_unit
  Scenario: an organizational unit is deleted fails when the organizational unit has attached policies
    Given the organizational unit exists and is "ACTIVE"
    And the organizational unit has no child accounts
    And the organizational unit has no child organizational units
    And the organizational unit has attached policies
    When an organizational unit is deleted
    Then the operation is rejected
