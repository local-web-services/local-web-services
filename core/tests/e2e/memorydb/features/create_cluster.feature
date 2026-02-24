@memorydb @create_cluster @controlplane
Feature: MemoryDB CreateCluster

  @happy
  Scenario: Create a MemoryDB cluster
    When I create a MemoryDB cluster "e2e-create-memorydb"
    Then the command will succeed
    And MemoryDB cluster "e2e-create-memorydb" will have status "available"

  @happy
  Scenario: Describe MemoryDB clusters lists a created cluster
    Given a MemoryDB cluster "e2e-describe-memorydb" was created
    When I describe MemoryDB clusters
    Then the command will succeed
    And MemoryDB cluster "e2e-describe-memorydb" will appear in the list

  @happy
  Scenario: Delete a MemoryDB cluster
    Given a MemoryDB cluster "e2e-delete-memorydb" was created
    When I delete MemoryDB cluster "e2e-delete-memorydb"
    Then the command will succeed
    And MemoryDB cluster "e2e-delete-memorydb" will not appear in the list
