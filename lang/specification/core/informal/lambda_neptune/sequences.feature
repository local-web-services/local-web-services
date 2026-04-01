@lambdaneptune @generated
Feature: LambdaNeptune - Action Sequences

  # Generated from FizzBee spec: lambda_neptune.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationQueriedACluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "neptune" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "neptune" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "neptune" "cluster" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "neptune" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "neptune" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "neptune" "cluster" is started
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "neptune" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "neptune" "cluster" is started then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then a "lambda" "function" is deployed then the "neptune" "cluster" is started
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "neptune" "cluster" is started then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: a "neptune" "cluster" is created then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped
    Given cid not in cluster_status
    When a "neptune" "cluster" is created
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then a "neptune" "cluster" is created then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "neptune" "cluster" is started then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is stopped then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given cid in cluster_status
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "lambda" "function" is deployed then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "lambda" "function" is deployed
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then a "neptune" "cluster" is created then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When a "neptune" "cluster" is created
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "neptune" "cluster" is stopped then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" is invoked then a "neptune" "cluster" is created
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" is invoked
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is stopped
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "neptune" "cluster" is started then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "neptune" "cluster" is started
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then a "neptune" "cluster" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "neptune" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "neptune" "cluster" is stopped then a "neptune" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "neptune" "cluster" is started then the "neptune" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "neptune" "cluster" is started
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is started
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "lambda" "function" is deployed then a "neptune" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "lambda" "function" is deployed
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "neptune" "cluster" is created then the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is stopped then the "neptune" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "neptune" "cluster" is started then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "neptune" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "lambda" "function" is deployed then the "neptune" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "lambda" "function" is deployed
    When the "neptune" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then a "neptune" "cluster" is created then the "neptune" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When a "neptune" "cluster" is created
    When the "neptune" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is stopped then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "neptune" "cluster" is started then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "neptune" "cluster" is started
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped then the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds then a "neptune" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "neptune" "cluster" is stopped
    When the "lambda" "function" executes a graph query against the "AVAILABLE" cluster and succeeds
    When a "neptune" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "neptune" "cluster" it queried
