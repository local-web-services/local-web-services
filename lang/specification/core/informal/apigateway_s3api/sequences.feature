@apigateways3api @generated
Feature: ApigatewayS3api - Action Sequences

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When an S3 bucket is created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When the S3 bucket is deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an "API" Gateway "REST" "API" is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When an S3 bucket is created
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When the S3 bucket is deleted
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "API"
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    When a request fails because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    And every existing object references a bucket that exists
    And every successful request references an "API" that exists
