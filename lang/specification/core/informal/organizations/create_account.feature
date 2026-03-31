@organizations @generated
Feature: Organizations - An "Organizations" "Account" Is Created In The "Organizations" "Organization"

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_account
  Scenario: an "organizations" "account" is created in the "organizations" "organization"
    Given the "organizations" "organization" existed
    And the "organizations" "account" did not already exist
    When an "organizations" "account" is created in the "organizations" "organization"
    Then the "organizations" "account" will be "ACTIVE" under the root
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @create_account
  Scenario: an "organizations" "account" is created in the "organizations" "organization" fails when the "organizations" "organization" did not exist
    Given the "organizations" "organization" did not exist
    When an "organizations" "account" is created in the "organizations" "organization"
    Then the operation is rejected

  @guard @negative @create_account
  Scenario: an "organizations" "account" is created in the "organizations" "organization" fails when the "organizations" "account" already existed
    Given the "organizations" "organization" existed
    And the "organizations" "account" already existed
    When an "organizations" "account" is created in the "organizations" "organization"
    Then the operation is rejected
