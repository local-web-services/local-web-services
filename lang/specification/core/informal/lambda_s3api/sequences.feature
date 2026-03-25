@lambdas3api @generated
Feature: LambdaS3api - Action Sequences

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then an S3 bucket is created
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an S3 bucket is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an S3 bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an S3 bucket is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Lambda function is deployed then the Lambda function writes an object to the S3 bucket during invocation
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Lambda function is deployed
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the Lambda invocation fails then the Lambda function is invoked
    Given bid not in bucket_status
    When an S3 bucket is created
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an S3 bucket is created then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When an S3 bucket is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an S3 bucket is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then an S3 bucket is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When an S3 bucket is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda function is invoked then an S3 bucket is created
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda function is invoked
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an S3 bucket is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function writes an object to the S3 bucket during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function writes an object to the S3 bucket during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an S3 bucket is created then the Lambda function writes an object to the S3 bucket during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When an S3 bucket is created
    When the Lambda function writes an object to the S3 bucket during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function writes an object to the S3 bucket during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function writes an object to the S3 bucket during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an S3 bucket is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When an S3 bucket is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket
