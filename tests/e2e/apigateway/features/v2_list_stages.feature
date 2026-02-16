@apigateway @v2_list_stages @happy @controlplane @v2
Feature: API Gateway V2 ListStages

  Scenario: List stages for an HTTP API
    Given a V2 API "e2e-v2-list-stages" was created
    And a V2 stage named "test" was created
    When I list V2 stages
    Then the command will succeed
    And the output will contain an "items" list
