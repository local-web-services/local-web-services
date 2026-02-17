@mock @validate @controlplane
Feature: Mock Validate

  @happy
  Scenario: Create mock server with graphql protocol
    Given a mock server "e2e-mock-graphql" was created with protocol "graphql"
    When I get status of mock server "e2e-mock-graphql"
    Then the command will succeed
    And the output will contain mock server "e2e-mock-graphql"
