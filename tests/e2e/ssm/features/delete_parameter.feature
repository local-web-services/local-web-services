@ssm @delete_parameter @controlplane
Feature: SSM DeleteParameter

  @happy
  Scenario: Delete an existing parameter
    Given a parameter "/e2e/del-param-test" was created with value "gone" and type "String"
    When I delete parameter "/e2e/del-param-test"
    Then the command will succeed
    And parameter "/e2e/del-param-test" will not appear in describe-parameters
