@rdslambda @generated
Feature: RdsLambda - Action Sequences

  # Generated from FizzBee spec: rds_lambda.fizz
  # Safety invariants: SuccessfulInvocationReferencesExistingDB, SuccessfulInvocationInvokedAFunction

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Lambda function is deployed
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the Lambda function is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" "DB" instance is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" "DB" instance is created
    Given fid in func_status
    Given the Lambda function has been deleted
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been deleted
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given fid in func_status
    Given the Lambda function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given fid in func_status
    Given the Lambda function has been deleted
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid in func_status
    Given the Lambda function has been deleted
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then a Lambda function is deployed
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then the Lambda function is deleted
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then a Lambda function is deployed
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then the Lambda function is deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a Lambda function is deployed
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the Lambda function is deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then a Lambda function is deployed then the Lambda function is deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given a Lambda function has been deployed
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the Lambda function is deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given the Lambda function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" "DB" instance is created then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a Lambda function is deployed
    Given dbid not in db_status
    Given an "RDS" "DB" instance has been created
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" "DB" instance is created then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "RDS" "DB" instance has been created
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is deleted then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been deleted
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" "DB" instance is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the Lambda function is deleted
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" "DB" instance is created then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given fid in func_status
    Given the Lambda function has been deleted
    Given an "RDS" "DB" instance has been created
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then a Lambda function is deployed then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given fid in func_status
    Given the Lambda function has been deleted
    Given a Lambda function has been deployed
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" "DB" instance is created
    Given fid in func_status
    Given the Lambda function has been deleted
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" stored procedure invokes the Lambda function and succeeds then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been deleted
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the Lambda function is deleted then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given fid in func_status
    Given the Lambda function has been deleted
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" "DB" instance is created then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    Given an "RDS" "DB" instance has been created
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then a Lambda function is deployed then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    Given a Lambda function has been deployed
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then the Lambda function is deleted then a Lambda function is deployed
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    Given the Lambda function has been deleted
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure invokes the Lambda function and succeeds then the Lambda function is deleted
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid in db_status
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" "DB" instance is created then a Lambda function is deployed
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    Given an "RDS" "DB" instance has been created
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then a Lambda function is deployed then the Lambda function is deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    Given a Lambda function has been deployed
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then the Lambda function is deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    Given the Lambda function has been deleted
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" stored procedure fails to invoke Lambda because the function has been deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure invokes the Lambda function and succeeds then an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" "DB" instance is created then the Lambda function is deleted
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    Given an "RDS" "DB" instance has been created
    When the Lambda function is deleted
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then a Lambda function is deployed then the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    Given a Lambda function has been deployed
    When the "DB" instance is configured with an "IAM" role to invoke the Lambda function
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the Lambda function is deleted then an "RDS" stored procedure invokes the Lambda function and succeeds
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    Given the Lambda function has been deleted
    When an "RDS" stored procedure invokes the Lambda function and succeeds
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then the "DB" instance is configured with an "IAM" role to invoke the Lambda function then an "RDS" "DB" instance is created
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    Given the "DB" instance has been configured with an "IAM" role to invoke the Lambda function
    When an "RDS" "DB" instance is created
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked

  @exhaustive @sequence
  Scenario: an "RDS" stored procedure fails to invoke Lambda because the function has been deleted then an "RDS" stored procedure invokes the Lambda function and succeeds then a Lambda function is deployed
    Given dbid in db_status
    Given an "RDS" stored procedure has failed to invoke Lambda because the function has been deleted
    Given an "RDS" stored procedure has invoked the Lambda function and succeeded
    When a Lambda function is deployed
    Then every successful invocation references a "DB" instance that exists
    And every successful invocation recorded which function it invoked
