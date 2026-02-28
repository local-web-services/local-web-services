@lambda @list_function_url_configs @controlplane
Feature: Lambda ListFunctionUrlConfigs

  @happy
  Scenario: List function URL configs
    When I list function URL configs
    Then the command will succeed
    And the output will contain "FunctionUrls"
