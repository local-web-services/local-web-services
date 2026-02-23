@apigateway @create_authorizer_v2 @happy @controlplane @v2
Feature: API Gateway V2 CreateAuthorizer

  Scenario: Create an authorizer for an HTTP API
    Given a V2 API "e2e-v2-create-authorizer" was created
    When I create a V2 authorizer named "jwt-auth" of type "JWT" for the HTTP API
    Then the command will succeed
    And the output will contain an "authorizerId" field
    And the output "name" will be "jwt-auth"
    And the output "authorizerType" will be "JWT"

  Scenario: Get an authorizer for an HTTP API
    Given a V2 API "e2e-v2-get-authorizer" was created
    And a V2 authorizer "jwt-auth" of type "JWT" was created for the HTTP API
    When I get the V2 authorizer
    Then the command will succeed
    And the output "name" will be "jwt-auth"

  Scenario: List authorizers for an HTTP API
    Given a V2 API "e2e-v2-list-authorizers" was created
    And a V2 authorizer "list-auth" of type "JWT" was created for the HTTP API
    When I list V2 authorizers
    Then the command will succeed
    And the output will contain an "items" list with at least 1 entry
