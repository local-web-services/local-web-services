@lambda @create_function_url_config @controlplane
Feature: Lambda CreateFunctionUrlConfig

  @happy
  Scenario: Create a Function URL config for a function
    Given a Lambda function "e2e-furl-create-fn" was created
    When I create a function URL config for "e2e-furl-create-fn"
    Then the command will succeed
    And the output will contain function URL for "e2e-furl-create-fn"

  @happy
  Scenario: Get a Function URL config after creation
    Given a Lambda function "e2e-furl-get-fn" was created
    And a function URL config for "e2e-furl-get-fn" was created
    When I get the function URL config for "e2e-furl-get-fn"
    Then the command will succeed
    And the output will contain function name "e2e-furl-get-fn"

  @happy
  Scenario: Delete a Function URL config
    Given a Lambda function "e2e-furl-del-fn" was created
    And a function URL config for "e2e-furl-del-fn" was created
    When I delete the function URL config for "e2e-furl-del-fn"
    Then the command will succeed
    And function "e2e-furl-del-fn" will have no URL config
