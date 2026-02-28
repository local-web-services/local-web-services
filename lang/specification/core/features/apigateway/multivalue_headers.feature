@apigateway @multivalue_headers @happy @dataplane @v2 @requires_docker
Feature: API Gateway V2 Multi-Value Headers

  Scenario: Custom header is passed to the Lambda event
    Given an echo Lambda "e2e-mv-hdr-echo" was created
    And a V2 API "e2e-mv-hdr" was created
    And a V2 proxy integration for Lambda "e2e-mv-hdr-echo" was created
    And a V2 route with key "$default" targeting the integration was created
    When I test invoke GET on "/e2e-mv-hdr-test" with header "x-custom:hello"
    Then the command will succeed
    And the invoke response status will be 200
    And the invoke response body field "headers.x-custom" will be "hello"
