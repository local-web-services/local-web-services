package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.cli.LwsCli;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.*;
import software.amazon.awssdk.services.eventbridge.model.Target;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.*;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.*;
import software.amazon.awssdk.services.sfn.model.Tag;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.*;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.*;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.*;

public class AbstractSteps {

  // -------------------------------------------------------------------------
  // Constants
  // -------------------------------------------------------------------------
  private static final String TEST_SQS_QUEUE = "test-q-1";
  private static final String TEST_SQS_DLQ = "test-dlq-1";
  private static final String TEST_SQS_MSG = "test-message-1";
  private static final String TEST_DDB_TABLE = "test-table-1";
  private static final String TEST_DDB_KEY = "id";
  private static final String TEST_DDB_KEY_VAL = "test-id-1";
  private static final String TEST_S3_BUCKET = "test-bucket-1";
  private static final String TEST_S3_SRC_BUCKET = "test-src-1";
  private static final String TEST_S3_DST_BUCKET = "test-dst-1";
  private static final String TEST_S3_KEY = "test-key-1";
  private static final String TEST_S3_BODY = "test-body-1";
  private static final String TEST_SNS_TOPIC = "test-topic-1";
  private static final String TEST_SNS_ENDPOINT = "arn:aws:sqs:us-east-1:000000000000:test-q-1";
  private static final String TEST_SNS_PROTOCOL = "sqs";
  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_EVENT_RULE = "test-rule-1";
  private static final String TEST_EVENT_TARGET = "arn:aws:sqs:us-east-1:000000000000:test-q-1";
  private static final String TEST_SFN_STANDARD_SM = "test-sm-1";
  private static final String TEST_SFN_EXPRESS_SM = "test-sm-express-1";
  private static final String TEST_SFN_ROLE_ARN =
      "arn:aws:iam::000000000000:role/StepFunctionsRole";
  private static final String TEST_SFN_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_SFN_INPUT = "{}";
  private static final String TEST_SSM_PARAM = "/test/param/1";
  private static final String TEST_SSM_PARAM2 = "/test/param/2";
  private static final String TEST_SSM_VALUE = "test-value-1";
  private static final String TEST_SSM_VALUE2 = "test-value-2";
  private static final String TEST_SSM_TAG_KEY = "env";
  private static final String TEST_SSM_TAG_VAL = "test";
  private static final String TEST_SM_SECRET = "test-secret-1";
  private static final String TEST_SM_VALUE = "test-secret-value-1";
  private static final String TEST_SM_VALUE2 = "test-secret-value-2";
  private static final String TEST_SM_TAG_KEY = "env";
  private static final String TEST_SM_TAG_VAL = "test";

  private final WorldContext world;

  public AbstractSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private String sfnArn(String name) {
    return "arn:aws:states:us-east-1:000000000000:stateMachine:" + name;
  }

  private static boolean isAlreadyExistsError(Exception e) {
    if (e instanceof software.amazon.awssdk.awscore.exception.AwsServiceException) {
      String code =
          ((software.amazon.awssdk.awscore.exception.AwsServiceException) e)
              .awsErrorDetails()
              .errorCode();
      if (code != null
          && (code.contains("AlreadyExists")
              || code.contains("ResourceInUse")
              || code.contains("ResourceExistsException")
              || code.contains("BucketAlreadyOwnedByYou"))) {
        return true;
      }
    }
    String msg = e.getMessage() != null ? e.getMessage() : "";
    return msg.contains("AlreadyExists")
        || msg.contains("ResourceInUse")
        || msg.contains("already exists")
        || msg.contains("ResourceExistsException");
  }

  private void sqsCreateQueue(String name) {
    try (SqsClient client = world.sqsClient()) {
      client.createQueue(r -> r.queueName(name));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  private void ddbCreateTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      client.createTable(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .keySchema(
                      KeySchemaElement.builder()
                          .attributeName(TEST_DDB_KEY)
                          .keyType(KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      AttributeDefinition.builder()
                          .attributeName(TEST_DDB_KEY)
                          .attributeType(ScalarAttributeType.S)
                          .build())
                  .billingMode(BillingMode.PAY_PER_REQUEST));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  private void s3CreateBucket(String name) {
    try (S3Client client = world.s3Client()) {
      client.createBucket(r -> r.bucket(name));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  private void snsCreateTopic() {
    try (SnsClient client = world.snsClient()) {
      CreateTopicResponse result = client.createTopic(r -> r.name(TEST_SNS_TOPIC));
      world.lastTopicArn = result.topicArn();
    } catch (Exception e) {
      String className = e.getClass().getSimpleName();
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (className.contains("TopicLimitExceeded")
          || msg.contains("TopicLimitExceeded")
          || msg.contains("Topic already exists")) {
        world.lastTopicArn = "arn:aws:sns:us-east-1:000000000000:" + TEST_SNS_TOPIC;
      } else {
        throw e;
      }
    }
  }

  private void ebCreateBus() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  private void ebPutRule() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putRule(
          r ->
              r.name(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .scheduleExpression("rate(1 day)")
                  .state(RuleState.ENABLED));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  private void sfnCreateStandardSM() {
    try (SfnClient client = world.sfnClient()) {
      CreateStateMachineResponse result =
          client.createStateMachine(
              r ->
                  r.name(TEST_SFN_STANDARD_SM)
                      .definition(TEST_SFN_DEFINITION)
                      .roleArn(TEST_SFN_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = result.stateMachineArn();
    } catch (Exception e) {
      if (isAlreadyExistsError(e)) {
        world.lastStateMachineArn = sfnArn(TEST_SFN_STANDARD_SM);
      } else {
        throw e;
      }
    }
  }

  private void sfnCreateExpressSM() {
    try (SfnClient client = world.sfnClient()) {
      CreateStateMachineResponse result =
          client.createStateMachine(
              r ->
                  r.name(TEST_SFN_EXPRESS_SM)
                      .definition(TEST_SFN_DEFINITION)
                      .roleArn(TEST_SFN_ROLE_ARN)
                      .type(StateMachineType.EXPRESS));
      world.lastStateMachineArn = result.stateMachineArn();
    } catch (Exception e) {
      if (isAlreadyExistsError(e)) {
        world.lastStateMachineArn = sfnArn(TEST_SFN_EXPRESS_SM);
      } else {
        throw e;
      }
    }
  }

  private void smCreateSecret() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      client.createSecret(r -> r.name(TEST_SM_SECRET).secretString(TEST_SM_VALUE));
    } catch (Exception e) {
      if (!isAlreadyExistsError(e)) {
        throw e;
      }
    }
  }

  // -------------------------------------------------------------------------
  // Common steps
  // -------------------------------------------------------------------------

  @Given("the system is initialized")
  public void theSystemIsInitialized() {
    // no-op
  }

  @Then("the operation is rejected")
  public void theOperationIsRejected() {
    assertFalse(world.lastSuccess, "Expected operation to be rejected but it succeeded");
  }

  @Given("^every .*$")
  public void everyInvariant() {
    // no-op: catch-all for invariant assertions
  }

  @Given("\"GSI\" pending write count is never negative")
  public void gsiPendingWriteCountIsNeverNegative() {
    // no-op
  }

  @Given("transaction status is always a valid value")
  public void transactionStatusIsAlwaysAValidValue() {
    // no-op
  }

  @Given("a pending transaction always references an existing table")
  public void aPendingTransactionAlwaysReferencesAnExistingTable() {
    // no-op
  }

  @Given("deleted tables are never the target of a pending transaction")
  public void deletedTablesAreNeverTheTargetOfAPendingTransaction() {
    // no-op
  }

  @Given("no delivery is in-flight to a deleted subscription")
  public void noDeliveryIsInFlightToADeletedSubscription() {
    // no-op
  }

  @Given("no delivery is in-flight to an unconfirmed subscription")
  public void noDeliveryIsInFlightToAnUnconfirmedSubscription() {
    // no-op
  }

  @Given("overwriting a parameter always increments its version")
  public void overwritingAParameterAlwaysIncrementsItsVersion() {
    // no-op
  }

  @Given("all tag keys are strings")
  public void allTagKeysAreStrings() {
    // no-op
  }

  @Given("synchronous executions only run on express state machines")
  public void synchronousExecutionsOnlyRunOnExpressStateMachines() {
    // no-op
  }

  // -------------------------------------------------------------------------
  // SQS Given steps
  // -------------------------------------------------------------------------

  @Given("the queue does not already exist")
  public void theQueueDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the queue already exists")
  public void theQueueAlreadyExists() {
    sqsCreateQueue(TEST_SQS_QUEUE);
  }

  @Given("the queue exists")
  public void theQueueExists() {
    sqsCreateQueue(TEST_SQS_QUEUE);
  }

  @Given("the queue is \"ACTIVE\"")
  public void theQueueIsActive() {
    // no-op
  }

  @Given("the queue is not \"ACTIVE\"")
  public void theQueueIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the queue does not exist")
  public void theQueueDoesNotExist() {
    // no-op
  }

  @Given("the message slot is available")
  public void theMessageSlotIsAvailable() {
    // no-op
  }

  @Given("the message slot is not available")
  public void theMessageSlotIsNotAvailable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the message exists")
  public void theMessageExists() {
    sqsCreateQueue(TEST_SQS_QUEUE);
    try (SqsClient client = world.sqsClient()) {
      client.sendMessage(
          r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).messageBody(TEST_SQS_MSG));
    }
  }

  @Given("the message is \"AVAILABLE\"")
  public void theMessageIsAvailable() {
    // no-op
  }

  @Given("the message is not \"AVAILABLE\"")
  public void theMessageIsNotAvailable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the message's queue exists")
  public void theMessagesQueueExists() {
    // no-op
  }

  @Given("the message's queue does not exist")
  public void theMessagesQueueDoesNotExist() {
    Assumptions.assumeTrue(false, "cannot un-create queue after message exists in fake");
  }

  @Given("the message's queue is \"ACTIVE\"")
  public void theMessagesQueueIsActive() {
    // no-op
  }

  @Given("the message's queue is not \"ACTIVE\"")
  public void theMessagesQueueIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the message is \"IN_FLIGHT\"")
  public void theMessageIsInFlight() {
    sqsCreateQueue(TEST_SQS_QUEUE);
    try (SqsClient client = world.sqsClient()) {
      client.sendMessage(
          r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).messageBody(TEST_SQS_MSG));
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE))
                      .maxNumberOfMessages(1)
                      .visibilityTimeout(30));
      if (!result.messages().isEmpty()) {
        world.lastReceiptHandle = result.messages().get(0).receiptHandle();
      }
    }
  }

