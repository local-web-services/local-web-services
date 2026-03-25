@lambdaopensearch @generated
Feature: LambdaOpensearch - Action Sequences

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an OpenSearch domain is created
    Given fid not in func_status
    When a Lambda function is deployed
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an index is created in the OpenSearch domain
    Given fid not in func_status
    When a Lambda function is deployed
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then a Lambda function is deployed
    Given did not in domain_status
    When an OpenSearch domain is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given did not in domain_status
    When an OpenSearch domain is created
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda function is invoked
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation completes successfully
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation fails
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then a Lambda function is deployed
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then an OpenSearch domain is created
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function is invoked
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation completes successfully
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation fails
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an OpenSearch domain is created
    Given fid in func_status
    When the Lambda function is invoked
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an index is created in the OpenSearch domain
    Given fid in func_status
    When the Lambda function is invoked
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda invocation fails
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda invocation fails
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given fid not in func_status
    When a Lambda function is deployed
    When an OpenSearch domain is created
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an index is created in the OpenSearch domain then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When an index is created in the OpenSearch domain
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an OpenSearch domain is created
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda invocation fails
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then a Lambda function is deployed then the Lambda function is invoked
    Given did not in domain_status
    When an OpenSearch domain is created
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    When an OpenSearch domain is created
    When an index is created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation fails then an index is created in the OpenSearch domain
    Given did not in domain_status
    When an OpenSearch domain is created
    When the Lambda invocation fails
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When a Lambda function is deployed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then an OpenSearch domain is created then the Lambda invocation completes successfully
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When an OpenSearch domain is created
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function is invoked then the Lambda invocation fails
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda function is invoked
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation completes successfully then an OpenSearch domain is created
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda invocation completes successfully
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation fails then the Lambda function is invoked
    Given did in domain_status
    When an index is created in the OpenSearch domain
    When the Lambda invocation fails
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an OpenSearch domain is created then the Lambda invocation fails
    Given fid in func_status
    When the Lambda function is invoked
    When an OpenSearch domain is created
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an index is created in the OpenSearch domain then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an index is created in the OpenSearch domain
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an index is created in the OpenSearch domain
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda invocation fails
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When an OpenSearch domain is created
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an index is created in the OpenSearch domain then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When an index is created in the OpenSearch domain
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda function is invoked then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda function is invoked
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When a Lambda function is deployed
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an OpenSearch domain is created
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then an index is created in the OpenSearch domain then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When an index is created in the OpenSearch domain
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function is invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation completes successfully
    When the Lambda invocation fails
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an index is created in the OpenSearch domain
    Given iid in inv_status
    When the Lambda invocation fails
    When a Lambda function is deployed
    When an index is created in the OpenSearch domain
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an OpenSearch domain is created then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda invocation fails
    When an OpenSearch domain is created
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the Lambda invocation fails
    When an index is created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function is invoked
    When the Lambda invocation completes successfully
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda function indexes a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @exhaustive @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an OpenSearch domain is created
    Given iid in inv_status
    When the Lambda invocation fails
    When the Lambda invocation completes successfully
    When an OpenSearch domain is created
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain
