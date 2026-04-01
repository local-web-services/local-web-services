@organizations @generated
Feature: Organizations - An "Organizations" Resource Is Tagged

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: an "organizations" resource is tagged
    Given the "organizations" resource existed
    When an "organizations" resource is tagged
    Then the "organizations" resource tags will be set
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @guard @negative @tag_resource
  Scenario: an "organizations" resource is tagged fails when the "organizations" resource did not exist
    Given the "organizations" resource did not exist
    When an "organizations" resource is tagged
    Then the operation is rejected