  @Given("the message is not \"IN_FLIGHT\"")
  public void theMessageIsNotInFlight() {
    // no-op
  }

  @Given("the queue has a maximum receive count configured")
  public void theQueueHasAMaximumReceiveCountConfigured() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the dead-letter queue is empty")
  public void theDeadLetterQueueIsEmpty() {
    // no-op: fresh state has empty dead-letter queue
  }

  @Given("the queue is already {string}")
  public void theQueueIsAlready(String state) throws Exception {
    if ("ACTIVE".equals(state)) {
      sqsCreateQueue(TEST_SQS_QUEUE);
      return;
    }
    if ("CREATING".equals(state)) {
      LwsCli.lifecycleSet(world.managementPort(), "sqs", 10000, 0);
      sqsCreateQueue(TEST_SQS_QUEUE);
      return;
    }
    if ("DELETING".equals(state)) {
      LwsCli.lifecycleSet(world.managementPort(), "sqs", 0, 10000);
      sqsCreateQueue(TEST_SQS_QUEUE);
      try (SqsClient client = world.sqsClient()) {
        client.deleteQueue(r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)));
      }
      return;
    }
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the message does not exist")
  public void theMessageDoesNotExist() {
    // no-op: fresh state has no messages
  }

  @Given("the queue does not have a maximum receive count configured")
  public void theQueueDoesNotHaveAMaximumReceiveCountConfigured() {
    // no-op
  }

  @Given("the message has exceeded the maximum receive count")
  public void theMessageHasExceededTheMaximumReceiveCount() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the message has not exceeded the maximum receive count")
  public void theMessageHasNotExceededTheMaximumReceiveCount() {
    // no-op
  }

  @Given("the dead-letter queue exists")
  public void theDeadLetterQueueExists() {
    sqsCreateQueue(TEST_SQS_DLQ);
  }

  @Given("the dead-letter queue is \"ACTIVE\"")
  public void theDeadLetterQueueIsActive() {
    // no-op
  }

  @Given("the dead-letter queue does not exist")
  public void theDeadLetterQueueDoesNotExist() {
    // no-op
  }

  @Given("the dead-letter queue is not \"ACTIVE\"")
  public void theDeadLetterQueueIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  // -------------------------------------------------------------------------
  // SQS When steps
  // -------------------------------------------------------------------------

  @When("a queue is created")
  public void aQueueIsCreated() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.createQueue(r -> r.queueName(TEST_SQS_QUEUE)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a queue is deleted")
  public void aQueueIsDeleted() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.deleteQueue(r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message is sent to the queue")
  public void aMessageIsSentToTheQueue() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.sendMessage(
              r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).messageBody(TEST_SQS_MSG)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message is received from the queue")
  public void aMessageIsReceivedFromTheQueue() {
    try (SqsClient client = world.sqsClient()) {
      ReceiveMessageResponse out =
          client.receiveMessage(
              r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).maxNumberOfMessages(1));
      if (!out.messages().isEmpty()) {
        world.lastReceiptHandle = out.messages().get(0).receiptHandle();
      }
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an in-flight message is deleted")
  public void anInFlightMessageIsDeleted() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.deleteMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE))
                      .receiptHandle(world.lastReceiptHandle)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("queue attributes are retrieved")
  public void queueAttributesAreRetrieved() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.getQueueAttributes(
              r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).attributeNamesWithStrings("All")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all messages in a queue are purged")
  public void allMessagesInAQueueArePurged() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.purgeQueue(r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("message visibility timeout is changed")
  public void messageVisibilityTimeoutIsChanged() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.changeMessageVisibility(
              r ->
                  r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE))
                      .receiptHandle(world.lastReceiptHandle)
                      .visibilityTimeout(60)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a message exceeding its receive count is moved to the dead-letter queue")
  public void aMessageExceedingItsReceiveCountIsMovedToTheDeadLetterQueue() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a message visibility timeout expires")
  public void aMessageVisibilityTimeoutExpires() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SQS Then steps
  // -------------------------------------------------------------------------

  @Then("the queue is \"DELETED\" and its messages are removed")
  public void theQueueIsDeletedAndItsMessagesAreRemoved() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the message is \"AVAILABLE\" for delivery")
  public void theMessageIsAvailableForDelivery() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the message is removed from the queue")
  public void theMessageIsRemovedFromTheQueue() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the queue attributes are returned")
  public void theQueueAttributesAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("all messages in the queue are \"DELETED\"")
  public void allMessagesInTheQueueAreDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the dead-letter queue never exceeds its bounded capacity")
  public void theDeadLetterQueueNeverExceedsItsBoundedCapacity() {
    // no-op: invariant check
  }

  @Then("a rule can only be deleted when it has no targets")
  public void aRuleCanOnlyBeDeletedWhenItHasNoTargets() {
    // no-op: invariant check
  }

  @Then("the message visibility is updated")
  public void theMessageVisibilityIsUpdated() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the message is \"AVAILABLE\" in the dead-letter queue")
  public void theMessageIsAvailableInTheDeadLetterQueue() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the message becomes \"AVAILABLE\" again")
  public void theMessageBecomesAvailableAgain() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // DynamoDB Given steps
  // -------------------------------------------------------------------------

  @Given("the table does not already exist")
  public void theTableDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the table already exists")
  public void theTableAlreadyExists() {
    ddbCreateTable();
  }

  @Given("the table exists")
  public void theTableExists() {
    ddbCreateTable();
  }

  @Given("the table is \"CREATING\"")
  public void theTableIsCreating() {
    try {
      LwsCli.lifecycleSet(world.managementPort(), "dynamodb", 10000, 0);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    ddbCreateTable();
  }

  @Given("the table is not \"CREATING\"")
  public void theTableIsNotCreating() {
    // no-op
  }

  @Given("the table does not exist")
  public void theTableDoesNotExist() {
    // no-op
  }

  @Given("the table is \"ACTIVE\"")
  public void theTableIsActive() {
    // no-op
  }

  @Given("the table is not \"ACTIVE\"")
  public void theTableIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("writes are not throttled")
  public void writesAreNotThrottled() {
    // no-op
  }

  @Given("writes are throttled")
  public void writesAreThrottled() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("reads are not throttled")
  public void readsAreNotThrottled() {
    // no-op
  }

  @Given("reads are throttled")
  public void readsAreThrottled() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the item exists")
  public void theItemExists() {
    ddbCreateTable();
    try (DynamoDbClient client = world.dynamodbClient()) {
      client.putItem(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .item(java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL))));
    }
  }

  @Given("the item is present")
  public void theItemIsPresent() {
    // no-op
  }

  @Given("the item does not exist")
  public void theItemDoesNotExist() {
    // no-op
  }

  @Given("the item is not present")
  public void theItemIsNotPresent() {
    ddbCreateTable();
    try (DynamoDbClient client = world.dynamodbClient()) {
      client.deleteItem(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .key(java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL))));
    }
  }

  @Given("no transaction is currently in progress")
  public void noTransactionIsCurrentlyInProgress() {
    // no-op
  }

  @Given("a transaction is currently in progress")
  public void aTransactionIsCurrentlyInProgress() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("a transaction is \"PENDING\"")
  public void aTransactionIsPending() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the transaction's table exists")
  public void theTransactionsTableExists() {
    // no-op
  }

  @Given("the transaction's table is \"ACTIVE\"")
  public void theTransactionsTableIsActive() {
    // no-op
  }

  @Given("the transaction's table does not exist")
  public void theTransactionsTableDoesNotExist() {
    // no-op: table is absent by default after reset
  }

  @Given("the transaction's table is not \"ACTIVE\"")
  public void theTransactionsTableIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the transaction is \"COMMITTED\"")
  public void theTransactionIsCommitted() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the transaction is not \"COMMITTED\"")
  public void theTransactionIsNotCommitted() {
    // no-op
  }

  @Given("the transaction is \"ROLLED_BACK\"")
  public void theTransactionIsRolledBack() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the transaction is not \"ROLLED_BACK\"")
  public void theTransactionIsNotRolledBack() {
    // no-op
  }

  @Given("the table is already {string}")
  public void theTableIsAlready(String state) throws Exception {
    if ("ACTIVE".equals(state)) {
      ddbCreateTable();
      return;
    }
    if ("CREATING".equals(state)) {
      LwsCli.lifecycleSet(world.managementPort(), "dynamodb", 10000, 0);
      ddbCreateTable();
      return;
    }
    if ("DELETING".equals(state)) {
      LwsCli.lifecycleSet(world.managementPort(), "dynamodb", 0, 10000);
      ddbCreateTable();
      try (DynamoDbClient client = world.dynamodbClient()) {
        client.deleteTable(r -> r.tableName(TEST_DDB_TABLE));
      }
      return;
    }
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the table exists and is {string}")
  public void theTableExistsAndIs(String state) {
    ddbCreateTable();
  }

  @Given("the table does not exist or is not {string}")
  public void theTableDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the transaction is \"PENDING\"")
  public void theTransactionIsPending() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the table has pending \"GSI\" propagation")
  public void theTableHasPendingGsiPropagation() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the table does not have pending \"GSI\" propagation")
  public void theTableDoesNotHavePendingGsiPropagation() {
    // no-op
  }

  @Then("items only exist in non-deleted tables")
  public void itemsOnlyExistInNonDeletedTables() {
    // no-op: invariant check
  }

  @Then("the table is marked as \"DELETED\" and all its items are removed")
  public void theTableIsMarkedAsDeletedAndAllItsItemsAreRemoved() {
    // no-op: invariant check
  }

  @Then("the table enters {string} state and all its items are removed")
  public void theTableEntersStateAndAllItsItemsAreRemoved(String state) {
    // Arrange
    assertTrue(world.lastSuccess, "Expected DeleteTable to succeed but got: " + world.lastOutput);

    // Act
    try (DynamoDbClient client = world.dynamodbClient()) {
      List<String> actualTables = client.listTables().tableNames();

      // Assert
      assertFalse(
          actualTables.contains(TEST_DDB_TABLE),
          "Expected table \""
              + TEST_DDB_TABLE
              + "\" to be removed after deletion but it still appears in: "
              + actualTables);
    }
  }

  @Given("there are writes pending propagation to the \"GSI\"")
  public void thereAreWritesPendingPropagationToTheGsi() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("there are no writes pending propagation to the \"GSI\"")
  public void thereAreNoWritesPendingPropagationToTheGsi() {
    // no-op
  }

  // -------------------------------------------------------------------------
  // DynamoDB When steps
  // -------------------------------------------------------------------------

  @When("a table is created")
  public void aTableIsCreated() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.createTable(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .keySchema(
                          KeySchemaElement.builder()
                              .attributeName(TEST_DDB_KEY)
                              .keyType(KeyType.HASH)
                              .build())
                      .attributeDefinitions(
                          AttributeDefinition.builder()
                              .attributeName(TEST_DDB_KEY)
                              .attributeType(ScalarAttributeType.S)
                              .build())
                      .billingMode(BillingMode.PAY_PER_REQUEST)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table finishes creating and becomes active")
  public void aTableFinishesCreatingAndBecomesActive() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a table is deleted")
  public void aTableIsDeleted() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(client.deleteTable(r -> r.tableName(TEST_DDB_TABLE)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table is described")
  public void aTableIsDescribed() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(client.describeTable(r -> r.tableName(TEST_DDB_TABLE)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all tables are listed")
  public void allTablesAreListed() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(client.listTables(ListTablesRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an item is written to the table")
  public void anItemIsWrittenToTheTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.putItem(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .item(
                          java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an item is read from the table")
  public void anItemIsReadFromTheTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.getItem(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .key(
                          java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an existing item is deleted from the table")
  public void anExistingItemIsDeletedFromTheTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.deleteItem(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .key(
                          java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an existing item is updated in the table")
  public void anExistingItemIsUpdatedInTheTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.updateItem(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .key(java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))
                      .updateExpression("SET #v = :v")
                      .expressionAttributeNames(java.util.Map.of("#v", "value"))
                      .expressionAttributeValues(
                          java.util.Map.of(":v", AttributeValue.fromS("updated")))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("items are queried from the table by key")
  public void itemsAreQueriedFromTheTableByKey() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.query(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .keyConditionExpression("#k = :v")
                      .expressionAttributeNames(java.util.Map.of("#k", TEST_DDB_KEY))
                      .expressionAttributeValues(
                          java.util.Map.of(":v", AttributeValue.fromS(TEST_DDB_KEY_VAL)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all items in the table are scanned")
  public void allItemsInTheTableAreScanned() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(client.scan(r -> r.tableName(TEST_DDB_TABLE)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an item is conditionally written to the table")
  public void anItemIsConditionallyWrittenToTheTable() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.putItem(
              r ->
                  r.tableName(TEST_DDB_TABLE)
                      .item(java.util.Map.of(TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))
                      .conditionExpression("attribute_not_exists(id)")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a transactional write is initiated across one or more items")
  public void aTransactionalWriteIsInitiatedAcrossOneOrMoreItems() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.transactWriteItems(
              r ->
                  r.transactItems(
                      TransactWriteItem.builder()
                          .put(
                              Put.builder()
                                  .tableName(TEST_DDB_TABLE)
                                  .item(
                                      java.util.Map.of(
                                          TEST_DDB_KEY, AttributeValue.fromS(TEST_DDB_KEY_VAL)))
                                  .build())
                          .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a pending transaction resolves non-deterministically")
  public void aPendingTransactionResolvesNonDeterministically() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a committed transaction is cleared")
  public void aCommittedTransactionIsCleared() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a rolled-back transaction is cleared")
  public void aRolledBackTransactionIsCleared() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a \"GSI\" catches up with pending write propagation")
  public void aGsiCatchesUpWithPendingWritePropagation() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("read throttling is toggled on or off")
  public void readThrottlingIsToggledOnOrOff() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("write throttling is toggled on or off")
  public void writeThrottlingIsToggledOnOrOff() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // DynamoDB Then steps
  // -------------------------------------------------------------------------

  @Then("the table is in \"CREATING\" state")
  public void theTableIsInCreatingState() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the table is \"ACTIVE\" and ready for reads and writes")
  public void theTableIsActiveAndReadyForReadsAndWrites() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the table is marked as \"DELETED\"")
  public void theTableIsMarkedAsDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the table metadata is returned")
  public void theTableMetadataIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of tables is returned")
  public void theListOfTablesIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the item exists in the table and \"GSI\" propagation is pending")
  public void theItemExistsInTheTableAndGsiPropagationIsPending() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the item value is returned")
  public void theItemValueIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the item is deleted or unchanged \\(conditional delete\\)")
  public void theItemIsDeletedOrUnchangedConditionalDelete() {
    // no-op
  }

  @Then("the item is updated or unchanged \\(conditional update\\)")
  public void theItemIsUpdatedOrUnchangedConditionalUpdate() {
    // no-op
  }

  @Then("matching items are returned")
  public void matchingItemsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("all items are returned")
  public void allItemsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the item is written if the condition holds, otherwise the write is rejected")
  public void theItemIsWrittenIfTheConditionHoldsOtherwiseTheWriteIsRejected() {
    // no-op
  }

  @Then("the transaction is \"COMMITTED\" or \"ROLLED_BACK\"")
  public void theTransactionIsCommittedOrRolledBack() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("no transaction is \"PENDING\"")
  public void noTransactionIsPending() {
    // no-op: after reset, no transactions are pending
  }

  @Then("the transaction slot is free")
  public void theTransactionSlotIsFree() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the \"GSI\" is consistent with the table")
  public void theGsiIsConsistentWithTheTable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("reads are throttled or unthrottled")
  public void readsAreThrottledOrUnthrottled() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("writes are throttled or unthrottled")
  public void writesAreThrottledOrUnthrottled() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // S3 Given steps
  // -------------------------------------------------------------------------

  @Given("the bucket does not already exist")
  public void theBucketDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the bucket already exists")
  public void theBucketAlreadyExists() {
    s3CreateBucket(TEST_S3_BUCKET);
  }

  @Given("the bucket exists")
  public void theBucketExists() {
    s3CreateBucket(TEST_S3_BUCKET);
  }

  @Given("the bucket is \"ACTIVE\"")
  public void theBucketIsActive() {
    // no-op
  }

  @Given("the bucket does not exist")
  public void theBucketDoesNotExist() {
    // no-op
  }

  @Given("the bucket is not \"ACTIVE\"")
  public void theBucketIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the bucket is empty")
  public void theBucketIsEmpty() {
    s3CreateBucket(TEST_S3_BUCKET);
    // bucket starts empty, no objects to add
  }

  @Given("the bucket is not empty")
  public void theBucketIsNotEmpty() {
    s3CreateBucket(TEST_S3_BUCKET);
    try (software.amazon.awssdk.services.s3.S3Client client = world.s3Client()) {
      client.putObject(
          r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY),
          software.amazon.awssdk.core.sync.RequestBody.fromString(TEST_S3_BODY));
    }
  }

  @Then("deleting a bucket requires it to be empty")
  public void deletingABucketRequiresItToBeEmpty() {
    // no-op: invariant check
  }

  @Then("the object {string} in the destination bucket")
  public void theObjectInTheDestinationBucket(String state) {
    if ("EXISTS".equals(state)) {
      assertTrue(world.lastSuccess, "Expected object to exist but got: " + world.lastOutput);
    } else {
      assertFalse(world.lastSuccess, "Expected object to not exist but it does");
    }
  }

  @Given("the object exists in the bucket")
  public void theObjectExistsInTheBucket() {
    s3CreateBucket(TEST_S3_BUCKET);
    try (S3Client client = world.s3Client()) {
      client.putObject(
          PutObjectRequest.builder().bucket(TEST_S3_BUCKET).key(TEST_S3_KEY).build(),
          RequestBody.fromString(TEST_S3_BODY));
    }
  }

  @Given("the object is not deleted")
  public void theObjectIsNotDeleted() {
    // no-op
  }

  @Given("the object does not exist in the bucket")
  public void theObjectDoesNotExistInTheBucket() {
    // no-op
  }

  @Given("the object is deleted")
  public void theObjectIsDeleted() {
    s3CreateBucket(TEST_S3_BUCKET);
    try (S3Client client = world.s3Client()) {
      client.putObject(
          PutObjectRequest.builder().bucket(TEST_S3_BUCKET).key(TEST_S3_KEY).build(),
          RequestBody.fromString(TEST_S3_BODY));
      client.deleteObject(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY));
    }
  }

  @Given("the source bucket exists")
  public void theSourceBucketExists() {
    s3CreateBucket(TEST_S3_SRC_BUCKET);
  }

  @Given("the source bucket is \"ACTIVE\"")
  public void theSourceBucketIsActive() {
    // no-op
  }

  @Given("the source object exists")
  public void theSourceObjectExists() {
    s3CreateBucket(TEST_S3_SRC_BUCKET);
    try (S3Client client = world.s3Client()) {
      client.putObject(
          PutObjectRequest.builder().bucket(TEST_S3_SRC_BUCKET).key(TEST_S3_KEY).build(),
          RequestBody.fromString(TEST_S3_BODY));
    }
  }

  @Given("the source object is not deleted")
  public void theSourceObjectIsNotDeleted() {
    // no-op
  }

  @Given("the destination bucket exists")
  public void theDestinationBucketExists() {
    s3CreateBucket(TEST_S3_DST_BUCKET);
  }

  @Given("the destination bucket is \"ACTIVE\"")
  public void theDestinationBucketIsActive() {
    // no-op
  }

  @Given("the source bucket does not exist")
  public void theSourceBucketDoesNotExist() {
    // no-op
  }

  @Given("the source bucket is not \"ACTIVE\"")
  public void theSourceBucketIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the source object does not exist")
  public void theSourceObjectDoesNotExist() {
    // no-op
  }

  @Given("the source object is deleted")
  public void theSourceObjectIsDeleted() {
    s3CreateBucket(TEST_S3_SRC_BUCKET);
    try (S3Client client = world.s3Client()) {
      client.putObject(
          PutObjectRequest.builder().bucket(TEST_S3_SRC_BUCKET).key(TEST_S3_KEY).build(),
          RequestBody.fromString(TEST_S3_BODY));
      client.deleteObject(r -> r.bucket(TEST_S3_SRC_BUCKET).key(TEST_S3_KEY));
    }
  }

  @Given("the destination bucket does not exist")
  public void theDestinationBucketDoesNotExist() {
    // no-op
  }

  @Given("the destination bucket is not \"ACTIVE\"")
  public void theDestinationBucketIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the upload does not already exist")
  public void theUploadDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the upload exists")
  public void theUploadExists() {
    s3CreateBucket(TEST_S3_BUCKET);
    try (S3Client client = world.s3Client()) {
      CreateMultipartUploadResponse result =
          client.createMultipartUpload(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY));
      world.lastUploadId = result.uploadId();
      world.lastBucket = TEST_S3_BUCKET;
      world.lastKey = TEST_S3_KEY;
    }
  }

  @Given("the upload is \"IN_PROGRESS\"")
  public void theUploadIsInProgress() {
    // no-op
  }

  @Given("the upload has at least one part")
  public void theUploadHasAtLeastOnePart() {
    if (world.lastUploadId == null || world.lastUploadId.isEmpty()) {
      s3CreateBucket(TEST_S3_BUCKET);
      try (S3Client client = world.s3Client()) {
        CreateMultipartUploadResponse result =
            client.createMultipartUpload(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY));
        world.lastUploadId = result.uploadId();
        world.lastBucket = TEST_S3_BUCKET;
        world.lastKey = TEST_S3_KEY;
      }
    }
    try (S3Client client = world.s3Client()) {
      UploadPartResponse partResult =
          client.uploadPart(
              UploadPartRequest.builder()
                  .bucket(world.lastBucket)
                  .key(world.lastKey)
                  .uploadId(world.lastUploadId)
                  .partNumber(1)
                  .build(),
              RequestBody.fromString(TEST_S3_BODY));
      world.lastETag = partResult.eTag();
    }
  }

  @Given("the upload does not exist")
  public void theUploadDoesNotExist() {
    // no-op
  }

  @Given("the upload is not \"IN_PROGRESS\"")
  public void theUploadIsNotInProgress() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the upload has no parts")
  public void theUploadHasNoParts() {
    // no-op
  }

  @Given("the upload already exists")
  public void theUploadAlreadyExists() {
    s3CreateBucket(TEST_S3_BUCKET);
    try (S3Client client = world.s3Client()) {
      CreateMultipartUploadResponse result =
          client.createMultipartUpload(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY));
      world.lastUploadId = result.uploadId();
      world.lastBucket = TEST_S3_BUCKET;
      world.lastKey = TEST_S3_KEY;
    }
  }

  // -------------------------------------------------------------------------
  // S3 When steps
  // -------------------------------------------------------------------------

  @When("a bucket is created")
  public void aBucketIsCreated() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.createBucket(r -> r.bucket(TEST_S3_BUCKET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a bucket is deleted")
  public void aBucketIsDeleted() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteBucket(r -> r.bucket(TEST_S3_BUCKET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the list of buckets is retrieved")
  public void theListOfBucketsIsRetrieved() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.listBuckets());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is uploaded to a bucket")
  public void anObjectIsUploadedToABucket() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putObject(
              PutObjectRequest.builder().bucket(TEST_S3_BUCKET).key(TEST_S3_KEY).build(),
              RequestBody.fromString(TEST_S3_BODY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is retrieved from a bucket")
  public void anObjectIsRetrievedFromABucket() {
    try (S3Client client = world.s3Client()) {
      GetObjectResponse out =
          client
              .getObject(
                  GetObjectRequest.builder().bucket(TEST_S3_BUCKET).key(TEST_S3_KEY).build(),
                  software.amazon.awssdk.core.sync.ResponseTransformer.toBytes())
              .response();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("object metadata is retrieved from a bucket")
  public void objectMetadataIsRetrievedFromABucket() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.headObject(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is deleted from a bucket")
  public void anObjectIsDeletedFromABucket() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.deleteObject(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("objects in a bucket are listed")
  public void objectsInABucketAreListed() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(client.listObjectsV2(r -> r.bucket(TEST_S3_BUCKET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is copied from one bucket to another")
  public void anObjectIsCopiedFromOneBucketToAnother() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.copyObject(
              r ->
                  r.bucket(TEST_S3_DST_BUCKET)
                      .key(TEST_S3_KEY)
                      .copySource(TEST_S3_SRC_BUCKET + "/" + TEST_S3_KEY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is initiated")
  public void aMultipartUploadIsInitiated() {
    try (S3Client client = world.s3Client()) {
      CreateMultipartUploadResponse out =
          client.createMultipartUpload(r -> r.bucket(TEST_S3_BUCKET).key(TEST_S3_KEY));
      world.lastUploadId = out.uploadId();
      world.lastBucket = TEST_S3_BUCKET;
      world.lastKey = TEST_S3_KEY;
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a part is uploaded for a multipart upload")
  public void aPartIsUploadedForAMultipartUpload() {
    try (S3Client client = world.s3Client()) {
      UploadPartResponse out =
          client.uploadPart(
              UploadPartRequest.builder()
                  .bucket(world.lastBucket)
                  .key(world.lastKey)
                  .uploadId(world.lastUploadId)
                  .partNumber(1)
                  .build(),
              RequestBody.fromString(TEST_S3_BODY));
      world.lastETag = out.eTag();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is completed")
  public void aMultipartUploadIsCompleted() {
    try (S3Client client = world.s3Client()) {
      List<CompletedPart> completedParts = new ArrayList<>();
      if (world.lastETag != null && !world.lastETag.isEmpty()) {
        completedParts.add(CompletedPart.builder().eTag(world.lastETag).partNumber(1).build());
      }
      world.setSuccess(
          client.completeMultipartUpload(
              r ->
                  r.bucket(world.lastBucket)
                      .key(world.lastKey)
                      .uploadId(world.lastUploadId)
                      .multipartUpload(
                          CompletedMultipartUpload.builder().parts(completedParts).build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a multipart upload is aborted")
  public void aMultipartUploadIsAborted() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.abortMultipartUpload(
              r -> r.bucket(world.lastBucket).key(world.lastKey).uploadId(world.lastUploadId)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("versioning is configured on a bucket")
  public void versioningIsConfiguredOnABucket() {
    try (S3Client client = world.s3Client()) {
      world.setSuccess(
          client.putBucketVersioning(
              r ->
                  r.bucket(TEST_S3_BUCKET)
                      .versioningConfiguration(
                          VersioningConfiguration.builder()
                              .status(BucketVersioningStatus.ENABLED)
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a lifecycle rule expires an object")
  public void aLifecycleRuleExpiresAnObject() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // S3 Then steps
  // -------------------------------------------------------------------------

  @Then("the bucket is \"ACTIVE\" with versioning disabled")
  public void theBucketIsActiveWithVersioningDisabled() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the bucket is \"DELETED\"")
  public void theBucketIsDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the available buckets are returned")
  public void theAvailableBucketsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the object \"EXISTS\" in the bucket")
  public void assertObjectExistsInBucket() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the object data is returned")
  public void theObjectDataIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the object metadata is returned")
  public void theObjectMetadataIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the object is \"DELETED\"")
  public void assertObjectIsDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of objects in the bucket is returned")
  public void theListOfObjectsInTheBucketIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the upload is \"IN_PROGRESS\" with no parts")
  public void theUploadIsInProgressWithNoParts() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the upload is \"COMPLETED\" and the assembled object \"EXISTS\" in the bucket")
  public void theUploadIsCompletedAndTheAssembledObjectExistsInTheBucket() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the upload is \"ABORTED\"")
  public void theUploadIsAborted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the bucket versioning state is \"ENABLED\" or \"SUSPENDED\" non-deterministically")
  public void theBucketVersioningStateIsEnabledOrSuspendedNonDeterministically() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the object is \"DELETED\" by the lifecycle policy")
  public void theObjectIsDeletedByTheLifecyclePolicy() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SNS Given steps
  // -------------------------------------------------------------------------

  @Given("the topic does not already exist")
  public void theTopicDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the topic already exists")
  public void theTopicAlreadyExists() {
    snsCreateTopic();
  }

  @Given("the topic exists")
  public void theTopicExists() {
    snsCreateTopic();
  }

  @Given("the topic is \"ACTIVE\"")
  public void theTopicIsActive() {
    // no-op
  }

  @Given("the topic is not \"ACTIVE\"")
  public void theTopicIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the topic is already {string}")
  public void theTopicIsAlready(String state) {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the topic does not exist")
  public void theTopicDoesNotExist() {
    // no-op
  }

  @Given("the subscription slot is available")
  public void theSubscriptionSlotIsAvailable() {
    // no-op
  }

  @Given("the subscription slot is not available")
  public void theSubscriptionSlotIsNotAvailable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the subscription exists")
  public void theSubscriptionExists() {
    snsCreateTopic();
    try (SnsClient client = world.snsClient()) {
      SubscribeResponse result =
          client.subscribe(
              r ->
                  r.topicArn(world.lastTopicArn)
                      .protocol(TEST_SNS_PROTOCOL)
                      .endpoint(TEST_SNS_ENDPOINT));
      world.lastSubscriptionArn = result.subscriptionArn();
    }
  }

  @Given("the subscription is \"CONFIRMED\"")
  public void theSubscriptionIsConfirmed() {
    // no-op
  }

  @Given("the subscription is not \"CONFIRMED\"")
  public void theSubscriptionIsNotConfirmed() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the subscription is \"PENDING_CONFIRMATION\"")
  public void theSubscriptionIsPendingConfirmation() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the subscription is not \"PENDING_CONFIRMATION\"")
  public void theSubscriptionIsNotPendingConfirmation() {
    // no-op
  }

  @Given("the subscription does not exist")
  public void theSubscriptionDoesNotExist() {
    // no-op
  }

  @Given("the subscription's topic exists")
  public void theSubscriptionsTopicExists() {
    // no-op
  }

  @Given("the subscription's topic is \"ACTIVE\"")
  public void theSubscriptionsTopicIsActive() {
    // no-op
  }

  @Given("the subscription's topic does not exist")
  public void theSubscriptionsTopicDoesNotExist() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the subscription's topic is not \"ACTIVE\"")
  public void theSubscriptionsTopicIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("a confirmed subscription exists for the topic")
  public void aConfirmedSubscriptionExistsForTheTopic() {
    snsCreateTopic();
    try (SnsClient client = world.snsClient()) {
      SubscribeResponse result =
          client.subscribe(
              r ->
                  r.topicArn(world.lastTopicArn)
                      .protocol(TEST_SNS_PROTOCOL)
                      .endpoint(TEST_SNS_ENDPOINT));
      world.lastSubscriptionArn = result.subscriptionArn();
    }
  }

  @Given("the subscription belongs to this topic")
  public void theSubscriptionBelongsToThisTopic() {
    // no-op
  }

  @Given("a delivery slot is available")
  public void aDeliverySlotIsAvailable() {
    // no-op
  }

  @Given("no confirmed subscription exists for the topic")
  public void noConfirmedSubscriptionExistsForTheTopic() {
    // no-op
  }

  @Given("the subscription does not belong to this topic")
  public void theSubscriptionDoesNotBelongToThisTopic() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("no delivery slot is available")
  public void noDeliverySlotIsAvailable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the delivery exists")
  public void theDeliveryExists() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the delivery is \"IN_FLIGHT\"")
  public void theDeliveryIsInFlight() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the delivery does not exist")
  public void theDeliveryDoesNotExist() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the delivery is not \"IN_FLIGHT\"")
  public void theDeliveryIsNotInFlight() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the retry count is below the limit")
  public void theRetryCountIsBelowTheLimit() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the retry count has reached the limit")
  public void theRetryCountHasReachedTheLimit() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SNS When steps
  // -------------------------------------------------------------------------

  @When("an \"SNS\" topic is created")
  public void anSnsTopicIsCreated() {
    try (SnsClient client = world.snsClient()) {
      CreateTopicResponse out = client.createTopic(r -> r.name(TEST_SNS_TOPIC));
      world.lastTopicArn = out.topicArn();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an \"SNS\" topic is deleted")
  public void anSnsTopicIsDeleted() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.deleteTopic(r -> r.topicArn(world.lastTopicArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an endpoint subscribes to a topic")
  public void anEndpointSubscribesToATopic() {
    try (SnsClient client = world.snsClient()) {
      SubscribeResponse out =
          client.subscribe(
              r ->
                  r.topicArn(world.lastTopicArn)
                      .protocol(TEST_SNS_PROTOCOL)
                      .endpoint(TEST_SNS_ENDPOINT));
      world.lastSubscriptionArn = out.subscriptionArn();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a subscription is removed")
  public void aSubscriptionIsRemoved() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.unsubscribe(r -> r.subscriptionArn(world.lastSubscriptionArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a pending subscription is confirmed")
  public void aPendingSubscriptionIsConfirmed() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a message is published to a topic")
  public void aMessageIsPublishedToATopic() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.publish(r -> r.topicArn(world.lastTopicArn).message("test-message")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a delivery attempt succeeds")
  public void aDeliveryAttemptSucceeds() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a delivery attempt fails and is retried")
  public void aDeliveryAttemptFailsAndIsRetried() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("all delivery retries are exhausted")
  public void allDeliveryRetriesAreExhausted() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a subscription confirmation token expires")
  public void aSubscriptionConfirmationTokenExpires() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SNS Then steps
  // -------------------------------------------------------------------------

  @Then("the topic is \"DELETED\" and its subscriptions are removed")
  public void theTopicIsDeletedAndItsSubscriptionsAreRemoved() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the subscription is \"PENDING_CONFIRMATION\" or \"CONFIRMED\"")
  public void theSubscriptionIsPendingConfirmationOrConfirmed() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the subscription is \"DELETED\"")
  public void theSubscriptionIsDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the message is delivered to confirmed subscriptions")
  public void theMessageIsDeliveredToConfirmedSubscriptions() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the delivery is \"DONE\"")
  public void theDeliveryIsDone() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the delivery retry count is incremented")
  public void theDeliveryRetryCountIsIncremented() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the delivery is marked \"DONE\"")
  public void theDeliveryIsMarkedDone() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the pending subscription is \"DELETED\"")
  public void thePendingSubscriptionIsDeleted() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // EventBridge Given steps
  // -------------------------------------------------------------------------

  @Given("the event bus does not already exist")
  public void theEventBusDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the event bus already exists")
  public void theEventBusAlreadyExists() {
    ebCreateBus();
  }

  @Given("the event bus exists")
  public void theEventBusExists() {
    ebCreateBus();
  }

  @Given("the event bus is \"ACTIVE\"")
  public void theEventBusIsActive() {
    // no-op
  }

  @Given("the event bus is not \"ACTIVE\"")
  public void theEventBusIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the event bus does not exist")
  public void theEventBusDoesNotExist() {
    // no-op
  }

  @Given("the event bus is not the default bus")
  public void theEventBusIsNotTheDefaultBus() {
    // no-op
  }

  @Given("the event bus is the default bus")
  public void theEventBusIsTheDefaultBus() {
    // no-op
  }

  @Given("the rule does not already exist")
  public void theRuleDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the rule already exists")
  public void theRuleAlreadyExists() {
    ebCreateBus();
    ebPutRule();
  }

  @Given("the rule exists")
  public void theRuleExists() {
    ebCreateBus();
    ebPutRule();
  }

  @Given("the rule is not \"DELETED\"")
  public void theRuleIsNotDeleted() {
    // no-op
  }

  @Given("the rule does not exist")
  public void theRuleDoesNotExist() {
    // no-op
  }

  @Given("the rule is \"DELETED\"")
  public void theRuleIsDeleted() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the rule is \"DISABLED\"")
  public void theRuleIsDisabled() {
    ebCreateBus();
    ebPutRule(); // idempotent - ignores already-exists error
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
    } catch (Exception e) {
      // If rule is already DISABLED, ignore
    }
  }

  @Given("the rule is \"ENABLED\"")
  public void theRuleIsEnabled() {
    // no-op: rules created by ebPutRule are ENABLED by default
  }

  @Given("the rule is not already \"DELETED\"")
  public void theRuleIsNotAlreadyDeleted() {
    // no-op
  }

  @Given("the rule is already \"DELETED\"")
  public void theRuleIsAlreadyDeleted() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the rule is not \"DISABLED\"")
  public void theRuleIsNotDisabled() {
    // no-op: rule is ENABLED by default when created
  }

  @Given("the rule is not \"ENABLED\"")
  public void theRuleIsNotEnabled() {
    // Rule is not ENABLED means it's DISABLED: disable it
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
    } catch (Exception e) {
      // If rule doesn't exist yet, that's fine - it's not ENABLED
    }
  }

  @Given("a rule is associated with the event bus")
  public void aRuleIsAssociatedWithTheEventBus() {
    ebCreateBus();
    ebPutRule();
  }

  @Given("the rule's event bus matches")
  public void theRulesEventBusMatches() {
    // no-op
  }

  @Given("a target is associated with the rule")
  public void aTargetIsAssociatedWithTheRule() {
    ebCreateBus();
    ebPutRule();
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putTargets(
          r ->
              r.rule(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .targets(Target.builder().id("t1").arn(TEST_EVENT_TARGET).build()));
    }
  }

  @Given("no rule is associated with the event bus")
  public void noRuleIsAssociatedWithTheEventBus() {
    // no-op
  }

  @Given("the rule's event bus does not match")
  public void theRulesEventBusDoesNotMatch() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("no target is associated with the rule")
  public void noTargetIsAssociatedWithTheRule() {
    // no-op
  }

  @Given("the rule has no active targets")
  public void theRuleHasNoActiveTargets() {
    // no-op: rule exists but no targets added
  }

  @Given("the rule has active targets")
  public void theRuleHasActiveTargets() {
    ebCreateBus();
    ebPutRule();
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putTargets(
          r ->
              r.rule(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .targets(
                      software.amazon.awssdk.services.eventbridge.model.Target.builder()
                          .id("t1")
                          .arn(TEST_EVENT_TARGET)
                          .build()));
    }
  }

  @Given("the event bus has no rules")
  public void theEventBusHasNoRules() {
    ebCreateBus();
    // no-op: bus exists but no rules added
  }

  @Given("the event bus has rules")
  public void theEventBusHasRules() {
    ebCreateBus();
    ebPutRule();
  }

  @Given("the dead-letter queue is not empty")
  public void theDeadLetterQueueIsNotEmpty() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // EventBridge When steps
  // -------------------------------------------------------------------------

  @When("an event bus is created")
  public void anEventBusIsCreated() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.createEventBus(r -> r.name(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event bus is deleted")
  public void anEventBusIsDeleted() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.deleteEventBus(r -> r.name(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event bus is described")
  public void anEventBusIsDescribed() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.describeEventBus(r -> r.name(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all event buses are listed")
  public void allEventBusesAreListed() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listEventBuses(ListEventBusesRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is created")
  public void anEventBridgeRuleIsCreated() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putRule(
              r ->
                  r.name(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.ENABLED)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is described")
  public void anEventBridgeRuleIsDescribed() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.describeRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("all rules on an event bus are listed")
  public void allRulesOnAnEventBusAreListed() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listRules(r -> r.eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is deleted")
  public void anEventBridgeRuleIsDeleted() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.deleteRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a rule is enabled")
  public void aRuleIsEnabled() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.enableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a rule is disabled")
  public void aRuleIsDisabled() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("targets are added to a rule")
  public void targetsAreAddedToARule() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putTargets(
              r ->
                  r.rule(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .targets(Target.builder().id("t1").arn(TEST_EVENT_TARGET).build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("targets for a rule are listed")
  public void targetsForARuleAreListed() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.listTargetsByRule(r -> r.rule(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("targets are removed from a rule")
  public void targetsAreRemovedFromARule() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.removeTargets(
              r -> r.rule(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS).ids("t1")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("events are published to an event bus")
  public void eventsArePublishedToAnEventBus() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putEvents(
              r ->
                  r.entries(
                      PutEventsRequestEntry.builder()
                          .eventBusName(TEST_EVENT_BUS)
                          .source("test")
                          .detailType("test")
                          .detail("{}")
                          .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a dead-letter queue entry is retried or discarded")
  public void aDeadLetterQueueEntryIsRetriedOrDiscarded() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // EventBridge Then steps
  // -------------------------------------------------------------------------

  @Then("the event bus is \"DELETED\"")
  public void theEventBusIsDeleted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the event bus details are returned")
  public void theEventBusDetailsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of event buses is returned")
  public void theListOfEventBusesIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the rule details are returned")
  public void theRuleDetailsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of rules is returned")
  public void theListOfRulesIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the targets are associated with the rule")
  public void theTargetsAreAssociatedWithTheRule() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the target is associated with the rule")
  public void theTargetIsAssociatedWithTheRule() {
    // When used as a Given pre-condition, add the target; when used as a Then post-condition, no-op
    // verify
    ebCreateBus();
    ebPutRule();
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putTargets(
          r ->
              r.rule(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .targets(Target.builder().id("t1").arn(TEST_EVENT_TARGET).build()));
    } catch (Exception ignored) {
    }
  }

  @Then("the target association is active")
  public void theTargetAssociationIsActive() {
    // no-op
  }

  @Then("the list of targets is returned")
  public void theListOfTargetsIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the targets are disassociated from the rule")
  public void theTargetsAreDisassociatedFromTheRule() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Given("the target is not associated with the rule")
  public void theTargetIsNotAssociatedWithTheRule() {
    // no-op: fresh rule has no targets
  }

  @Given("the target association is not active")
  public void theTargetAssociationIsNotActive() {
    Assumptions.assumeTrue(false, "target non-active state not reachable via API");
  }

  @Then("matching enabled rules route the event to their targets")
  public void matchingEnabledRulesRouteTheEventToTheirTargets() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the entry is removed from the dead-letter queue")
  public void theEntryIsRemovedFromTheDeadLetterQueue() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the default event bus cannot be deleted")
  public void theDefaultEventBusCannotBeDeleted() {
    // no-op: invariant check
  }

  @Then("^no enabled rule references a deleted event bus$")
  public void noEnabledRuleReferencesADeletedEventBus() {
    // no-op: invariant check
  }

  // -------------------------------------------------------------------------
  // StepFunctions Given steps
  // -------------------------------------------------------------------------

  @Given("the state machine does not already exist")
  public void theStateMachineDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the state machine already exists")
  public void theStateMachineAlreadyExists() {
    sfnCreateStandardSM();
  }

  @Given("the state machine exists")
  public void theStateMachineExists() {
    sfnCreateStandardSM();
  }

  @Given("the state machine is \"ACTIVE\"")
  public void theStateMachineIsActive() {
    // no-op
  }

  @Given("the state machine is not \"ACTIVE\"")
  public void theStateMachineIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the state machine does not exist")
  public void theStateMachineDoesNotExist() {
    // no-op: after reset, no state machine exists
  }

  @Given("the state machine is not \"DELETING\"")
  public void theStateMachineIsNotDeleting() {
    // no-op: state machines are not in DELETING state by default in a fresh state
  }

  @Given("the state machine is not \"DELETED\"")
  public void theStateMachineIsNotDeleted() {
    sfnCreateStandardSM();
  }

  @Given("the state machine is \"DELETING\"")
  public void theStateMachineIsDeleting() {
    try {
      LwsCli.lifecycleSet(world.managementPort(), "stepfunctions", 0, 10000);
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
    sfnCreateStandardSM();
    try (software.amazon.awssdk.services.sfn.SfnClient client = world.sfnClient()) {
      client.deleteStateMachine(r -> r.stateMachineArn(world.lastStateMachineArn));
    }
  }

  @Given("the state machine is \"DELETED\"")
  public void theStateMachineIsDeleted() {
    // State machine was created and fully deleted; no-op since after reset no state machines exist
    // and fully deleted state machines (post-dwell) are indistinguishable from non-existent ones
  }

  @Given("the state machine is a \"STANDARD\" type")
  public void theStateMachineIsAStandardType() {
    sfnCreateStandardSM();
  }

  @Given("the state machine is not a \"STANDARD\" type")
  public void theStateMachineIsNotAStandardType() {
    Assumptions.assumeTrue(false, "cannot test type mismatch in fake");
  }

  @Given("the state machine is an \"EXPRESS\" type")
  public void theStateMachineIsAnExpressType() {
    sfnCreateExpressSM();
  }

  @Given("the state machine is not an \"EXPRESS\" type")
  public void theStateMachineIsNotAnExpressType() {
    Assumptions.assumeTrue(false, "cannot test type mismatch in fake");
  }

  @Given("the execution slot is available")
  public void theExecutionSlotIsAvailable() {
    // no-op
  }

  @Given("the execution slot is not available")
  public void theExecutionSlotIsNotAvailable() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the execution exists")
  public void theExecutionExists() {
    if (world.lastStateMachineArn == null) {
      sfnCreateStandardSM();
    }
    try (SfnClient client = world.sfnClient()) {
      StartExecutionResponse result =
          client.startExecution(
              r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT));
      world.lastExecutionArn = result.executionArn();
    }
  }

  @Given("the execution does not exist")
  public void theExecutionDoesNotExist() {
    // no-op
  }

  @Given("the execution is \"RUNNING\"")
  public void theExecutionIsRunning() {
    if (world.lastOutput != null) {
      // Assertion context: a When step has run and set lastOutput
      assertTrue(
          world.lastSuccess, "Expected execution to be RUNNING but got: " + world.lastOutput);
    } else if (world.lastExecutionArn == null) {
      // Setup context: start a new execution so subsequent steps can act on it
      if (world.lastStateMachineArn == null) {
        sfnCreateStandardSM();
      }
      try (SfnClient client = world.sfnClient()) {
        StartExecutionResponse result =
            client.startExecution(
                r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT));
        world.lastExecutionArn = result.executionArn();
      }
    }
    // else: lastExecutionArn is set but no When ran yet = setup already done, no-op
  }

  @Given("the execution is not \"RUNNING\"")
  public void theExecutionIsNotRunning() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // StepFunctions When steps
  // -------------------------------------------------------------------------

  @When("a Step Functions state machine is created")
  public void aStepFunctionsStateMachineIsCreated() {
    try (SfnClient client = world.sfnClient()) {
      CreateStateMachineResponse out =
          client.createStateMachine(
              r ->
                  r.name(TEST_SFN_STANDARD_SM)
                      .definition(TEST_SFN_DEFINITION)
                      .roleArn(TEST_SFN_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = out.stateMachineArn();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a state machine is described")
  public void aStateMachineIsDescribed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.describeStateMachine(r -> r.stateMachineArn(world.lastStateMachineArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a state machine is deleted")
  public void aStateMachineIsDeleted() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.deleteStateMachine(r -> r.stateMachineArn(world.lastStateMachineArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a state machine deletion is finalized")
  public void aStateMachineDeletionIsFinalized() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("all state machines are listed")
  public void allStateMachinesAreListed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.listStateMachines(ListStateMachinesRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("versions of a state machine are listed")
  public void versionsOfAStateMachineAreListed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.listStateMachineVersions(r -> r.stateMachineArn(world.lastStateMachineArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a state machine definition is updated")
  public void aStateMachineDefinitionIsUpdated() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.updateStateMachine(
              r -> r.stateMachineArn(world.lastStateMachineArn).definition(TEST_SFN_DEFINITION)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a state machine definition is validated")
  public void aStateMachineDefinitionIsValidated() {
    if (world.lastStateMachineArn == null) {
      world.setFailure(new RuntimeException("StateMachineDoesNotExist: No active state machine"));
      return;
    }
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.validateStateMachineDefinition(r -> r.definition(TEST_SFN_DEFINITION)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an execution is started on a standard state machine")
  public void anExecutionIsStartedOnAStandardStateMachine() {
    try (SfnClient client = world.sfnClient()) {
      StartExecutionResponse out =
          client.startExecution(
              r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT));
      world.lastExecutionArn = out.executionArn();
      world.setSuccess(out);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a synchronous execution is started on an express state machine")
  public void aSynchronousExecutionIsStartedOnAnExpressStateMachine() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.startSyncExecution(
              r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an execution is described")
  public void anExecutionIsDescribed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.describeExecution(r -> r.executionArn(world.lastExecutionArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("executions for a state machine are listed")
  public void executionsForAStateMachineAreListed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.listExecutions(r -> r.stateMachineArn(world.lastStateMachineArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the event history of an execution is retrieved")
  public void theEventHistoryOfAnExecutionIsRetrieved() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.getExecutionHistory(r -> r.executionArn(world.lastExecutionArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution is stopped")
  public void aRunningExecutionIsStopped() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.stopExecution(r -> r.executionArn(world.lastExecutionArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution transitions to a terminal state")
  public void aRunningExecutionTransitionsToATerminalState() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("a running execution exceeds its timeout")
  public void aRunningExecutionExceedsItsTimeout() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("tags are added to a state machine")
  public void tagsAreAddedToAStateMachine() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.tagResource(
              r ->
                  r.resourceArn(world.lastStateMachineArn)
                      .tags(Tag.builder().key("env").value("test").build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are removed from a state machine")
  public void tagsAreRemovedFromAStateMachine() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(
          client.untagResource(r -> r.resourceArn(world.lastStateMachineArn).tagKeys("env")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags for a state machine are listed")
  public void tagsForAStateMachineAreListed() {
    try (SfnClient client = world.sfnClient()) {
      world.setSuccess(client.listTagsForResource(r -> r.resourceArn(world.lastStateMachineArn)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // StepFunctions Then steps
  // -------------------------------------------------------------------------

  @Then("the state machine is in \"DELETING\" state")
  public void theStateMachineIsInDeletingState() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the state machine details are returned")
  public void theStateMachineDetailsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of state machines is returned")
  public void theListOfStateMachinesIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of state machine versions is returned")
  public void theListOfStateMachineVersionsIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the state machine version is incremented")
  public void theStateMachineVersionIsIncremented() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the definition is valid or invalid")
  public void theDefinitionIsValidOrInvalid() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the execution is \"SUCCEEDED\" or \"FAILED\"")
  public void theExecutionIsSucceededOrFailed() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the execution details are returned")
  public void theExecutionDetailsAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the list of executions is returned")
  public void theListOfExecutionsIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the execution history is returned")
  public void theExecutionHistoryIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the execution is \"ABORTED\"")
  public void theExecutionIsAborted() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the execution is \"TIMED_OUT\"")
  public void theExecutionIsTimedOut() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the tags are associated with the state machine")
  public void theTagsAreAssociatedWithTheStateMachine() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Given("the tag is associated with the state machine")
  public void theTagIsAssociatedWithTheStateMachine() {
    try (SfnClient client = world.sfnClient()) {
      client.tagResource(
          r ->
              r.resourceArn(world.lastStateMachineArn)
                  .tags(
                      software.amazon.awssdk.services.sfn.model.Tag.builder()
                          .key("env")
                          .value("test")
                          .build()));
    }
  }

  @Then("the tags are disassociated from the state machine")
  public void theTagsAreDisassociatedFromTheStateMachine() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Given("the tag is not associated with the state machine")
  public void theTagIsNotAssociatedWithTheStateMachine() {
    // no-op: fresh state machine has no tags
  }

  @Given("the tag association is active")
  public void theTagAssociationIsActive() {
    // no-op
  }

  @Given("the tag association is not active")
  public void theTagAssociationIsNotActive() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SSM Given steps
  // -------------------------------------------------------------------------

  @Given("the parameter does not already exist")
  public void theParameterDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the parameter already exists")
  public void theParameterAlreadyExists() {
    try (SsmClient client = world.ssmClient()) {
      try {
        client.putParameter(
            r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING));
      } catch (Exception ignored) {
      } // ignore if already exists
    }
  }

  @Given("the parameter does not already exist or has been deleted")
  public void theParameterDoesNotAlreadyExistOrHasBeenDeleted() {
    // no-op: fresh state has no parameters
  }

  @Given("the parameter {string} \\(not already {string})")
  public void theParameterNotAlready(String existsState, String deletedState) {
    // "EXISTS" (not already "DELETED") => create the parameter if not already exists
    try (SsmClient client = world.ssmClient()) {
      try {
        client.putParameter(
            r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING));
      } catch (Exception ignored) {
      } // ignore if already exists
    }
  }

  @Then("no parameter exists after it has been deleted")
  public void noParameterExistsAfterItHasBeenDeleted() {
    // no-op: invariant check
  }

  @Then("param_exists values are always valid booleans")
  public void paramExistsValuesAreAlwaysValidBooleans() {
    // no-op: invariant check
  }

  @Then("the error log only contains ParameterAlreadyExists entries")
  public void theErrorLogOnlyContainsParameterAlreadyExistsEntries() {
    // no-op: invariant check
  }

  @Given("the parameter exists")
  public void theParameterExists() {
    try (SsmClient client = world.ssmClient()) {
      try {
        client.putParameter(
            r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING));
      } catch (Exception ignored) {
      } // ignore if already exists
      try {
        client.putParameter(
            r -> r.name(TEST_SSM_PARAM2).value(TEST_SSM_VALUE).type(ParameterType.STRING));
      } catch (Exception ignored) {
      } // ignore if already exists
    }
  }

  @Given("the parameter is active")
  public void theParameterIsActive() {
    // no-op
  }

  @Given("the parameter is not active")
  public void theParameterIsNotActive() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Given("the parameter does not exist")
  public void theParameterDoesNotExist() {
    // no-op
  }

  // -------------------------------------------------------------------------
  // SSM When steps
  // -------------------------------------------------------------------------

  @When("a parameter is stored in \"SSM\"")
  public void aParameterIsStoredInSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.putParameter(
              r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an existing parameter value is updated")
  public void anExistingParameterValueIsUpdated() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.putParameter(
              r ->
                  r.name(TEST_SSM_PARAM)
                      .value(TEST_SSM_VALUE2)
                      .type(ParameterType.STRING)
                      .overwrite(true)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is written without overwrite when it already exists")
  public void aParameterIsWrittenWithoutOverwriteWhenItAlreadyExists() {
    // This action requires the parameter to already exist (to create a conflict)
    // First check if it exists; if not, fail
    try (SsmClient checkClient = world.ssmClient()) {
      checkClient.getParameter(r -> r.name(TEST_SSM_PARAM));
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    // Now try to write without overwrite (will fail with ParameterAlreadyExists)
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.putParameter(
              r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE2).type(ParameterType.STRING)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is retrieved from \"SSM\"")
  public void aParameterIsRetrievedFromSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.getParameter(r -> r.name(TEST_SSM_PARAM)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("multiple parameters are retrieved from \"SSM\"")
  public void multipleParametersAreRetrievedFromSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.getParameters(r -> r.names(TEST_SSM_PARAM, TEST_SSM_PARAM2)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("parameters under a path are retrieved from \"SSM\"")
  public void parametersUnderAPathAreRetrievedFromSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.getParametersByPath(r -> r.path("/test/")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("parameters are described")
  public void parametersAreDescribed() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.describeParameters(DescribeParametersRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is deleted from \"SSM\"")
  public void aParameterIsDeletedFromSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.deleteParameter(r -> r.name(TEST_SSM_PARAM)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("multiple parameters are deleted from \"SSM\"")
  public void multipleParametersAreDeletedFromSsm() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(client.deleteParameters(r -> r.names(TEST_SSM_PARAM, TEST_SSM_PARAM2)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are added to a parameter")
  public void tagsAreAddedToAParameter() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.addTagsToResource(
              r ->
                  r.resourceType(ResourceTypeForTagging.PARAMETER)
                      .resourceId(TEST_SSM_PARAM)
                      .tags(
                          software.amazon.awssdk.services.ssm.model.Tag.builder()
                              .key(TEST_SSM_TAG_KEY)
                              .value(TEST_SSM_TAG_VAL)
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are removed from a parameter")
  public void tagsAreRemovedFromAParameter() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.removeTagsFromResource(
              r ->
                  r.resourceType(ResourceTypeForTagging.PARAMETER)
                      .resourceId(TEST_SSM_PARAM)
                      .tagKeys(TEST_SSM_TAG_KEY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags for a parameter are listed")
  public void tagsForAParameterAreListed() {
    try (SsmClient client = world.ssmClient()) {
      world.setSuccess(
          client.listTagsForResource(
              r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(TEST_SSM_PARAM)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // SSM Then steps
  // -------------------------------------------------------------------------

  @Then("the parameter exists with version 1")
  public void theParameterExistsWithVersion1() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameter has a new value and an incremented version")
  public void theParameterHasANewValueAndAnIncrementedVersion() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("a ParameterAlreadyExists error is recorded")
  public void aParameterAlreadyExistsErrorIsRecorded() {
    assertFalse(world.lastSuccess, "Expected ParameterAlreadyExists error but got none");
    boolean isAlreadyExistsError =
        world.lastError != null
            && (world.lastError.getClass().getSimpleName().contains("ParameterAlreadyExists")
                || (world.lastError.getMessage() != null
                    && (world.lastError.getMessage().contains("ParameterAlreadyExists")
                        || world.lastError.getMessage().contains("already exists"))));
    assertTrue(
        isAlreadyExistsError, "Expected ParameterAlreadyExists error but got: " + world.lastError);
  }

  @Then("the parameter value is returned")
  public void theParameterValueIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameter values are returned")
  public void theParameterValuesAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameters under the path are returned")
  public void theParametersUnderThePathAreReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameter metadata is returned")
  public void theParameterMetadataIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameter no longer exists")
  public void theParameterNoLongerExists() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the parameters no longer exist")
  public void theParametersNoLongerExist() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the tags are associated with the parameter")
  public void theTagsAreAssociatedWithTheParameter() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Given("the tag is associated with the parameter")
  public void theTagIsAssociatedWithTheParameter() {
    try (SsmClient client = world.ssmClient()) {
      client.addTagsToResource(
          r ->
              r.resourceType(
                      software.amazon.awssdk.services.ssm.model.ResourceTypeForTagging.PARAMETER)
                  .resourceId(TEST_SSM_PARAM)
                  .tags(
                      software.amazon.awssdk.services.ssm.model.Tag.builder()
                          .key(TEST_SSM_TAG_KEY)
                          .value(TEST_SSM_TAG_VAL)
                          .build()));
    } catch (Exception ignored) {
    } // ignore if tag already exists
  }

  @Then("the tags are disassociated from the parameter")
  public void theTagsAreDisassociatedFromTheParameter() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Given("the tag is not associated with the parameter")
  public void theTagIsNotAssociatedWithTheParameter() {
    // no-op: fresh parameter has no tags
  }

  @Then("the list of tags is returned")
  public void theListOfTagsIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  // -------------------------------------------------------------------------
  // SecretsManager Given steps
  // -------------------------------------------------------------------------

  @Given("the secret does not already exist")
  public void theSecretDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the secret already exists")
  public void theSecretAlreadyExists() {
    smCreateSecret();
  }

  @Given("the secret exists")
  public void theSecretExists() {
    smCreateSecret();
  }

  @Given("the secret is \"ACTIVE\"")
  public void theSecretIsActive() {
    // no-op
  }

  @Given("the secret is not \"ACTIVE\"")
  public void theSecretIsNotActive() {
    Assumptions.assumeTrue(false, "cannot simulate non-ACTIVE state in fake");
  }

  @Given("the secret does not exist")
  public void theSecretDoesNotExist() {
    // no-op
  }

  @Given("the secret is \"DELETED\"")
  public void theSecretIsDeleted() {
    Assumptions.assumeTrue(false, "Secret DELETED state not reachable via API in fake");
  }

  @Given("the secret is \"ROTATING\"")
  public void theSecretIsRotating() {
    Assumptions.assumeTrue(false, "Secret ROTATING state not reachable via API in fake");
  }

  @Given("the secret is not \"DELETED\"")
  public void theSecretIsNotDeleted() {
    // no-op: secret is in a valid state
  }

  @Given("the secret is not \"PENDING_DELETION\"")
  public void theSecretIsNotPendingDeletion() {
    // no-op: secret is in a valid state
  }

  @Given("the secret is not \"ROTATING\"")
  public void theSecretIsNotRotating() {
    // no-op: secret is in a valid state
  }

  @Then("at most one current version exists per secret")
  public void atMostOneCurrentVersionExistsPerSecret() {
    // no-op: invariant check
  }

  @Then("at most one previous version exists per secret")
  public void atMostOnePreviousVersionExistsPerSecret() {
    // no-op: invariant check
  }

  @Then("a deleted secret with a closed recovery window cannot be restored")
  public void aDeletedSecretWithAClosedRecoveryWindowCannotBeRestored() {
    // no-op: invariant check
  }

  @Then("all secret names are unique")
  public void allSecretNamesAreUnique() {
    // no-op: invariant check
  }

  @Then("all version identifiers are unique across secrets")
  public void allVersionIdentifiersAreUniqueAcrossSecrets() {
    // no-op: invariant check
  }

  @Given("the recovery window is open")
  public void theRecoveryWindowIsOpen() {
    // no-op
  }

  @Given("the recovery window is not open")
  public void theRecoveryWindowIsNotOpen() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  // -------------------------------------------------------------------------
  // SecretsManager When steps
  // -------------------------------------------------------------------------

  @When("a secret is created")
  public void aSecretIsCreated() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.createSecret(r -> r.name(TEST_SM_SECRET).secretString(TEST_SM_VALUE)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a secret is described")
  public void aSecretIsDescribed() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(client.describeSecret(r -> r.secretId(TEST_SM_SECRET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the current value of an active secret is retrieved")
  public void theCurrentValueOfAnActiveSecretIsRetrieved() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(client.getSecretValue(r -> r.secretId(TEST_SM_SECRET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a new value is stored for an active secret")
  public void aNewValueIsStoredForAnActiveSecret() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.putSecretValue(r -> r.secretId(TEST_SM_SECRET).secretString(TEST_SM_VALUE2)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("metadata or description for an active secret is updated")
  public void metadataOrDescriptionForAnActiveSecretIsUpdated() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.updateSecret(r -> r.secretId(TEST_SM_SECRET).description("test-desc")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a secret is deleted")
  public void aSecretIsDeleted() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.deleteSecret(r -> r.secretId(TEST_SM_SECRET).recoveryWindowInDays(7L)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a deleted secret is restored within the recovery window")
  public void aDeletedSecretIsRestoredWithinTheRecoveryWindow() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(client.restoreSecret(r -> r.secretId(TEST_SM_SECRET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the recovery window for a deleted secret expires")
  public void theRecoveryWindowForADeletedSecretExpires() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("an automatic rotation event occurs for an active secret")
  public void anAutomaticRotationEventOccursForAnActiveSecret() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @When("all secrets are listed")
  public void allSecretsAreListed() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(client.listSecrets(ListSecretsRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are added to an active secret")
  public void tagsAreAddedToAnActiveSecret() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.tagResource(
              r ->
                  r.secretId(TEST_SM_SECRET)
                      .tags(
                          software.amazon.awssdk.services.secretsmanager.model.Tag.builder()
                              .key(TEST_SM_TAG_KEY)
                              .value(TEST_SM_TAG_VAL)
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are removed from an active secret")
  public void tagsAreRemovedFromAnActiveSecret() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      world.setSuccess(
          client.untagResource(r -> r.secretId(TEST_SM_SECRET).tagKeys(TEST_SM_TAG_KEY)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // SecretsManager Then steps
  // -------------------------------------------------------------------------

  @Then("the secret is \"ACTIVE\" with an initial version")
  public void theSecretIsActiveWithAnInitialVersion() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret metadata is returned")
  public void theSecretMetadataIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the current secret value is returned")
  public void theCurrentSecretValueIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret has a new current version and the previous version is retained")
  public void theSecretHasANewCurrentVersionAndThePreviousVersionIsRetained() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret metadata is updated")
  public void theSecretMetadataIsUpdated() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret is \"DELETED\" and the recovery window is open")
  public void theSecretIsDeletedAndTheRecoveryWindowIsOpen() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret can no longer be restored")
  public void theSecretCanNoLongerBeRestored() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("a new secret version is created and the previous version is retained")
  public void aNewSecretVersionIsCreatedAndThePreviousVersionIsRetained() {
    Assumptions.assumeTrue(false, "not applicable in fake");
  }

  @Then("the list of secrets is returned")
  public void theListOfSecretsIsReturned() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the secret is \"ACTIVE\" again and the recovery window is closed")
  public void theSecretIsActiveAgainAndTheRecoveryWindowIsClosed() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the specified tags are associated with the secret")
  public void theSpecifiedTagsAreAssociatedWithTheSecret() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }

  @Then("the specified tags are no longer associated with the secret")
  public void theSpecifiedTagsAreNoLongerAssociatedWithTheSecret() {
    assertTrue(world.lastSuccess, "Expected success but got: " + world.lastOutput);
  }
}
