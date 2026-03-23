@organizations @generated
Feature: Organizations - An Organizational Unit Is Created Under A Parent

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_organizational_unit
  Scenario: an organizational unit is created under a parent
    Given the organization exists
    And the parent exists and is "ACTIVE"
    And the organizational unit does not already exist
    When an organizational unit is created under a parent
    Then the organizational unit is "ACTIVE"
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @standard @negative @create_organizational_unit
  Scenario: an organizational unit is created under a parent fails when the organization does not exist
    Given the organization does not exist
    When an organizational unit is created under a parent
    Then the operation is rejected

  @standard @negative @create_organizational_unit
  Scenario: an organizational unit is created under a parent fails when the parent does not exist or is not "ACTIVE"
    Given the organization exists
    And the parent does not exist or is not "ACTIVE"
    When an organizational unit is created under a parent
    Then the operation is rejected

  @standard @negative @create_organizational_unit
  Scenario: an organizational unit is created under a parent fails when the organizational unit already exists
    Given the organization exists
    And the parent exists and is "ACTIVE"
    And the organizational unit already exists
    When an organizational unit is created under a parent
    Then the operation is rejected
