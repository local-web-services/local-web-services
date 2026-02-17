@apigateway @create_authorizer @happy @controlplane
Feature: API Gateway CreateAuthorizer

  Scenario: Create an authorizer for a REST API
    Given a REST API "e2e-create-authorizer" was created
    When I create an authorizer named "my-auth" of type "TOKEN" for the REST API
    Then the command will succeed
    And the output will contain an "id" field
    And the output "name" will be "my-auth"
    And the output "type" will be "TOKEN"

  Scenario: Get an authorizer for a REST API
    Given a REST API "e2e-get-authorizer" was created
    And an authorizer "my-auth" of type "TOKEN" was created for the REST API
    When I get the authorizer
    Then the command will succeed
    And the output "name" will be "my-auth"

  Scenario: List authorizers for a REST API
    Given a REST API "e2e-list-authorizers" was created
    And an authorizer "list-auth" of type "TOKEN" was created for the REST API
    When I list authorizers for the REST API
    Then the command will succeed
    And the output will contain an "item" list with at least 1 entry
