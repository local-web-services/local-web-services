@apigatewaylambda @generated
Feature: ApigatewayLambda - Action Sequences

  # Generated from FizzBee spec: apigateway_lambda.fizz
  # Safety invariants: RequestRequiresActiveApi, InvocationRequiresActiveFunction, InvocationLinkedToRequest

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "lambda" "function" is deployed
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a Lambda integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "api gateway" "api" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda integration is configured on the "api gateway" "api"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then an "api gateway" "api" is created
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then a "lambda" "function" is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then a "lambda" "function" is deployed
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then a Lambda integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a Lambda integration is configured on the "api gateway" "api"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a Lambda integration is configured on the "api gateway" "api"
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a "lambda" "function" is deployed then a Lambda integration is configured on the "api gateway" "api"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "lambda" "function" is deployed
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then a Lambda integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a Lambda integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: an "api gateway" "api" is created then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a "lambda" "function" is deployed
    Given aid not in api_status
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "api gateway" "api" is created then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "api gateway" "api" is created
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a Lambda integration is configured on the "api gateway" "api"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then an "api gateway" "api" is created then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then a "lambda" "function" is deployed then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then an "api gateway" "api" is created
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a "lambda" "function" is deployed
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given aid in api_status
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then an "api gateway" "api" is created then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When an "api gateway" "api" is created
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then a "lambda" "function" is deployed then an "api gateway" "api" is created
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When a "lambda" "function" is deployed
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then a Lambda integration is configured on the "api gateway" "api" then a "lambda" "function" is deployed
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When a Lambda integration is configured on the "api gateway" "api"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a Lambda integration is configured on the "api gateway" "api"
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given aid in api_status
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then an "api gateway" "api" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When an "api gateway" "api" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a "lambda" "function" is deployed then a Lambda integration is configured on the "api gateway" "api"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a "lambda" "function" is deployed
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a Lambda integration is configured on the "api gateway" "api" then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a Lambda integration is configured on the "api gateway" "api"
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then an "api gateway" "api" is created then a Lambda integration is configured on the "api gateway" "api"
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When an "api gateway" "api" is created
    When a Lambda integration is configured on the "api gateway" "api"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a "lambda" "function" is deployed then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a "lambda" "function" is deployed
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then a Lambda integration is configured on the "api gateway" "api" then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When a Lambda integration is configured on the "api gateway" "api"
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function" then an "api gateway" "api" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "api gateway" "API" receives a "HTTP" request and synchronously invokes the "lambda" "function"
    When an "api gateway" "api" is created
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @sequence
  Scenario: the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response then the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails and the "api gateway" "API" returns an error response
    When the "lambda" "function" invocation completes successfully and the "api gateway" "API" returns a successful response
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" has a corresponding "IN_PROGRESS" "api gateway" "request"
