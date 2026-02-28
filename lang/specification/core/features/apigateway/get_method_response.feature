@apigateway @get_method_response @happy @controlplane
Feature: API Gateway GetMethodResponse

  Scenario: Get a method response
    Given a REST API "e2e-get-method-resp" was created
    And a resource "gmresp" was created under the root
    And method "GET" was added to the resource
    And method response with status "200" was added to method "GET"
    When I get method response with status "200" for method "GET"
    Then the command will succeed
    And the output "statusCode" will be "200"
