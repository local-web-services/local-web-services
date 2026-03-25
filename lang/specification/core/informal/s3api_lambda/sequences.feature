@s3apilambda @generated
Feature: S3apiLambda - Action Sequences

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an S3 bucket is created
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation fails
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a Lambda function is deployed
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Lambda function is deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 bucket is created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an S3 bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an S3 bucket is created then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an S3 bucket is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed then the Lambda invocation fails
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully then a Lambda function is deployed
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created then the Lambda invocation fails
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 bucket is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a Lambda function is deployed then an S3 bucket is created
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When a Lambda function is deployed
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation completes successfully
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given bid in bucket_status
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 bucket is created
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket
