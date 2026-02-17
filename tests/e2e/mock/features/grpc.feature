@mock @grpc @controlplane
Feature: Mock gRPC

  @happy
  Scenario: Create mock server with grpc protocol
    When I create mock server "e2e-mock-grpc-create" with protocol "grpc"
    Then the command will succeed
    And the config will have protocol "grpc"

  @happy
  Scenario: gRPC server appears in list
    Given a mock server "e2e-mock-grpc-list" was created with protocol "grpc"
    When I list mock servers
    Then the command will succeed
    And the output will contain mock server "e2e-mock-grpc-list"

  @happy
  Scenario: gRPC server status shows protocol
    Given a mock server "e2e-mock-grpc-status" was created with protocol "grpc"
    When I get status of mock server "e2e-mock-grpc-status"
    Then the command will succeed
    And the output will have protocol "grpc"
