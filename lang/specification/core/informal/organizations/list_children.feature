@organizations @generated
Feature: Organizations - Children Are Listed

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @list_children
  Scenario: an "organizations" resource's account children are listed
    Given the "organizations" "organization" existed
    And the "organizations" "account" existed under an "organizations" "organizational unit"
    When "ListChildren" is called with the "organizations" "organizational unit" id and child type "ACCOUNT"
    Then the "organizations" "account" children will be returned

  @minimal @happy @list_children
  Scenario: an "organizations" resource's ou children are listed
    Given the "organizations" "organization" existed
    And multiple "organizations" "organizational units" existed under the root
    When "ListChildren" is called with the root id and child type "ORGANIZATIONAL_UNIT"
    Then the "organizations" "organizational unit" children will be returned

  @guard @negative @list_children
  Scenario: "ListChildren" fails when child type is invalid
    Given the "organizations" "organization" existed
    When "ListChildren" is called with an invalid child type
    Then the operation is rejected
