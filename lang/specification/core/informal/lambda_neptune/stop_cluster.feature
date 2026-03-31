@lambdaneptune @generated
Feature: LambdaNeptune - The "Neptune" "Cluster" Is Stopped

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @minimal @happy @stop_cluster
  Scenario: the "neptune" "cluster" is stopped
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was "AVAILABLE"
    When the "neptune" "cluster" is stopped
    Then the "neptune" "cluster" will be "STOPPED" and graph queries will be rejected
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @guard @negative @stop_cluster
  Scenario: the "neptune" "cluster" is stopped fails when the "neptune" "cluster" did not exist
    Given the "neptune" "cluster" did not exist
    When the "neptune" "cluster" is stopped
    Then the operation is rejected

  @guard @negative @stop_cluster @lifecycle
  Scenario: the "neptune" "cluster" is stopped fails when the "neptune" "cluster" was not "AVAILABLE"
    Given the "neptune" "cluster" existed
    And the "neptune" "cluster" was not "AVAILABLE"
    When the "neptune" "cluster" is stopped
    Then the operation is rejected
