@lambdasns @generated
Feature: LambdaSns - The "Lambda" "Function" Publishes A Message To The "Sns" "Topic" During Invocation

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @publish_to_topic
  Scenario: the "lambda" "function" publishes a message to the "sns" "topic" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sns" "topic" existed
    And the "sns" "topic" was "ACTIVE"
    When the "lambda" "function" publishes a message to the "sns" "topic" during invocation
    Then the "sns" "message" will be published to the "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And "sns" publishing requires an "ACTIVE" "sns" "topic" to be present

  @guard @negative @publish_to_topic @lifecycle
  Scenario: the "lambda" "function" publishes a message to the "sns" "topic" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" publishes a message to the "sns" "topic" during invocation
    Then the operation is rejected

  @guard @negative @publish_to_topic
  Scenario: the "lambda" "function" publishes a message to the "sns" "topic" during invocation fails when the "sns" "topic" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sns" "topic" did not exist
    When the "lambda" "function" publishes a message to the "sns" "topic" during invocation
    Then the operation is rejected

  @guard @negative @publish_to_topic @lifecycle
  Scenario: the "lambda" "function" publishes a message to the "sns" "topic" during invocation fails when the "sns" "topic" was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sns" "topic" existed
    And the "sns" "topic" was not "ACTIVE"
    When the "lambda" "function" publishes a message to the "sns" "topic" during invocation
    Then the operation is rejected
