@opensearch @create_domain @controlplane
Feature: OpenSearch CreateDomain

  @happy
  Scenario: Create a new OpenSearch domain
    When I create opensearch domain "e2e-os-create-domain"
    Then the command will succeed
    And opensearch domain "e2e-os-create-domain" will exist

  @happy
  Scenario: List domains includes a created domain
    Given an opensearch domain "e2e-os-create-list" was created
    When I list opensearch domain names
    Then the command will succeed
    And the opensearch domain list will include "e2e-os-create-list"

  @happy
  Scenario: Delete an existing OpenSearch domain
    Given an opensearch domain "e2e-os-create-del" was created
    When I delete opensearch domain "e2e-os-create-del"
    Then the command will succeed
    And the opensearch domain list will not include "e2e-os-create-del"
