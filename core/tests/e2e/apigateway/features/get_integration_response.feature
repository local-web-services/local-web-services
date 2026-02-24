@apigateway @get_integration_response @happy @controlplane
Feature: API Gateway GetIntegrationResponse

  Scenario: Get an integration response
    Given a REST API "e2e-get-int-resp" was created
    And a resource "getresp" was created under the root
    And method "GET" was added to the resource
    And integration type "MOCK" was added to method "GET"
    And integration response with status "200" was added to method "GET"
    When I get integration response with status "200" for method "GET"
    Then the command will succeed
    And the output "statusCode" will be "200"
