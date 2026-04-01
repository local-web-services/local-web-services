@lambdas3tables @generated
Feature: LambdaS3tables - Action Sequences

  # Generated from FizzBee spec: lambda_s3tables.fizz
  # Safety invariants: InvocationRequiresActiveFunction, RecordReferencesExistingTable

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "table" deletion is initiated
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "s3 tables" "table" deletion is initiated
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" fails to write because the table is being deleted
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "bucket" is created
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "table" deletion is initiated
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" is invoked
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" fails to write because the table is being deleted
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "lambda" "function" is deployed
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "bucket" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" is invoked
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" fails to write because the table is being deleted
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "bucket" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "table" deletion is initiated
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "bucket" is created then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "table" deletion is initiated
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3 tables" "table" deletion is initiated then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "lambda" "function" is deployed then a "s3 tables" "table" deletion is initiated
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then a "s3 tables" "table" deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "bucket" is created then the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given bid not in bucket_status
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "bucket" is created then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "table" deletion is initiated then the "lambda" "function" fails to write because the table is being deleted
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "bucket" is created
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" deletion is initiated
    Given bid in bucket_status
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "lambda" "function" is deployed then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "bucket" is created then the "lambda" "function" fails to write because the table is being deleted
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "bucket" is created
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "lambda" "function" is deployed
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" is invoked then a "s3 tables" "bucket" is created
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" is invoked
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: a "s3 tables" "table" deletion is initiated then the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked
    Given tid in table_status
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to write because the table is being deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "bucket" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "bucket" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3 tables" "table" deletion is initiated then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3 tables" "table" deletion is initiated
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" deletion is initiated
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "lambda" "function" is deployed then a "s3 tables" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "lambda" "function" is deployed
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "bucket" is created then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" is created in the "s3 tables" "bucket" then a "s3 tables" "table" deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "table" deletion is initiated then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the table is being deleted
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the table is being deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "lambda" "function" is deployed then a "s3 tables" "table" is created in the "s3 tables" "bucket"
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "lambda" "function" is deployed
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "bucket" is created then a "s3 tables" "table" deletion is initiated
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "bucket" is created
    When a "s3 tables" "table" deletion is initiated
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" is created in the "s3 tables" "bucket" then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" is created in the "s3 tables" "bucket"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then a "s3 tables" "table" deletion is initiated then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When a "s3 tables" "table" deletion is initiated
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the table is being deleted then the "lambda" "function" writes a record to an "ACTIVE" table and succeeds then a "s3 tables" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" fails to write because the table is being deleted
    When the "lambda" "function" writes a record to an "ACTIVE" table and succeeds
    When a "s3 tables" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing "s3 tables" "record" references a "s3 tables" "table" that exists
