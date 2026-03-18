@lambdaneptune @generated
Feature: LambdaNeptune - Action Sequences

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When a Neptune cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Neptune cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried
