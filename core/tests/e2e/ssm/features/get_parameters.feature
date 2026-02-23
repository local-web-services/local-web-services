@ssm @get_parameters @dataplane
Feature: SSM GetParameters

  @happy
  Scenario: Get multiple parameters by name
    Given a parameter "/e2e/get-params-test-1" was created with value "val1" and type "String"
    And a parameter "/e2e/get-params-test-2" was created with value "val2" and type "String"
    When I get parameters ["/e2e/get-params-test-1", "/e2e/get-params-test-2"]
    Then the command will succeed
