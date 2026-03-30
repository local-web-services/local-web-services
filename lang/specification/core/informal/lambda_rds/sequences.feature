@lambdards @generated
Feature: LambdaRds - Action Sequences

  # Generated from FizzBee spec: lambda_rds.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedADB

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then an "RDS" database instance is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the database is failing over
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then a Lambda function is deployed
    Given did not in db_status
    Given an "RDS" database instance has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given did not in db_status
    Given an "RDS" database instance has been created
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    Given an "RDS" database instance has been created
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function is invoked
    Given did not in db_status
    Given an "RDS" database instance has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    Given an "RDS" database instance has been created
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over
    Given did not in db_status
    Given an "RDS" database instance has been created
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Lambda function is deployed
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then an "RDS" database instance is created
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then an "RDS" database instance is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "RDS" database instance has been created
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to connect because the database is failing over
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then a Lambda function is deployed then the Multi-"AZ" failover completes and the new primary is promoted
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given a Lambda function has been deployed
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance
    Given did not in db_status
    Given an "RDS" database instance has been created
    Given the Lambda function has failed to connect because the database is failing over
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed then the Lambda function is invoked
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given an "RDS" database instance has been created
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked then a Lambda function is deployed
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted
    Given did in db_status
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    Given the Lambda function has failed to connect because the database is failing over
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Lambda function is deployed then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given a Lambda function has been deployed
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then an "RDS" database instance is created then the Lambda function fails to connect because the database is failing over
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given an "RDS" database instance has been created
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance then a Lambda function is deployed
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked then an "RDS" database instance is created
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given the Lambda function has been invoked
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function fails to connect because the database is failing over then the Lambda function is invoked
    Given did in db_status
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    Given the Lambda function has failed to connect because the database is failing over
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the database is failing over
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then an "RDS" database instance is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an "RDS" database instance has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then a Multi-"AZ" failover begins on the "RDS" instance then an "RDS" database instance is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Multi-"AZ" failover completes and the new primary is promoted then a Multi-"AZ" failover begins on the "RDS" instance
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to connect because the database is failing over
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Lambda function is deployed then an "RDS" database instance is created
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given a Lambda function has been deployed
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given an "RDS" database instance has been created
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then a Multi-"AZ" failover begins on the "RDS" instance then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the database is failing over
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the database is failing over
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then the Lambda function fails to connect because the database is failing over then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    Given the Lambda function has failed to connect because the database is failing over
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Lambda function is deployed then a Multi-"AZ" failover begins on the "RDS" instance
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given a Lambda function has been deployed
    When a Multi-"AZ" failover begins on the "RDS" instance
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then an "RDS" database instance is created then the Multi-"AZ" failover completes and the new primary is promoted
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given an "RDS" database instance has been created
    When the Multi-"AZ" failover completes and the new primary is promoted
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then a Multi-"AZ" failover begins on the "RDS" instance then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given a Multi-"AZ" failover has begun on the "RDS" instance
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Multi-"AZ" failover completes and the new primary is promoted then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given the Multi-"AZ" failover has completed and the new primary has been promoted
    When the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried

  @sequence
  Scenario: the Lambda function fails to connect because the database is failing over then the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds then an "RDS" database instance is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the database is failing over
    Given the Lambda function has executed a "SQL" query against the "AVAILABLE" database and succeeded
    When an "RDS" database instance is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which database it queried
