@apigateway @put_integration_response @happy @controlplane
Feature: API Gateway PutIntegrationResponse

  Scenario: Put an integration response
    Given a REST API "e2e-put-int-resp" was created
    And a resource "resp" was created under the root
    And method "GET" was added to the resource
    And integration type "MOCK" was added to method "GET"
    When I put integration response with status "200" on method "GET"
    Then the command will succeed
    And the output "statusCode" will be "200"
