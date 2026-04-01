@lambdas3tables @generated
Feature: LambdaS3tables - Action Sequences

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 table bucket is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a table is created in the table bucket
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a table deletion is initiated
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a table is created in the table bucket
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a table deletion is initiated
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" fails to write because the table is being deleted
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a "lambda" "function" is deployed
    Given tid in table_status
    When a table deletion is initiated
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" is invoked
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a S3 table bucket is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a table is created in the table bucket
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a table deletion is initiated
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a S3 table bucket is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a S3 table bucket is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a table is created in the table bucket
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a table deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 table bucket is created then a table is created in the table bucket
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a table is created in the table bucket then a table deletion is initiated
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a table deletion is initiated then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a table deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted then a S3 table bucket is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a "lambda" "function" is deployed then a table deletion is initiated
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a "lambda" "function" is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a table is created in the table bucket then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a table is created in the table bucket
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then a table deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When a S3 table bucket is created
    When a table deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a S3 table bucket is created then the "lambda" "function" fails to write because the table is being deleted then a table is created in the table bucket
    Given bid not in bucket_status
    When a S3 table bucket is created
    When the "lambda" "function" fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a S3 table bucket is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When a S3 table bucket is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then the "lambda" "function" fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table is created in the table bucket then the "lambda" "function" fails to write because the table is being deleted then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When the "lambda" "function" fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a S3 table bucket is created then the "lambda" "function" fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a S3 table bucket is created
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then a "lambda" "function" is deployed
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" is invoked then a S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" is invoked
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: a table deletion is initiated then the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked
    Given tid in table_status
    When a table deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a S3 table bucket is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a S3 table bucket is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a table is created in the table bucket then a S3 table bucket is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a table is created in the table bucket
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a table deletion is initiated then a table is created in the table bucket
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed then a S3 table bucket is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a S3 table bucket is created then a table is created in the table bucket
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then a table deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed then a table is created in the table bucket
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a S3 table bucket is created then a table deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a table is created in the table bucket then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a table is created in the table bucket
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a table deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a table deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a S3 table bucket is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists
