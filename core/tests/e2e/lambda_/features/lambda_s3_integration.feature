@lambda @lambda_s3_integration @dataplane @requires_docker
Feature: Lambda S3 Integration

  @happy
  Scenario: Lambda function writes to S3 using path-style addressing
    Given an S3 bucket "e2e-lambda-s3-bucket" was created
    And a Lambda function "e2e-s3-writer" was created with S3 handler code
    When I invoke function "e2e-s3-writer" with event {"bucket": "e2e-lambda-s3-bucket", "key": "e2e-lambda-output.txt", "body": "hello from lambda"}
    Then the command will succeed
    And the invoke output will have status code 200
    And S3 object "e2e-lambda-output.txt" in bucket "e2e-lambda-s3-bucket" will contain "hello from lambda"
