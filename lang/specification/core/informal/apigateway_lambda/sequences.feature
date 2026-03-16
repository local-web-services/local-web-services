@apigatewaylambda @generated
Feature: ApigatewayLambda - Action Sequences

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda function is deployed
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a "REST" "API" is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda integration is configured on the "REST" "API"
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda function is deployed then a Lambda integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API"
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid not in api_status
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a "REST" "API" is created then a Lambda integration is configured on the "REST" "API"
    Given fid not in func_status
    When a Lambda function is deployed
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response
    Given fid not in func_status
    When a Lambda function is deployed
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response
    Given fid not in func_status
    When a Lambda function is deployed
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response
    Given fid not in func_status
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API"
    Given fid not in func_status
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response
    Given fid not in func_status
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response
    Given fid not in func_status
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API"
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API"
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created then a Lambda function is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed then a "REST" "API" is created
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created then a Lambda function is deployed
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created then a Lambda integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed then a Lambda integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API"
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response
    Given aid in api_status
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created then the Lambda invocation fails and the "API" returns an error response
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed then the Lambda invocation fails and the "API" returns an error response
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API" then the Lambda invocation fails and the "API" returns an error response
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation fails and the "API" returns an error response
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation fails and the "API" returns an error response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully and the "API" returns a successful response then the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a "REST" "API" is created then the Lambda invocation completes successfully and the "API" returns a successful response
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a "REST" "API" is created
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda function is deployed then the Lambda invocation completes successfully and the "API" returns a successful response
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda function is deployed
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API" then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API" then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API" then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then a Lambda integration is configured on the "REST" "API" then the Lambda invocation completes successfully and the "API" returns a successful response
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When a Lambda integration is configured on the "REST" "API"
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function then the Lambda invocation completes successfully and the "API" returns a successful response
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    When the Lambda invocation completes successfully and the "API" returns a successful response
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response then a "REST" "API" is created
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a "REST" "API" is created
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda function is deployed
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response then a Lambda integration is configured on the "REST" "API"
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When a Lambda integration is configured on the "REST" "API"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request

  @exhaustive @sequence
  Scenario: the Lambda invocation fails and the "API" returns an error response then the Lambda invocation completes successfully and the "API" returns a successful response then the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    Given iid in inv_status
    When the Lambda invocation fails and the "API" returns an error response
    When the Lambda invocation completes successfully and the "API" returns a successful response
    When the "API" receives an "HTTP" request and synchronously invokes the Lambda function
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation has a corresponding "IN_PROGRESS" request
