@ssm @delete_parameters @controlplane
Feature: SSM DeleteParameters

  @happy
  Scenario: Delete multiple parameters
    Given a parameter "/e2e/del-params-test" was created with value "val1" and type "String"
    When I delete parameters ["/e2e/del-params-test"]
    Then the command will succeed
