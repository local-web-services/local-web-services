@mock @grpc @dataplane
Feature: Mock gRPC

  @happy
  Scenario: Create and list mock servers
    Given a mock server "e2e-mock-grpc-list" was created with protocol "grpc"
    When I list mock servers
    Then the command will succeed
    And the output will contain mock server "e2e-mock-grpc-list"
