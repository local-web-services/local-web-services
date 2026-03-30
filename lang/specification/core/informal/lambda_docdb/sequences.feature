@lambdadocdb @generated
Feature: LambdaDocdb - Action Sequences

  # Generated from FizzBee spec: lambda_docdb.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentReferencesExistingCluster

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then a DocumentDB cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then a Lambda function is deployed
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function is invoked
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then a Lambda function is deployed
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function is invoked
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then a DocumentDB cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is started
    Given fid in func_status
    Given the Lambda function has been invoked
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a DocumentDB cluster has been created
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the DocumentDB cluster has been stopped
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the DocumentDB cluster is started then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the DocumentDB cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then a Lambda function is deployed then the DocumentDB cluster is started
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given a Lambda function has been deployed
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given the DocumentDB cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given the DocumentDB cluster has been started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped
    Given cid not in cluster_status
    Given a DocumentDB cluster has been created
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then a Lambda function is deployed then the Lambda function is invoked
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then a DocumentDB cluster is created then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given a DocumentDB cluster has been created
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given the DocumentDB cluster has been started
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is stopped then the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given cid in cluster_status
    Given the DocumentDB cluster has been stopped
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then a Lambda function is deployed then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given a Lambda function has been deployed
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then a DocumentDB cluster is created then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given a DocumentDB cluster has been created
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the DocumentDB cluster is stopped then a Lambda function is deployed
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given the DocumentDB cluster has been stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function is invoked then a DocumentDB cluster is created
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given the Lambda function has been invoked
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the DocumentDB cluster is started then the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked
    Given cid in cluster_status
    Given the DocumentDB cluster has been started
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then a DocumentDB cluster is created then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a DocumentDB cluster has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is stopped then a DocumentDB cluster is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the DocumentDB cluster has been stopped
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the DocumentDB cluster is started then the DocumentDB cluster is stopped
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the DocumentDB cluster has been started
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a Lambda function is deployed then a DocumentDB cluster is created
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given a Lambda function has been deployed
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created then the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given a DocumentDB cluster has been created
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is stopped then the DocumentDB cluster is started
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given the DocumentDB cluster has been stopped
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the DocumentDB cluster is started then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given the DocumentDB cluster has been started
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function is invoked then the Lambda function fails to connect because the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to connect because the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a Lambda function is deployed then the DocumentDB cluster is stopped
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given a Lambda function has been deployed
    When the DocumentDB cluster is stopped
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then a DocumentDB cluster is created then the DocumentDB cluster is started
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given a DocumentDB cluster has been created
    When the DocumentDB cluster is started
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is stopped then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given the DocumentDB cluster has been stopped
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the DocumentDB cluster is started then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given the DocumentDB cluster has been started
    When the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists

  @sequence
  Scenario: the Lambda function fails to connect because the DocumentDB cluster is stopped then the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds then a DocumentDB cluster is created
    Given iid in inv_status
    Given the Lambda function has failed to connect because the DocumentDB cluster is stopped
    Given the Lambda function has written a document to the "AVAILABLE" DocumentDB cluster and succeeded
    When a DocumentDB cluster is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a cluster that exists
