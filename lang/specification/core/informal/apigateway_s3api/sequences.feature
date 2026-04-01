@apigateways3api @generated
Feature: ApigatewayS3api - Action Sequences

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "s3" "bucket" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then the "s3" "bucket" is deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct S3 integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request fails because the "s3" "bucket" has been deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "api gateway" "api" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "s3" "bucket" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a direct S3 integration is configured on the "api gateway" "API"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a request fails because the "s3" "bucket" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then an "api gateway" "api" is created
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a direct S3 integration is configured on the "api gateway" "API"
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a request fails because the "s3" "bucket" has been deleted
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "s3" "bucket" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then the "s3" "bucket" is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then an "api gateway" "api" is created
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "s3" "bucket" is created
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then the "s3" "bucket" is deleted
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then an "api gateway" "api" is created
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "s3" "bucket" is created
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then the "s3" "bucket" is deleted
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "s3" "bucket" is created
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then the "s3" "bucket" is deleted
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "s3" "bucket" is created then the "s3" "bucket" is deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "s3" "bucket" is created
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then the "s3" "bucket" is deleted then a direct S3 integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "s3" "bucket" is deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct S3 integration is configured on the "api gateway" "API" then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a request fails because the "s3" "bucket" has been deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request fails because the "s3" "bucket" has been deleted then a "s3" "bucket" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request fails because the "s3" "bucket" has been deleted
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "api gateway" "api" is created then a direct S3 integration is configured on the "api gateway" "API"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "api gateway" "api" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "s3" "bucket" is deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "s3" "bucket" is deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a direct S3 integration is configured on the "api gateway" "API" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a request fails because the "s3" "bucket" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then an "api gateway" "api" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a request fails because the "s3" "bucket" has been deleted then the "s3" "bucket" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a request fails because the "s3" "bucket" has been deleted
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then an "api gateway" "api" is created then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When an "api gateway" "api" is created
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "s3" "bucket" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a direct S3 integration is configured on the "api gateway" "API" then a request fails because the "s3" "bucket" has been deleted
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then an "api gateway" "api" is created
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "s3" "bucket" is created
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: the "s3" "bucket" is deleted then a request fails because the "s3" "bucket" has been deleted then a direct S3 integration is configured on the "api gateway" "API"
    Given bid in bucket_status
    When the "s3" "bucket" is deleted
    When a request fails because the "s3" "bucket" has been deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then an "api gateway" "api" is created then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "s3" "bucket" is created then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "s3" "bucket" is created
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then the "s3" "bucket" is deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When the "s3" "bucket" is deleted
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "s3" "bucket" is created
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then the "s3" "bucket" is deleted
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "api gateway" "API" then a request fails because the "s3" "bucket" has been deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a direct S3 integration is configured on the "api gateway" "API"
    When a request fails because the "s3" "bucket" has been deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then an "api gateway" "api" is created then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When an "api gateway" "api" is created
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "s3" "bucket" is created then an "api gateway" "api" is created
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "s3" "bucket" is created
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then the "s3" "bucket" is deleted then a "s3" "bucket" is created
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When the "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a direct S3 integration is configured on the "api gateway" "API" then the "s3" "bucket" is deleted
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a direct S3 integration is configured on the "api gateway" "API"
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a request fails because the "s3" "bucket" has been deleted then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a request fails because the "s3" "bucket" has been deleted
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then an "api gateway" "api" is created then a "s3" "bucket" is created
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When an "api gateway" "api" is created
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "s3" "bucket" is created then the "s3" "bucket" is deleted
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "s3" "bucket" is created
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then the "s3" "bucket" is deleted then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When the "s3" "bucket" is deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "api gateway" "API" then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then a request fails because the "s3" "bucket" has been deleted
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When a request fails because the "s3" "bucket" has been deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a request fails because the "s3" "bucket" has been deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a request fails because the "s3" "bucket" has been deleted
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then an "api gateway" "api" is created then the "s3" "bucket" is deleted
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When an "api gateway" "api" is created
    When the "s3" "bucket" is deleted
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "s3" "bucket" is created then a direct S3 integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "s3" "bucket" is created
    When a direct S3 integration is configured on the "api gateway" "API"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then the "s3" "bucket" is deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When the "s3" "bucket" is deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a direct S3 integration is configured on the "api gateway" "API" then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a direct S3 integration is configured on the "api gateway" "API"
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket" then an "api gateway" "api" is created
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "PUT" request is received and the "api gateway" "API" writes an "s3" "object" to the "s3" "bucket"
    When an "api gateway" "api" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request fails because the "s3" "bucket" has been deleted then a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3 then a "s3" "bucket" is created
    Given aid in api_status
    When a request fails because the "s3" "bucket" has been deleted
    When a "GET" request is received and the "api gateway" "API" retrieves an existing object from S3
    When a "s3" "bucket" is created
    And every existing object references a "s3" "bucket" that exists
    And every successful request references an "api gateway" "API" that exists
