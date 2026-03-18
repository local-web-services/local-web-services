@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - The Lambda Function Fails To Write Because The Domain Is Processing A Config Update

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_domain_processing
  Scenario: the Lambda function fails to write because the domain is processing a config update
    Given an invocation is "IN_PROGRESS"
    And the domain is "PROCESSING"
    When the Lambda function fails to write because the domain is processing a config update
    Then the invocation is "FAILED" with a connection error
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @standard @negative @invocation_fails_domain_processing @lifecycle
  Scenario: the Lambda function fails to write because the domain is processing a config update fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to write because the domain is processing a config update
    Then the operation is rejected

  @standard @negative @invocation_fails_domain_processing @lifecycle
  Scenario: the Lambda function fails to write because the domain is processing a config update fails when the domain is not "PROCESSING"
    Given an invocation is "IN_PROGRESS"
    And the domain is not "PROCESSING"
    When the Lambda function fails to write because the domain is processing a config update
    Then the operation is rejected
