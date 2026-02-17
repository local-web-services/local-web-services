@mock @graphql @dataplane
Feature: Mock GraphQL

  @happy
  Scenario: Create mock server with grpc protocol
    Given a mock server "e2e-mock-grpc" was created with protocol "grpc"
    When I get status of mock server "e2e-mock-grpc"
    Then the command will succeed
