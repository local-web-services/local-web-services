@apigateways3api @generated
Feature: ApigatewayS3api - Action Sequences

  # Generated from FizzBee spec: apigateway_s3api.fizz
  # Safety invariants: ObjectReferencesExistingBucket, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then an S3 bucket is created then the S3 bucket is deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given an S3 bucket has been created
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a direct S3 integration has been configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted then an S3 bucket is created
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a request has failed because the S3 bucket has been deleted
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then an "API" Gateway "REST" "API" is created then a direct S3 integration is configured on the "API"
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an "API" Gateway "REST" "API" has been created
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a direct S3 integration has been configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: an S3 bucket is created then a request fails because the S3 bucket has been deleted then the S3 bucket is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given a request has failed because the S3 bucket has been deleted
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then an "API" Gateway "REST" "API" is created then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given an "API" Gateway "REST" "API" has been created
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then an S3 bucket is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given an S3 bucket has been created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given a direct S3 integration has been configured on the "API"
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: the S3 bucket is deleted then a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API"
    Given bid in bucket_status
    Given the S3 bucket has been deleted
    Given a request has failed because the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given an "API" Gateway "REST" "API" has been created
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then an S3 bucket is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given an S3 bucket has been created
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then the S3 bucket is deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a direct S3 integration is configured on the "API" then a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a direct S3 integration has been configured on the "API"
    Given a request has failed because the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given an "API" Gateway "REST" "API" has been created
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then an S3 bucket is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given an S3 bucket has been created
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then the S3 bucket is deleted then an S3 bucket is created
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given the S3 bucket has been deleted
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a direct S3 integration is configured on the "API" then the S3 bucket is deleted
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given a direct S3 integration has been configured on the "API"
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    Given a request has failed because the S3 bucket has been deleted
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an "API" Gateway "REST" "API" is created then an S3 bucket is created
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given an "API" Gateway "REST" "API" has been created
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created then the S3 bucket is deleted
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given an S3 bucket has been created
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then the S3 bucket is deleted then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given the S3 bucket has been deleted
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a direct S3 integration is configured on the "API" then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given a direct S3 integration has been configured on the "API"
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a "PUT" request is received and the "API" writes an object to the S3 bucket then a request fails because the S3 bucket has been deleted
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When a request fails because the S3 bucket has been deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a "GET" request is received and the "API" retrieves an existing object from S3 then a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    Given a request has failed because the S3 bucket has been deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an "API" Gateway "REST" "API" is created then the S3 bucket is deleted
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given an "API" Gateway "REST" "API" has been created
    When the S3 bucket is deleted
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then an S3 bucket is created then a direct S3 integration is configured on the "API"
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given an S3 bucket has been created
    When a direct S3 integration is configured on the "API"
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then the S3 bucket is deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given the S3 bucket has been deleted
    When a "PUT" request is received and the "API" writes an object to the S3 bucket
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a direct S3 integration is configured on the "API" then a "GET" request is received and the "API" retrieves an existing object from S3
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given a direct S3 integration has been configured on the "API"
    When a "GET" request is received and the "API" retrieves an existing object from S3
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "PUT" request is received and the "API" writes an object to the S3 bucket then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given a "PUT" request has been received and the "API" has written an object to the S3 bucket
    When an "API" Gateway "REST" "API" is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists

  @sequence
  Scenario: a request fails because the S3 bucket has been deleted then a "GET" request is received and the "API" retrieves an existing object from S3 then an S3 bucket is created
    Given aid in api_status
    Given a request has failed because the S3 bucket has been deleted
    Given a "GET" request has been received and the "API" has retrieved an existing object from S3
    When an S3 bucket is created
    Then every existing object references a bucket that exists
    And every successful request references an "API" that exists
