@lambdas3api @generated
Feature: LambdaS3api - Action Sequences

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function is invoked
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 bucket is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an S3 bucket has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an S3 bucket is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a Lambda function has been deployed
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails then the Lambda function is invoked
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 bucket is created then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an S3 bucket has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has written an object to the S3 bucket during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an S3 bucket is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has completed successfully
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has failed
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then an S3 bucket is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    Given an S3 bucket has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda function is invoked then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    Given the Lambda function has been invoked
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has written an object to the S3 bucket during invocation
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an S3 bucket has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has been invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has written an object to the S3 bucket during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an S3 bucket has been created
    When the Lambda function writes an object to the S3 bucket during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has written an object to the S3 bucket during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When an S3 bucket is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket
