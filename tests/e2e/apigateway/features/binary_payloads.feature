@apigateway @binary_payloads @happy @dataplane @v2 @requires_docker
Feature: API Gateway V2 Binary Payloads

  Scenario: Binary request body is base64 encoded in the event
    Given an echo Lambda "e2e-bin-echo" was created
    And a V2 API "e2e-bin-payload" was created
    And a V2 proxy integration for Lambda "e2e-bin-echo" was created
    And a V2 route with key "POST /e2e-bin-upload" was created
    When I test invoke POST on "/e2e-bin-upload" with binary content type
    Then the command will succeed
    And the invoke response status will be 200
    And the invoke response body field "isBase64Encoded" will be "true"
