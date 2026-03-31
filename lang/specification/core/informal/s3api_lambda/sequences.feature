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
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "s3" "bucket" is created
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation completes successfully
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation fails
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a "lambda" "function" is deployed
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the Lambda invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation fails then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "s3" "bucket" is created then the Lambda invocation completes successfully
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "s3" "bucket" is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed then the Lambda invocation fails
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function then a "s3" "bucket" is created
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a "s3" "bucket" is created then the Lambda invocation fails
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then a "lambda" "function" is deployed
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "s3" "bucket" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "s3" "bucket" is created then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    Given iid in inv_status
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a S3 event notification is configured to invoke a "lambda" "function" on object "PUT" then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a S3 event notification is configured to invoke a "lambda" "function" on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket
