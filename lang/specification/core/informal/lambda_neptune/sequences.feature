@lambdaneptune @generated
Feature: LambdaNeptune - Action Sequences

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then a Neptune cluster is created then the Neptune cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is stopped then the Neptune cluster is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Neptune cluster is started then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Neptune cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then a Lambda function is deployed then the Neptune cluster is started
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given a Lambda function has been deployed
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is stopped then the Lambda function is invoked
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Neptune cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Neptune cluster has been started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped
    Given cid not in cluster_status
    Given a Neptune cluster has been created
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then a Neptune cluster is created then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given a Neptune cluster has been created
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given the Neptune cluster has been started
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is stopped then the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started
    Given cid in cluster_status
    Given the Neptune cluster has been stopped
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then a Lambda function is deployed then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a Lambda function has been deployed
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then a Neptune cluster is created then the Lambda function fails to connect because the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given a Neptune cluster has been created
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Neptune cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given the Neptune cluster has been stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function is invoked then a Neptune cluster is created
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given the Lambda function has been invoked
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Neptune cluster is started then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    Given the Neptune cluster has been started
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the Neptune cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then a Neptune cluster is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Neptune cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is stopped then a Neptune cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Neptune cluster has been stopped
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Neptune cluster is started then the Neptune cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Neptune cluster has been started
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Lambda function is deployed then a Neptune cluster is created
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given a Lambda function has been deployed
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created then the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given a Neptune cluster has been created
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is stopped then the Neptune cluster is started
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given the Neptune cluster has been stopped
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Neptune cluster is started then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given the Neptune cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Lambda function is deployed then the Neptune cluster is stopped
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given a Lambda function has been deployed
    When the Neptune cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then a Neptune cluster is created then the Neptune cluster is started
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given a Neptune cluster has been created
    When the Neptune cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given the Neptune cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Neptune cluster is started then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given the Neptune cluster has been started
    When the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried

  @sequence
  Scenario: the Lambda function fails to connect because the Neptune cluster is stopped then the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds then a Neptune cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the Neptune cluster is stopped
    Given the Lambda function has executed a graph query against the "AVAILABLE" cluster and succeeded
    When a Neptune cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which cluster it queried
