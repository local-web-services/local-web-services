@apigateway @v2_list_apis @happy @controlplane @v2
Feature: API Gateway V2 ListApis

  Scenario: List HTTP APIs
    Given a V2 API "e2e-v2-list-apis" was created
    When I list V2 APIs
    Then the command will succeed
    And the output will contain an "items" list
