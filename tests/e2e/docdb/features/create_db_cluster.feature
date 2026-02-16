@docdb @create_db_cluster @controlplane
Feature: DocDB CreateDBCluster

  @happy
  Scenario: Create a new DB cluster
    When I create a DocDB cluster "e2e-docdb-create"
    Then the command will succeed
    And DocDB cluster "e2e-docdb-create" will exist

  @happy
  Scenario: Describe a DB cluster by identifier
    Given a DocDB cluster "e2e-docdb-desc-id" was created
    When I describe DocDB clusters with identifier "e2e-docdb-desc-id"
    Then the command will succeed
    And the output will contain exactly one cluster "e2e-docdb-desc-id"

  @happy
  Scenario: Delete an existing DB cluster
    Given a DocDB cluster "e2e-docdb-delete" was created
    When I delete DocDB cluster "e2e-docdb-delete"
    Then the command will succeed
    And DocDB cluster "e2e-docdb-delete" will not exist
