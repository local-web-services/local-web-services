@ssm @get_parameter @dataplane
Feature: SSM GetParameter

  @happy
  Scenario: Get an existing parameter
    Given a parameter "/e2e/get-param-test" was created with value "hello" and type "String"
    When I get parameter "/e2e/get-param-test"
    Then the command will succeed
    And the output will contain parameter value "hello"
