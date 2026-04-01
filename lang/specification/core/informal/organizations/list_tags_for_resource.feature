@organizations @generated
Feature: Organizations - Resource Tags Are Listed

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @list_tags_for_resource
  Scenario: an "organizations" resource tags are listed for a tagged account
    Given the "organizations" "organization" existed
    And the "organizations" "account" existed with tags
    When "ListTagsForResource" is called with the account id
    Then the "organizations" tags will be returned

  @guard @negative @list_tags_for_resource
  Scenario: an "organizations" resource tags are listed for an unknown resource returns empty list
    Given the "organizations" "organization" existed
    When "ListTagsForResource" is called with an unknown resource id
    Then an empty "organizations" tag list will be returned
