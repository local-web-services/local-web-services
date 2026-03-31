@lambdaelasticache @generated
Feature: LambdaElasticache - The "Lambda" "Function" Writes A Value To The "Elasticache" "Cluster" During Invocation

  # Generated from FizzBee spec: lambda_elasticache.fizz
  # Safety invariants: InvocationRequiresActiveFunction, CachedEntryRequiresAvailableCluster

  Background:
    Given the system is initialized

  @minimal @happy @cache_write
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And a key slot is available
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the cache entry will be "CACHED" in the cluster
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "CACHED" entry belongs to an "AVAILABLE" cluster

  @guard @negative @cache_write @lifecycle
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when the "elasticache" "cluster" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" did not exist
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write @lifecycle
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when the "elasticache" "cluster" was not "AVAILABLE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was not "AVAILABLE"
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected

  @guard @negative @cache_write @capacity
  Scenario: the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation fails when no key slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "elasticache" "cluster" existed
    And the "elasticache" "cluster" was "AVAILABLE"
    And no key slot is available
    When the "lambda" "function" writes a value to the "elasticache" "cluster" during invocation
    Then the operation is rejected
