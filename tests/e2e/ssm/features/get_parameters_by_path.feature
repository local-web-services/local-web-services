@ssm @get_parameters_by_path @dataplane
Feature: SSM GetParametersByPath

  @happy
  Scenario: Get parameters under a path
    Given a parameter "/e2e/path-test/p1" was created with value "a" and type "String"
    And a parameter "/e2e/path-test/p2" was created with value "b" and type "String"
    When I get parameters by path "/e2e/path-test"
    Then the command will succeed
    And the parameter list will include "/e2e/path-test/p1"
    And the parameter list will include "/e2e/path-test/p2"
