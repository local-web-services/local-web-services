@lambdas3api @generated
Feature: LambdaS3api - Action Sequences

  # Generated from FizzBee spec: lambda_s3api.fizz
  # Safety invariants: InvocationRequiresActiveFunction, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3" "bucket" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the Lambda invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the "lambda" "function" is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then a "s3" "bucket" is created then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "lambda" "function" is deployed then the Lambda invocation fails then a "s3" "bucket" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a "lambda" "function" is deployed then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" is invoked then the Lambda invocation completes successfully
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation fails
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation completes successfully then a "lambda" "function" is deployed
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then the Lambda invocation fails then the "lambda" "function" is invoked
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then a "s3" "bucket" is created then the Lambda invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "s3" "bucket" is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the Lambda invocation completes successfully then a "s3" "bucket" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" is invoked then the Lambda invocation fails then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the Lambda invocation fails
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "lambda" "function" is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "lambda" "function" is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "s3" "bucket" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "s3" "bucket" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the "lambda" "function" is invoked then a "s3" "bucket" is created
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the "lambda" "function" is invoked
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "lambda" "function" is deployed then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "lambda" "function" is deployed
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then a "s3" "bucket" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the "lambda" "function" is invoked then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then a "s3" "bucket" is created then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When a "s3" "bucket" is created
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the "lambda" "function" is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the "lambda" "function" is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the "lambda" "function" writes an "s3" "object" to the "s3" "bucket" during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a "s3" "bucket" is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a "s3" "bucket" is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing object belongs to an "ACTIVE" bucket
