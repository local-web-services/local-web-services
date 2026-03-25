@lambdadocdb @generated
Feature: LambdaDocdb - Action Sequences

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DocumentDB cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Lambda function is deployed
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function is invoked
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DocumentDB cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given fid not in func_status
    When a Lambda function is deployed
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is started then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the DocumentDB cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then a Lambda function is deployed then the DocumentDB cluster is started
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When a Lambda function is deployed
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function is invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    When a DocumentDB cluster is created
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    When the DocumentDB cluster is stopped
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a Lambda function is deployed
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When a DocumentDB cluster is created
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function is invoked then a DocumentDB cluster is created
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function is invoked
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    When the DocumentDB cluster is started
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a DocumentDB cluster is created then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a DocumentDB cluster is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given fid in func_status
    When the Lambda function is invoked
    When the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given fid in func_status
    When the Lambda function is invoked
    When the DocumentDB cluster is started
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed then a DocumentDB cluster is created
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a Lambda function is deployed
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a DocumentDB cluster is created
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the DocumentDB cluster is started
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed then the DocumentDB cluster is stopped
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a Lambda function is deployed
    When the DocumentDB cluster is stopped
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    When the DocumentDB cluster is started
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given iid in inv_status
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    When a DocumentDB cluster is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists
