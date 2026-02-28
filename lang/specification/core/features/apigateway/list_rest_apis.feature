@apigateway @list_rest_apis @happy @controlplane
Feature: API Gateway ListRestApis

  Scenario: List REST APIs
    Given a REST API "e2e-list-rest-apis" was created
    When I list REST APIs
    Then the command will succeed
    And the output will contain an "item" list
