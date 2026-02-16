@apigateway @put_method_response @happy @controlplane
Feature: API Gateway PutMethodResponse

  Scenario: Put a method response on a method
    Given a REST API "e2e-put-method-resp" was created
    And a resource "mresp" was created under the root
    And method "GET" was added to the resource
    When I put method response with status "200" on method "GET"
    Then the command will succeed
    And the output "statusCode" will be "200"
