@neptune @create_db_cluster @controlplane
Feature: Neptune CreateDBCluster

  @happy
  Scenario: Create a Neptune DB cluster
    When I create a Neptune DB cluster "e2e-neptune-create"
    Then the command will succeed
    And cluster "e2e-neptune-create" will appear in describe-db-clusters

  @happy
  Scenario: Create and describe a Neptune DB cluster by identifier
    Given a Neptune DB cluster "e2e-neptune-desc-id" was created
    When I describe Neptune DB clusters with identifier "e2e-neptune-desc-id"
    Then the command will succeed
    And the output will contain exactly 1 DB cluster
    And the output DB cluster identifier will be "e2e-neptune-desc-id"

  @happy
  Scenario: Create and delete a Neptune DB cluster
    Given a Neptune DB cluster "e2e-neptune-delete" was created
    When I delete Neptune DB cluster "e2e-neptune-delete"
    Then the command will succeed
    And cluster "e2e-neptune-delete" will not appear in describe-db-clusters
