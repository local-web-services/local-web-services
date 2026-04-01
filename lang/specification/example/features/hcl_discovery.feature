@stepfunctions @hcl_discovery @controlplane
Feature: Discover state machines from Terraform HCL

  @happy @minimal
  Scenario: Load state machine definition from terraform directory
    Given a session started from the "terraform" HCL directory
    When I process order "order-tf"
    Then the output will contain order ID "order-tf"
