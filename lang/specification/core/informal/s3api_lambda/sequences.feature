@s3apilambda @generated
Feature: S3apiLambda - Action Sequences

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "s3" "bucket" is created
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation completes successfully
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation fails
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation completes successfully
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation fails
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "s3" "bucket" is created then the "lambda" "function" invocation completes successfully
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "s3" "bucket" is created
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation fails then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation fails
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "s3" "bucket" is created then the "lambda" "function" invocation fails
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "s3" "bucket" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given bid in bucket_status
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "s3" "bucket" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function" then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "s3" "object" is put into the "s3" "bucket" and asynchronously invokes the configured "lambda" "function"
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "s3" "object" in an "ACTIVE" "s3" "bucket"
