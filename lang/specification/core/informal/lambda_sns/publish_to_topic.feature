@lambdasns @generated
Feature: LambdaSns - The Lambda Function Publishes A Message To The Sns Topic During Invocation

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @publish_to_topic
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation
    Given an invocation is "IN_PROGRESS"
    And the topic exists
    And the topic is "ACTIVE"
    When the Lambda function publishes a message to the "SNS" topic during invocation
    Then the message is published to the topic
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @standard @negative @publish_to_topic @lifecycle @internal
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function publishes a message to the "SNS" topic during invocation
    Then the operation is rejected

  @standard @negative @publish_to_topic
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation fails when the topic does not exist
    Given an invocation is "IN_PROGRESS"
    And the topic does not exist
    When the Lambda function publishes a message to the "SNS" topic during invocation
    Then the operation is rejected

  @standard @negative @publish_to_topic @lifecycle @internal
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation fails when the topic is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the topic exists
    And the topic is not "ACTIVE"
    When the Lambda function publishes a message to the "SNS" topic during invocation
    Then the operation is rejected
