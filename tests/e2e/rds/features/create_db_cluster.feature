@rds @create_db_cluster @controlplane
Feature: RDS CreateDBCluster

  @happy
  Scenario: Create a new DB cluster
    When I create a DB cluster "e2e-rds-create-cluster"
    Then the command will succeed
    And DB cluster "e2e-rds-create-cluster" will exist

  @happy
  Scenario: Describe DB clusters
    Given a DB cluster "e2e-rds-describe-cluster" was created
    When I describe DB clusters
    Then the command will succeed
    And DB cluster "e2e-rds-describe-cluster" will appear in the output
