@lambda @lambda_s3_nodejs_integration @dataplane @requires_docker @requires_nodejs_image
Feature: Lambda S3 Node.js Integration

  @happy
  Scenario: Node.js Lambda function writes to S3 without forcePathStyle
    Given an S3 bucket "e2e-nodejs-s3-bucket" was created
    And a Node.js Lambda function "e2e-nodejs-s3-writer" was created with S3 handler code
    When I invoke function "e2e-nodejs-s3-writer" with event {"bucket": "e2e-nodejs-s3-bucket", "key": "e2e-nodejs-output.txt", "body": "hello from nodejs lambda"}
    Then the command will succeed
    And the invoke output will have status code 200
    And S3 object "e2e-nodejs-output.txt" in bucket "e2e-nodejs-s3-bucket" will contain "hello from nodejs lambda"
