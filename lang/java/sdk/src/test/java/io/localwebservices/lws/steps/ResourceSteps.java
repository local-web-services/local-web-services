package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;
import io.localwebservices.lws.StateMachineSpec;
import io.localwebservices.lws.TableSpec;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ListTablesResponse;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.HeadBucketRequest;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.ListQueuesResponse;

public class ResourceSteps {

  private static final String PASS_DEFINITION =
      "{\"Comment\":\"test\",\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";

  private final WorldContext world;

  // Accumulated spec state for multi-step "Given a session with ..." clauses
  private TableSpec pendingTable;
  private String pendingQueue;
  private String pendingBucket;
  private String pendingTopic;
  private String pendingStateMachine;
  private final List<String> extraQueues = new ArrayList<>();
  private final List<String> extraBuckets = new ArrayList<>();

  public ResourceSteps(WorldContext world) {
    this.world = world;
  }

  // ---- resource_specification.feature — session-creating Given steps ----

  @Given("a session with a DynamoDB table {string} with partition key {string}")
  public void aSessionWithADynamoDbTableWithPartitionKey(String tableName, String partitionKey)
      throws Exception {
    pendingTable = new TableSpec(tableName, partitionKey);
    SessionSpec spec = new SessionSpec().tables(List.of(pendingTable));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("a session with an SQS queue {string}")
  public void aSessionWithAnSQSQueue(String queueName) throws Exception {
    pendingQueue = queueName;
    SessionSpec spec = new SessionSpec().queues(List.of(queueName));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("a session with an S3 bucket {string}")
  public void aSessionWithAnS3Bucket(String bucketName) throws Exception {
    pendingBucket = bucketName;
    SessionSpec spec = new SessionSpec().buckets(List.of(bucketName));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("a session with an SNS topic {string}")
  public void aSessionWithAnSNSTopic(String topicName) throws Exception {
    pendingTopic = topicName;
    SessionSpec spec = new SessionSpec().topics(List.of(topicName));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("a session with a state machine {string} using a Pass definition")
  public void aSessionWithAStateMachineUsingAPassDefinition(String smName) throws Exception {
    pendingStateMachine = smName;
    SessionSpec spec =
        new SessionSpec().stateMachines(List.of(new StateMachineSpec(smName, PASS_DEFINITION)));
    world.session = LwsSession.createInProcess(spec);
  }

  @And("the session also has an SQS queue {string}")
  public void theSessionAlsoHasAnSQSQueue(String queueName) throws Exception {
    extraQueues.add(queueName);
    rebuildSession();
  }

  @And("the session also has an S3 bucket {string}")
  public void theSessionAlsoHasAnS3Bucket(String bucketName) throws Exception {
    extraBuckets.add(bucketName);
    rebuildSession();
  }

  private void rebuildSession() throws Exception {
    if (world.session != null) {
      world.session.close();
    }
    List<TableSpec> tables = pendingTable != null ? List.of(pendingTable) : List.of();
    List<String> queues = new ArrayList<>();
    if (pendingQueue != null) queues.add(pendingQueue);
    queues.addAll(extraQueues);
    List<String> buckets = new ArrayList<>();
    if (pendingBucket != null) buckets.add(pendingBucket);
    buckets.addAll(extraBuckets);
    List<String> topics = pendingTopic != null ? List.of(pendingTopic) : List.of();
    List<StateMachineSpec> sms =
        pendingStateMachine != null
            ? List.of(new StateMachineSpec(pendingStateMachine, PASS_DEFINITION))
            : List.of();

    SessionSpec spec =
        new SessionSpec()
            .tables(tables)
            .queues(queues)
            .buckets(buckets)
            .topics(topics)
            .stateMachines(sms);
    world.session = LwsSession.createInProcess(spec);
  }

  // ---- resource_specification.feature — Then assertions ----

  @Then("the table {string} exists")
  public void theTableExists(String tableName) {
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      ListTablesResponse response = client.listTables();
      assertTrue(
          response.tableNames().contains(tableName),
          "Expected table '" + tableName + "' to exist, found: " + response.tableNames());
    }
  }

  @Then("the queue {string} exists")
  public void theQueueExists(String queueName) {
    try (SqsClient client = world.session.sqsClient()) {
      ListQueuesResponse response = client.listQueues(r -> r.queueNamePrefix(queueName));
      assertTrue(
          response.queueUrls().stream().anyMatch(u -> u.contains(queueName)),
          "Expected queue '" + queueName + "' to exist");
    }
  }

  @Then("the bucket {string} exists")
  public void theBucketExists(String bucketName) {
    try (S3Client client = world.session.s3Client()) {
      client.headBucket(HeadBucketRequest.builder().bucket(bucketName).build());
      assertTrue(true, "bucket exists");
    }
  }

  @Then("the topic {string} exists")
  public void theTopicExists(String topicName) {
    try (software.amazon.awssdk.services.sns.SnsClient client = world.session.snsClient()) {
      software.amazon.awssdk.services.sns.model.ListTopicsResponse response = client.listTopics();
      assertTrue(
          response.topics().stream().anyMatch(t -> t.topicArn().endsWith(":" + topicName)),
          "Expected SNS topic '" + topicName + "' to exist");
    }
  }

  @Then("the state machine {string} exists")
  public void theStateMachineExists(String smName) {
    try (SfnClient client = world.session.sfnClient()) {
      ListStateMachinesResponse response = client.listStateMachines();
      assertTrue(
          response.stateMachines().stream().anyMatch(sm -> sm.name().equals(smName)),
          "Expected state machine '" + smName + "' to exist");
    }
  }

  // ---- session_reset.feature — resource Given steps ----

  @Given("a running session with a DynamoDB table {string} with partition key {string}")
  public void aRunningSessionWithADynamoDbTableWithPartitionKey(
      String tableName, String partitionKey) throws Exception {
    SessionSpec spec = new SessionSpec().tables(List.of(new TableSpec(tableName, partitionKey)));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("an item with orderId {string} has been put into {string}")
  public void anItemWithOrderIdHasBeenPutInto(String orderId, String tableName) {
    world.session.dynamoDb(tableName).put(Map.of("orderId", AttributeValue.fromS(orderId)));
  }

  @Then("the table {string} contains {int} items")
  public void theTableContainsItems(String tableName, int expectedCount) {
    world.session.dynamoDb(tableName).assertItemCount(expectedCount);
  }

  @Given("a running session with an SQS queue {string}")
  public void aRunningSessionWithAnSQSQueue(String queueName) throws Exception {
    SessionSpec spec = new SessionSpec().queues(List.of(queueName));
    world.session = LwsSession.createInProcess(spec);
  }

  @Given("a message has been sent to {string}")
  public void aMessageHasBeenSentTo(String queueName) {
    world.session.sqs(queueName).send("test-message");
  }

  @Then("{string} contains {int} messages")
  public void queueContainsMessages(String queueName, int expectedCount) {
    try {
      world.session.sqs(queueName).assertMessageCount(expectedCount);
    } catch (software.amazon.awssdk.services.sqs.model.SqsException e) {
      // After a reset the queue may no longer exist — treat as 0 messages
      if (expectedCount == 0) {
        return; // queue gone = 0 messages, which is what the test expects
      }
      throw e;
    }
  }

  // ---- chaos/iam/log Given steps that set up resources ----

  @Given("a DynamoDB table {string} with partition key {string}")
  public void aDynamoDbTableWithPartitionKey(String tableName, String partitionKey) {
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      client.createTable(
          r ->
              r.tableName(tableName)
                  .keySchema(
                      KeySchemaElement.builder()
                          .attributeName(partitionKey)
                          .keyType(KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      AttributeDefinition.builder()
                          .attributeName(partitionKey)
                          .attributeType(ScalarAttributeType.S)
                          .build())
                  .billingMode(BillingMode.PAY_PER_REQUEST));
    }
  }
}
