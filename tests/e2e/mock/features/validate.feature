@mock @validate @controlplane
Feature: Mock Validate

  @happy
  Scenario: Validate passes when mock covers all spec paths
    Given a mock server "e2e-mock-validate-pass" was created
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    And the spec file was imported into "e2e-mock-validate-pass"
    When I validate mock server "e2e-mock-validate-pass"
    Then the command will succeed
    And the validation result will be valid

  @happy
  Scenario: Validate warns about uncovered spec paths
    Given a mock server "e2e-mock-validate-uncovered" was created
    And a route "/v1/users" with method "GET" and status 200 was added to "e2e-mock-validate-uncovered"
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I validate mock server "e2e-mock-validate-uncovered" against the spec file
    Then the command will succeed
    And the validation result will have issues

  @happy
  Scenario: Validate warns about extra mock routes not in spec
    Given a mock server "e2e-mock-validate-extra" was created
    And a route "/v1/users" with method "GET" and status 200 was added to "e2e-mock-validate-extra"
    And a route "/v1/extra" with method "GET" and status 200 was added to "e2e-mock-validate-extra"
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I validate mock server "e2e-mock-validate-extra" against the spec file
    Then the command will succeed
    And the validation result will have issues

  @error
  Scenario: Validate in strict mode fails on warnings
    Given a mock server "e2e-mock-validate-strict" was created
    And a route "/v1/users" with method "GET" and status 200 was added to "e2e-mock-validate-strict"
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I validate mock server "e2e-mock-validate-strict" against the spec file in strict mode
    Then the command will fail
