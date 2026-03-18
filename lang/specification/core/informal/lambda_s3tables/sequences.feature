@lambdas3tables @generated
Feature: LambdaS3tables - Action Sequences

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: an S3 table bucket is created then the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table is created in the table bucket then the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked then the Lambda function fails to write because the table is being deleted
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to write because the table is being deleted
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function fails to write because the table is being deleted then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a Lambda function is deployed then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a Lambda function is deployed
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then an S3 table bucket is created then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When an S3 table bucket is created
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table is created in the table bucket then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table is created in the table bucket
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then a table deletion is initiated then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When a table deletion is initiated
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function is invoked then the Lambda function writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function is invoked
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds then an S3 table bucket is created
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When an S3 table bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table is created in the table bucket
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table is created in the table bucket
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds then a table deletion is initiated
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When a table deletion is initiated
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the table is being deleted then the Lambda function writes a record to an "ACTIVE" table and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the table is being deleted
    When the Lambda function writes a record to an "ACTIVE" table and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing record references a table that exists
