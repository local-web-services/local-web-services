@elasticache @create_cache_cluster @controlplane
Feature: ElastiCache CreateCacheCluster

  @happy
  Scenario: Create a cache cluster
    When I create a cache cluster "e2e-create-cache-cluster"
    Then the command will succeed
    And cache cluster "e2e-create-cache-cluster" will have status "available"

  @happy
  Scenario: Describe cache clusters lists a created cluster
    Given a cache cluster "e2e-describe-cache-clusters" was created
    When I describe cache clusters
    Then the command will succeed
    And cache cluster "e2e-describe-cache-clusters" will appear in the list

  @happy
  Scenario: Delete a cache cluster
    Given a cache cluster "e2e-delete-cache-cluster" was created
    When I delete cache cluster "e2e-delete-cache-cluster"
    Then the command will succeed
    And cache cluster "e2e-delete-cache-cluster" will not appear in the list
