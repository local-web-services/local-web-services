@lambdaelasticache @generated
Feature: LambdaElasticache - A Lambda Function Is Deployed

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @deploy_function
  Scenario: a Lambda function is deployed
    Given the function does not already exist
    When a Lambda function is deployed
    Then the function is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @deploy_function
  Scenario: a Lambda function is deployed fails when the function already exists
    Given the function already exists
    When a Lambda function is deployed
    Then the operation is rejected
