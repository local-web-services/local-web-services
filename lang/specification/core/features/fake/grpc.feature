@fake @grpc @controlplane
Feature: Fake gRPC

  @happy
  Scenario: Create fake server with grpc protocol
    When I create fake server "e2e-fake-grpc-create" with protocol "grpc"
    Then the command will succeed
    And the config will have protocol "grpc"

  @happy
  Scenario: gRPC server appears in list
    Given a fake server "e2e-fake-grpc-list" was created with protocol "grpc"
    When I list fake servers
    Then the command will succeed
    And the output will contain fake server "e2e-fake-grpc-list"

  @happy
  Scenario: gRPC server status shows protocol
    Given a fake server "e2e-fake-grpc-status" was created with protocol "grpc"
    When I get status of fake server "e2e-fake-grpc-status"
    Then the command will succeed
    And the output will have protocol "grpc"
