@lambdaopensearch @generated
Feature: LambdaOpensearch - Action Sequences

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then an "opensearch" "domain" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "opensearch" "index" is created in the "opensearch" "domain"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then a "lambda" "function" is deployed
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "index" is created in the "opensearch" "domain"
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" is invoked
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" invocation completes successfully
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" invocation fails
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then a "lambda" "function" is deployed
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then an "opensearch" "domain" is created
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" is invoked
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" invocation completes successfully
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" invocation fails
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "opensearch" "domain" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "opensearch" "index" is created in the "opensearch" "domain"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "opensearch" "domain" is created then an "opensearch" "index" is created in the "opensearch" "domain"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "opensearch" "domain" is created
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation completes successfully
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" invocation fails then an "opensearch" "domain" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation fails
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "domain" is created then the "lambda" "function" invocation fails then an "opensearch" "index" is created in the "opensearch" "domain"
    Given did not in domain_status
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation fails
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then a "lambda" "function" is deployed then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then an "opensearch" "domain" is created then the "lambda" "function" invocation completes successfully
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" is invoked then the "lambda" "function" invocation fails
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" indexes a document into the OpenSearch index during invocation then a "lambda" "function" is deployed
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" invocation completes successfully then an "opensearch" "domain" is created
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" invocation fails then the "lambda" "function" is invoked
    Given did in domain_status
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" invocation completes successfully
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "opensearch" "domain" is created then the "lambda" "function" invocation fails
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "opensearch" "domain" is created
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then an "opensearch" "index" is created in the "opensearch" "domain" then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" indexes a document into the OpenSearch index during invocation then an "opensearch" "domain" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully then an "opensearch" "index" is created in the "opensearch" "domain"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" invocation fails then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation fails
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then a "lambda" "function" is deployed then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When a "lambda" "function" is deployed
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then an "opensearch" "domain" is created then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When an "opensearch" "domain" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then an "opensearch" "index" is created in the "opensearch" "domain" then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" is invoked then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" is invoked
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then a "lambda" "function" is deployed then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When a "lambda" "function" is deployed
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "opensearch" "domain" is created then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "domain" is created
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" is invoked then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" indexes a document into the OpenSearch index during invocation then the "lambda" "function" invocation fails
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When the "lambda" "function" invocation fails
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation completes successfully then the "lambda" "function" invocation fails then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation completes successfully
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then a "lambda" "function" is deployed then an "opensearch" "index" is created in the "opensearch" "domain"
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When a "lambda" "function" is deployed
    When an "opensearch" "index" is created in the "opensearch" "domain"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "opensearch" "domain" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "opensearch" "domain" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then an "opensearch" "index" is created in the "opensearch" "domain" then the "lambda" "function" indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When an "opensearch" "index" is created in the "opensearch" "domain"
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" is invoked then the "lambda" "function" invocation completes successfully
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" is invoked
    When the "lambda" "function" invocation completes successfully
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" indexes a document into the OpenSearch index during invocation then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" indexes a document into the OpenSearch index during invocation
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"

  @sequence
  Scenario: the "lambda" "function" invocation fails then the "lambda" "function" invocation completes successfully then an "opensearch" "domain" is created
    Given iid in inv_status
    When the "lambda" "function" invocation fails
    When the "lambda" "function" invocation completes successfully
    When an "opensearch" "domain" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "INDEXED" "opensearch" "document" belongs to an existing "opensearch" "index"
    And every existing "opensearch" "index" belongs to an "ACTIVE" "opensearch" "domain"
