@s3apilambda @generated
Feature: S3apiLambda - Action Sequences

  # Generated from FizzBee spec: s3api_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket

  Background:
    Given the system is initialized

  @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an S3 bucket is created
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation fails
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a Lambda function is deployed
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a Lambda function has been deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails then a Lambda function is deployed
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an S3 bucket has been created
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an S3 bucket is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an S3 bucket is created then the Lambda invocation completes successfully
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    Given an S3 bucket has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed then the Lambda invocation fails
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully then a Lambda function is deployed
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given bid in bucket_status
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    Given the Lambda invocation has failed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created then the Lambda invocation fails
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    Given an S3 bucket has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then a Lambda function is deployed then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    Given a Lambda function has been deployed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 event notification is configured to invoke a Lambda function on object "PUT" then a Lambda function is deployed
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    Given the Lambda invocation has completed successfully
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails then the Lambda invocation completes successfully
    Given bid in bucket_status
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an S3 bucket has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an S3 event notification is configured to invoke a Lambda function on object "PUT" then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then an object is put into the bucket and asynchronously invokes the configured Lambda function then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created then an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an S3 bucket has been created
    When an S3 event notification is configured to invoke a Lambda function on object "PUT"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an object is put into the bucket and asynchronously invokes the configured Lambda function
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When an object is put into the bucket and asynchronously invokes the configured Lambda function
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an S3 event notification is configured to invoke a Lambda function on object "PUT" then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an S3 event notification has been configured to invoke a Lambda function on object "PUT"
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then an object is put into the bucket and asynchronously invokes the configured Lambda function then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an object has been put into the bucket and asynchronously invoked the configured Lambda function
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket
