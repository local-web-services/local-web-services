@apigateway @multivalue_query_params @happy @dataplane @v2 @requires_docker
Feature: API Gateway V2 Multi-Value Query Parameters

  Scenario: Repeated query parameters are comma-joined in the event
    Given an echo Lambda "e2e-mv-qp-echo" was created
    And a V2 API "e2e-mv-qp" was created
    And a V2 proxy integration for Lambda "e2e-mv-qp-echo" was created
    And a V2 route with key "$default" targeting the integration was created
    When I test invoke GET on "/e2e-mv-qp-test?color=red&color=blue"
    Then the command will succeed
    And the invoke response status will be 200
    And the invoke response body field "queryStringParameters.color" will be "red,blue"
