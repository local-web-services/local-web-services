@lambdadocdb @generated
Feature: LambdaDocdb - Action Sequences

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then a "documentdb" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "documentdb" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "documentdb" "cluster" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "documentdb" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "documentdb" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "documentdb" "cluster" is started
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "documentdb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "documentdb" "cluster" is started then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then a "lambda" "function" is deployed then the "documentdb" "cluster" is started
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "documentdb" "cluster" is started then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "lambda" "function" is deployed
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: a "documentdb" "cluster" is created then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped
    Given cid not in cluster_status
    When a "documentdb" "cluster" is created
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is stopped then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given cid in cluster_status
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "lambda" "function" is deployed then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "lambda" "function" is deployed
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then a "documentdb" "cluster" is created then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When a "documentdb" "cluster" is created
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" is invoked then a "documentdb" "cluster" is created
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" is invoked
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is stopped
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "documentdb" "cluster" is started then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked
    Given cid in cluster_status
    When the "documentdb" "cluster" is started
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "documentdb" "cluster" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "documentdb" "cluster" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "documentdb" "cluster" is started then the "documentdb" "cluster" is stopped
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "documentdb" "cluster" is started
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is started
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "lambda" "function" is deployed then a "documentdb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "lambda" "function" is deployed
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "documentdb" "cluster" is created then the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "documentdb" "cluster" is started then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "documentdb" "cluster" is started
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "lambda" "function" is deployed then the "documentdb" "cluster" is stopped
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "lambda" "function" is deployed
    When the "documentdb" "cluster" is stopped
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then a "documentdb" "cluster" is created then the "documentdb" "cluster" is started
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When a "documentdb" "cluster" is created
    When the "documentdb" "cluster" is started
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "documentdb" "cluster" is started then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "documentdb" "cluster" is started
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists

  @sequence
  Scenario: the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped then the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds then a "documentdb" "cluster" is created
    Given iid in inv_status
    When the "lambda" "function" fails to connect because the "documentdb" "cluster" is stopped
    When the "lambda" "function" writes a document to the "documentdb" "cluster" that was "AVAILABLE" and succeeds
    When a "documentdb" "cluster" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every existing document references a "documentdb" "cluster" that exists
