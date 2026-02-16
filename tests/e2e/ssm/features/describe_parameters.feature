@ssm @describe_parameters @controlplane
Feature: SSM DescribeParameters

  @happy
  Scenario: List parameters includes a known parameter
    Given a parameter "/e2e/desc-params-test" was created with value "x" and type "String"
    When I describe parameters
    Then the command will succeed
    And the parameter list will include "/e2e/desc-params-test"
