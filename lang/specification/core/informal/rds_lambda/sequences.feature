@rdslambda @generated
Feature: RdsLambda - Action Sequences

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "lambda" "function" is deployed
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "lambda" "function" is deleted
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" "DB" instance is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" "DB" instance is created
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given fid in func_status
    When the "lambda" "function" is deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "lambda" "function" is deployed
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then the "lambda" "function" is deleted
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "lambda" "function" is deployed
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then the "lambda" "function" is deleted
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "lambda" "function" is deployed
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "lambda" "function" is deleted
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "lambda" "function" is deployed then the "lambda" "function" is deleted
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "lambda" "function" is deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "lambda" "function" is deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" "DB" instance is created then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "lambda" "function" is deployed
    Given dbid not in db_status
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" "DB" instance is created
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" "DB" instance is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "lambda" "function" is deployed then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "lambda" "function" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" "DB" instance is created then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "lambda" "function" is deployed then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "lambda" "function" is deployed
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" "DB" instance is created
    Given fid in func_status
    When the "lambda" "function" is deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "lambda" "function" is deleted then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given fid in func_status
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" "DB" instance is created then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" "DB" instance is created
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "lambda" "function" is deployed then a "RDS" "DB" instance is created
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "lambda" "function" is deployed
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then the "lambda" "function" is deleted then a "lambda" "function" is deployed
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When the "lambda" "function" is deleted
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure invokes the "lambda" "function" and succeeds then the "lambda" "function" is deleted
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid in db_status
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" "DB" instance is created then a "lambda" "function" is deployed
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" "DB" instance is created
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "lambda" "function" is deployed then the "lambda" "function" is deleted
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "lambda" "function" is deployed
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then the "lambda" "function" is deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When the "lambda" "function" is deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" "DB" instance is created then the "lambda" "function" is deleted
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" "DB" instance is created
    When the "lambda" "function" is deleted
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "lambda" "function" is deployed then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "lambda" "function" is deployed
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "lambda" "function" is deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "lambda" "function" is deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function" then a "RDS" "DB" instance is created
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the "lambda" "function"
    When a "RDS" "DB" instance is created
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @sequence
  Scenario: a "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a "RDS" stored procedure invokes the "lambda" "function" and succeeds then a "lambda" "function" is deployed
    Given dbid in db_status
    When a "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    When a "RDS" stored procedure invokes the "lambda" "function" and succeeds
    When a "lambda" "function" is deployed
    And every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked
