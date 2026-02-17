@mock @import_spec @controlplane
Feature: Mock Import Spec

  @happy
  Scenario: Import an OpenAPI spec generates route files
    Given a mock server "e2e-mock-import-spec" was created
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I import the spec file into "e2e-mock-import-spec"
    Then the command will succeed
    And the output will show 2 imported files
    And the spec file will be copied to the mock server directory

  @happy
  Scenario: Import does not overwrite existing routes by default
    Given a mock server "e2e-mock-import-no-overwrite" was created
    And a route "/v1/users" with method "GET" and status 200 was added to "e2e-mock-import-no-overwrite"
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I import the spec file into "e2e-mock-import-no-overwrite"
    Then the command will succeed
    And the output will show 1 imported files

  @happy
  Scenario: Import with overwrite replaces existing routes
    Given a mock server "e2e-mock-import-overwrite" was created
    And a route "/v1/users" with method "GET" and status 200 was added to "e2e-mock-import-overwrite"
    And an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I import the spec file into "e2e-mock-import-overwrite" with overwrite
    Then the command will succeed
    And the output will show 2 imported files

  @error
  Scenario: Import spec into nonexistent mock server
    Given an OpenAPI spec file exists with paths "/v1/users" and "/v1/orders"
    When I import the spec file into "e2e-mock-import-missing"
    Then the command will fail
    And the output will contain "not found"
