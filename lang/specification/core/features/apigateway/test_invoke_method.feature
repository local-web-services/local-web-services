@apigateway @test_invoke_method @happy @controlplane
Feature: API Gateway TestInvokeMethod

  Scenario: Test invoke a method on a resource
    When I test invoke method "GET" on resource "/health"
    Then the command will succeed
    And the output will contain a "status" field
