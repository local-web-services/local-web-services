@lambdasns @generated
Feature: LambdaSns - Action Sequences

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function is invoked
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SNS" topic is created
    Given fid in func_status
    When the Lambda function is invoked
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an "SNS" topic is created then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an "SNS" topic is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then the Lambda function is invoked
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Lambda function is deployed then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function is invoked then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function is invoked then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then the Lambda function is invoked
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation completes successfully then the Lambda invocation fails
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then a Lambda function is deployed
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then the Lambda function is invoked
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Lambda invocation fails then the Lambda invocation completes successfully
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then an "SNS" topic is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SNS" topic is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SNS" topic is created then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an "SNS" topic is created then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an "SNS" topic is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then an "SNS" topic is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an "SNS" topic is created then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an "SNS" topic is created then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When an "SNS" topic is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function publishes a message to the "SNS" topic during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function publishes a message to the "SNS" topic during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an "SNS" topic is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When an "SNS" topic is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then the Lambda function publishes a message to the "SNS" topic during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When the Lambda function publishes a message to the "SNS" topic during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present
