@lambdards @generated
Feature: LambdaRds - Action Sequences

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" database instance is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid not in func_status
    When a Lambda function is deployed
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the database is failing over
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then a Lambda function is deployed
    Given did not in db_status
    When an "RDS" database instance is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given did not in db_status
    When an "RDS" database instance is created
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    When an "RDS" database instance is created
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function is invoked
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Lambda function is deployed
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then an "RDS" database instance is created
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "RDS" database instance is created
    Given fid in func_status
    When the Lambda function is invoked
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid in func_status
    When the Lambda function is invoked
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    When the Lambda function is invoked
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid not in func_status
    When a Lambda function is deployed
    When an "RDS" database instance is created
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    When a Lambda function is deployed
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the database is failing over
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    When an "RDS" database instance is created
    When a Lambda function is deployed
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given did not in db_status
    When an "RDS" database instance is created
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    When an "RDS" database instance is created
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function is invoked
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance
    Given did not in db_status
    When an "RDS" database instance is created
    When the Lambda function fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed then the Lambda function is invoked
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When an "RDS" database instance is created
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked then a Lambda function is deployed
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function fails to connect because the database is failing over
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When a Lambda function is deployed
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When an "RDS" database instance is created
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "RDS" instance
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked then an "RDS" database instance is created
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function is invoked
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over then the Lambda function is invoked
    Given did in db_status
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the database is failing over
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "RDS" database instance is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an "RDS" database instance is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Multi-"AZ" failover begins on the "RDS" instance
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid in func_status
    When the Lambda function is invoked
    When the Multi-"AZ" failover completes and the new primary is promoted
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed then an "RDS" database instance is created
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Lambda function is deployed
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When an "RDS" database instance is created
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to connect because the database is failing over
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When the Lambda function fails to connect because the database is failing over
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When a Lambda function is deployed
    When a Multi-"AZ" failover begins on the "RDS" instance
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When an "RDS" database instance is created
    When the Multi-"AZ" failover completes and the new primary is promoted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "RDS" instance
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Multi-"AZ" failover completes and the new primary is promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given iid in inv_status
    When the Lambda function fails to connect because the database is failing over
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    When an "RDS" database instance is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried
