@elasticsearch @create_elasticsearch_domain @controlplane
Feature: Elasticsearch CreateElasticsearchDomain

  @happy
  Scenario: Create a new Elasticsearch domain
    When I create elasticsearch domain "e2e-es-create-domain"
    Then the command will succeed
    And elasticsearch domain "e2e-es-create-domain" will exist

  @happy
  Scenario: List domains includes a created domain
    Given an elasticsearch domain "e2e-es-create-list" was created
    When I list elasticsearch domain names
    Then the command will succeed
    And the elasticsearch domain list will include "e2e-es-create-list"

  @happy
  Scenario: Delete an existing Elasticsearch domain
    Given an elasticsearch domain "e2e-es-create-del" was created
    When I delete elasticsearch domain "e2e-es-create-del"
    Then the command will succeed
    And the elasticsearch domain list will not include "e2e-es-create-del"
