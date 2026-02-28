@ssm @put_parameter @dataplane
Feature: SSM PutParameter

  @happy
  Scenario: Put a new string parameter
    When I put parameter "/e2e/put-param-test" with value "test-value" and type "String"
    Then the command will succeed
    And parameter "/e2e/put-param-test" will have value "test-value"

  @happy
  Scenario: Put a parameter with a description
    When I put parameter "/e2e/put-param-desc" with value "val" and type "String" and description "A test parameter"
    Then the command will succeed
    And parameter "/e2e/put-param-desc" will have value "val"

  @happy
  Scenario: Overwrite an existing parameter
    Given a parameter "/e2e/put-param-ow" was created with value "v1" and type "String"
    When I put parameter "/e2e/put-param-ow" with value "v2" and type "String" with overwrite
    Then the command will succeed
    And parameter "/e2e/put-param-ow" will have value "v2"
