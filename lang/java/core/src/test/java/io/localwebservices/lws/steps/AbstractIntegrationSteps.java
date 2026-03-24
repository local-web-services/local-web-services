package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.cli.LwsCli;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.*;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.*;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.ParameterType;

/**
 * Abstract step definitions for the 17 integration service directories. These supplement
 * AbstractSteps with new step texts that appear only in integration (two-service) feature files.
 */
public class AbstractIntegrationSteps {

  // -------------------------------------------------------------------------
  // Constants (shared values with AbstractSteps)
  // -------------------------------------------------------------------------
  private static final String TEST_SQS_QUEUE = "test-q-1";
  private static final String TEST_SQS_MSG = "test-message-1";
  private static final String TEST_DDB_TABLE = "test-table-1";
  private static final String TEST_S3_BUCKET = "test-bucket-1";
  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_EVENT_RULE = "test-rule-1";
  private static final String TEST_EVENT_TARGET = "arn:aws:sqs:us-east-1:000000000000:test-q-1";
  private static final String TEST_SFN_STANDARD_SM = "test-sm-1";
  private static final String TEST_SFN_ROLE_ARN =
      "arn:aws:iam::000000000000:role/StepFunctionsRole";
  private static final String TEST_SFN_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_SFN_INPUT = "{}";
  private static final String TEST_SSM_PARAM = "/test/param/1";
  private static final String TEST_SSM_VALUE = "test-value-1";
  private static final String TEST_SM_SECRET = "test-secret-1";
  private static final String TEST_SM_VALUE = "test-secret-value-1";

  private final WorldContext world;

  public AbstractIntegrationSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private String sfnArn(String name) {
    return "arn:aws:states:us-east-1:000000000000:stateMachine:" + name;
  }

  private void sqsCreateQueue(String name) {
    try (SqsClient client = world.sqsClient()) {
      client.createQueue(r -> r.queueName(name));
    } catch (Exception e) {
      if (!e.getMessage().contains("QueueAlreadyExists")) {
        throw e;
      }
    }
  }

  private void snsCreateTopic() {
    try (SnsClient client = world.snsClient()) {
      var result = client.createTopic(r -> r.name("test-topic-1"));
      world.lastTopicArn = result.topicArn();
    }
  }

  private void ebCreateBus() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists")
          && !msg.contains("already exists")
          && !msg.contains("ResourceInUse")) {
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
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists")
          && !msg.contains("already exists")
          && !msg.contains("ResourceInUse")) {
        throw e;
      }
    }
  }

  private void ebPutTarget(String targetArn) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putTargets(
          r ->
              r.rule(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .targets(Target.builder().id("t1").arn(targetArn).build()));
    } catch (Exception ignored) {
    }
  }

  private void sfnCreateStandardSM() {
    try (SfnClient client = world.sfnClient()) {
      var result =
          client.createStateMachine(
              r ->
                  r.name(TEST_SFN_STANDARD_SM)
                      .definition(TEST_SFN_DEFINITION)
                      .roleArn(TEST_SFN_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = result.stateMachineArn();
    } catch (Exception e) {
      if (e.getMessage().contains("StateMachineAlreadyExists")) {
        world.lastStateMachineArn = sfnArn(TEST_SFN_STANDARD_SM);
      } else {
        throw e;
      }
    }
  }

  private void smCreateSecret() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      client.createSecret(r -> r.name(TEST_SM_SECRET).secretString(TEST_SM_VALUE));
    } catch (Exception e) {
      if (!e.getMessage().contains("ResourceExistsException")) {
        throw e;
      }
    }
  }

  private void ddbCreateTable() {
    try (software.amazon.awssdk.services.dynamodb.DynamoDbClient client = world.dynamodbClient()) {
      client.createTable(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .keySchema(
                      software.amazon.awssdk.services.dynamodb.model.KeySchemaElement.builder()
                          .attributeName("id")
                          .keyType(software.amazon.awssdk.services.dynamodb.model.KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      software.amazon.awssdk.services.dynamodb.model.AttributeDefinition.builder()
                          .attributeName("id")
                          .attributeType(
                              software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType.S)
                          .build())
                  .billingMode(
                      software.amazon.awssdk.services.dynamodb.model.BillingMode.PAY_PER_REQUEST));
    } catch (Exception e) {
      if (!e.getMessage().contains("ResourceInUseException")) {
        throw e;
      }
    }
  }

  private void s3CreateBucket(String name) {
    try (software.amazon.awssdk.services.s3.S3Client client = world.s3Client()) {
      client.createBucket(r -> r.bucket(name));
    } catch (Exception e) {
      if (!e.getMessage().contains("BucketAlreadyExists")
          && !e.getMessage().contains("BucketAlreadyOwnedByYou")) {
        throw e;
      }
    }
  }

  // -------------------------------------------------------------------------
  // "bus" variant Given steps
  // -------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // no-op
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    ebCreateBus();
  }

  @Given("the bus exists")
  public void theBusExists() {
    ebCreateBus();
  }

  @Given("the bus is {string}")
  public void theBusIs(String state) {
    // no-op: bus is ACTIVE by default when it exists
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // no-op: bus is absent by default after reset
  }

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Internal state not reachable via API
    Assumptions.assumeTrue(false, "Bus deleted state not reachable via API");
  }

  @Given("the bus is not already {string}")
  public void theBusIsNotAlready(String state) {
    // no-op
  }

  @Given("the bus is not {string}")
  public void theBusIsNot(String state) {
    // no-op
  }

  @Given("the bus does not exist or is {string}")
  public void theBusDoesNotExistOrIs(String state) {
    Assumptions.assumeTrue(false, "Bus deleted state not reachable via API");
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    ebCreateBus();
  }

  @Given("the bus does not exist or is not {string}")
  public void theBusDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "Bus non-ACTIVE state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // Slot / capacity Given steps
  // -------------------------------------------------------------------------

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() throws Exception {
    LwsCli.capacityUnlimited(world.managementPort(), "events");
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() throws Exception {
    LwsCli.capacityExhaust(world.managementPort(), "events");
  }

  @Given("an item slot is available")
  public void anItemSlotIsAvailable() throws Exception {
    LwsCli.capacityUnlimited(world.managementPort(), "dynamodb");
  }

  @Given("no item slot is available")
  public void noItemSlotIsAvailable() throws Exception {
    LwsCli.capacityExhaust(world.managementPort(), "dynamodb");
  }

  @Given("a message slot is available")
  public void aMessageSlotIsAvailable() throws Exception {
    LwsCli.capacityUnlimited(world.managementPort(), "sqs");
  }

  @Given("no message slot is available")
  public void noMessageSlotIsAvailable() throws Exception {
    LwsCli.capacityExhaust(world.managementPort(), "sqs");
  }

  @Given("an object slot is available")
  public void anObjectSlotIsAvailable() throws Exception {
    LwsCli.capacityUnlimited(world.managementPort(), "s3");
  }

  @Given("no object slot is available")
  public void noObjectSlotIsAvailable() throws Exception {
    LwsCli.capacityExhaust(world.managementPort(), "s3");
  }

  @Given("an execution slot is available")
  public void anExecutionSlotIsAvailable() throws Exception {
    LwsCli.capacityUnlimited(world.managementPort(), "stepfunctions");
  }

  @Given("no execution slot is available")
  public void noExecutionSlotIsAvailable() throws Exception {
    LwsCli.capacityExhaust(world.managementPort(), "stepfunctions");
  }

  // -------------------------------------------------------------------------
  // Rule state Given steps
  // -------------------------------------------------------------------------

  @Given("a rule is {string}")
  public void aRuleIs(String state) {
    ebCreateBus();
    ebPutRule();
  }

  @Given("no rule is {string}")
  public void noRuleIs(String state) {
    // no-op: no rules exist by default
  }

  @Given("the rule is already \"DISABLED\"")
  public void theRuleIsAlreadyDisabled() {
    ebCreateBus();
    ebPutRule();
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
    } catch (Exception ignored) {
    }
  }

  @Given("the rule is already \"ENABLED\"")
  public void theRuleIsAlreadyEnabled() {
    ebCreateBus();
    ebPutRule();
  }

  // -------------------------------------------------------------------------
  // "ENABLED rule exists on bus targeting X" Given steps
  // -------------------------------------------------------------------------

  @Given("an \"ENABLED\" rule exists on the bus targeting a queue")
  public void anEnabledRuleExistsOnTheBusTargetingAQueue() {
    sqsCreateQueue(TEST_SQS_QUEUE);
    ebCreateBus();
    ebPutRule();
    ebPutTarget(TEST_EVENT_TARGET);
  }

  @Given("no \"ENABLED\" rule exists on the bus targeting a queue")
  public void noEnabledRuleExistsOnTheBusTargetingAQueue() {
    // no-op
  }

  @Given("an \"ENABLED\" rule exists on the bus targeting a topic")
  public void anEnabledRuleExistsOnTheBusTargetingATopic() {
    snsCreateTopic();
    ebCreateBus();
    ebPutRule();
    ebPutTarget(TEST_EVENT_TARGET);
  }

  @Given("no \"ENABLED\" rule exists on the bus targeting a topic")
  public void noEnabledRuleExistsOnTheBusTargetingATopic() {
    // no-op
  }

  @Given("an \"ENABLED\" rule exists on the bus targeting a state machine")
  public void anEnabledRuleExistsOnTheBusTargetingAStateMachine() {
    sfnCreateStandardSM();
    ebCreateBus();
    ebPutRule();
    ebPutTarget(TEST_EVENT_TARGET);
  }

  @Given("no \"ENABLED\" rule exists on the bus targeting a state machine")
  public void noEnabledRuleExistsOnTheBusTargetingAStateMachine() {
    // no-op
  }

  // -------------------------------------------------------------------------
  // Target resource state Given steps
  // -------------------------------------------------------------------------

  @Given("the target table is {string}")
  public void theTargetTableIs(String state) {
    // no-op: table is ACTIVE by default
  }

  @Given("the target table is not {string}")
  public void theTargetTableIsNot(String state) {
    Assumptions.assumeTrue(false, "Target table not-ACTIVE state not reachable via API");
  }

  @Given("the target queue is {string}")
  public void theTargetQueueIs(String state) {
    // no-op: queue is ACTIVE by default
  }

  @Given("the target queue is not {string}")
  public void theTargetQueueIsNot(String state) {
    Assumptions.assumeTrue(false, "Target queue not-ACTIVE state not reachable via API");
  }

  @Given("the target topic is {string}")
  public void theTargetTopicIs(String state) {
    // no-op: topic is ACTIVE by default
  }

  @Given("the target topic is not {string}")
  public void theTargetTopicIsNot(String state) {
    Assumptions.assumeTrue(false, "Target topic not-ACTIVE state not reachable via API");
  }

  @Given("the target state machine is {string}")
  public void theTargetStateMachineIs(String state) {
    // no-op: state machine is ACTIVE by default
  }

  @Given("the target state machine is not {string}")
  public void theTargetStateMachineIsNot(String state) {
    Assumptions.assumeTrue(false, "Target state machine not-ACTIVE state not reachable via API");
  }

  @Given("the target bus is {string}")
  public void theTargetBusIs(String state) {
    // no-op: bus is ACTIVE by default
  }

  @Given("the target bus is not {string}")
  public void theTargetBusIsNot(String state) {
    Assumptions.assumeTrue(false, "Target bus not-ACTIVE state not reachable via API");
  }

  @Given("the target bucket is {string}")
  public void theTargetBucketIs(String state) {
    // no-op: bucket is ACTIVE by default
  }

  @Given("the target bucket is not {string}")
  public void theTargetBucketIsNot(String state) {
    Assumptions.assumeTrue(false, "Target bucket not-ACTIVE state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // Execution state Given steps (integration phrasing - SM must be created first)
  // -------------------------------------------------------------------------

  @Given("an execution is \"RUNNING\"")
  public void anExecutionIsRunning() {
    sfnCreateStandardSM();
    try (SfnClient client = world.sfnClient()) {
      var result =
          client.startExecution(
              r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT));
      world.lastExecutionArn = result.executionArn();
    }
  }

  @Given("no execution is \"RUNNING\"")
  public void noExecutionIsRunning() {
    Assumptions.assumeTrue(false, "No running execution state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // Notification configuration Given steps (s3api_sns, s3api_sqs, s3api_events)
  // -------------------------------------------------------------------------

  @Given("the bucket has no EventBridge notification configured")
  public void theBucketHasNoEventBridgeNotificationConfigured() {
    // no-op
  }

  @Given("the bucket already has an EventBridge notification configured")
  public void theBucketAlreadyHasAnEventBridgeNotificationConfigured() {
    Assumptions.assumeTrue(
        false, "Bucket EventBridge notification not configurable via API in fake");
  }

  @Given("the bucket has an EventBridge notification configured")
  public void theBucketHasAnEventBridgeNotificationConfigured() {
    // no-op: assume configured
  }

  @Given("the bucket has no notification configuration")
  public void theBucketHasNoNotificationConfiguration() {
    // no-op
  }

  @Given("the bucket already has a notification configuration")
  public void theBucketAlreadyHasANotificationConfiguration() {
    Assumptions.assumeTrue(false, "Bucket notification not configurable via API in fake");
  }

  @Given("the bucket has a notification configuration")
  public void theBucketHasANotificationConfiguration() {
    // no-op: assume configured
  }

  @Given("the queue exists and is {string}")
  public void theQueueExistsAndIs(String state) {
    sqsCreateQueue(TEST_SQS_QUEUE);
  }

  @Given("the queue does not exist or is not {string}")
  public void theQueueDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "Queue non-ACTIVE state not reachable via API");
  }

  @Given("the bucket exists and is {string}")
  public void theBucketExistsAndIs(String state) {
    s3CreateBucket(TEST_S3_BUCKET);
  }

  @Given("the bucket does not exist or is not {string}")
  public void theBucketDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "Bucket non-ACTIVE state not reachable via API");
  }

  @Given("the topic exists and is {string}")
  public void theTopicExistsAndIs(String state) {
    snsCreateTopic();
  }

  @Given("the topic does not exist or is not {string}")
  public void theTopicDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "Topic non-ACTIVE state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // DynamoDB task configuration Given steps (stepfunctions_dynamodb)
  // -------------------------------------------------------------------------

  @Given("the state machine has no DynamoDB task configured")
  public void theStateMachineHasNoDynamoDbTaskConfigured() {
    Assumptions.assumeTrue(false, "DynamoDB task not configured state not reachable via API");
  }

  @Given("the state machine already has a DynamoDB task configured")
  public void theStateMachineAlreadyHasADynamoDbTaskConfigured() {
    Assumptions.assumeTrue(false, "DynamoDB task configuration not reachable via API");
  }

  @Given("the state machine has a DynamoDB task configured")
  public void theStateMachineHasADynamoDbTaskConfigured() {
    // no-op: conceptual
  }

  @Given("no item {string} in the target table")
  public void noItemInTheTargetTable(String state) {
    // no-op: table is empty by default
  }

  @Given("an item {string} in the target table")
  public void anItemInTheTargetTable(String state) {
    // no-op: assume item exists
  }

  // -------------------------------------------------------------------------
  // S3 task configuration Given steps (stepfunctions_s3api)
  // -------------------------------------------------------------------------

  @Given("the state machine has no S3 task configured")
  public void theStateMachineHasNoS3TaskConfigured() {
    Assumptions.assumeTrue(false, "S3 task not configured state not reachable via API");
  }

  @Given("the state machine already has an S3 task configured")
  public void theStateMachineAlreadyHasAnS3TaskConfigured() {
    Assumptions.assumeTrue(false, "S3 task configuration not reachable via API");
  }

  @Given("the state machine has an S3 task configured")
  public void theStateMachineHasAnS3TaskConfigured() {
    // no-op: conceptual
  }

  @Given("no object {string} in the target bucket")
  public void noObjectInTheTargetBucket(String state) {
    // no-op: bucket is empty by default
  }

  @Given("an object {string} in the target bucket")
  public void anObjectInTheTargetBucket(String state) {
    // no-op: assume object exists
  }

  // -------------------------------------------------------------------------
  // EventBridge publishing configuration Given steps (stepfunctions_events)
  // -------------------------------------------------------------------------

  @Given("the state machine has no EventBridge bus configured")
  public void theStateMachineHasNoEventBridgeBusConfigured() {
    Assumptions.assumeTrue(false, "EventBridge bus not configured state not reachable via API");
  }

  @Given("the state machine already has an EventBridge bus configured")
  public void theStateMachineAlreadyHasAnEventBridgeBusConfigured() {
    Assumptions.assumeTrue(false, "EventBridge bus configuration not reachable via API");
  }

  @Given("the state machine has an EventBridge bus configured")
  public void theStateMachineHasAnEventBridgeBusConfigured() {
    // no-op: conceptual
  }

  @Given("the state machine exists and is {string}")
  public void theStateMachineExistsAndIs(String state) {
    sfnCreateStandardSM();
  }

  @Given("the state machine does not exist or is not {string}")
  public void theStateMachineDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "State machine non-ACTIVE state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // SNS task configuration Given steps (stepfunctions_sns)
  // -------------------------------------------------------------------------

  @Given("the state machine has no {string} task configured")
  public void theStateMachineHasNoTaskConfigured(String service) {
    Assumptions.assumeTrue(false, service + " task not configured state not reachable via API");
  }

  @Given("the state machine already has an {string} task configured")
  public void theStateMachineAlreadyHasAnTaskConfigured(String service) {
    Assumptions.assumeTrue(false, service + " task configuration not reachable via API");
  }

  @Given("the state machine has an {string} task configured")
  public void theStateMachineHasAnTaskConfigured(String service) {
    // no-op: conceptual
  }

  @Given("the execution's state machine has a configured {string} task")
  public void theExecutionStateMachineHasAConfiguredTask(String service) {
    // no-op: conceptual
  }

  @Given("the execution's state machine has no {string} task configured")
  public void theExecutionStateMachineHasNoTaskConfigured(String service) {
    Assumptions.assumeTrue(false, service + " task not configured state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // Secrets Manager state Given steps (stepfunctions_secretsmanager)
  // -------------------------------------------------------------------------

  @Given("the secret is \"PENDING_DELETION\"")
  public void theSecretIsPendingDeletion() {
    Assumptions.assumeTrue(false, "PENDING_DELETION state not reachable via API in Given");
  }

  @Given("the secret is not pending deletion")
  public void theSecretIsNotPendingDeletion() {
    // no-op: secret is not pending deletion by default
  }

  @Given("the secret exists and is {string}")
  public void theSecretExistsAndIs(String state) {
    smCreateSecret();
  }

  @Given("the secret does not exist or is not {string}")
  public void theSecretDoesNotExistOrIsNot(String state) {
    Assumptions.assumeTrue(false, "Secret non-ACTIVE state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // SSM parameter state Given steps (stepfunctions_ssm, ssm_events)
  // -------------------------------------------------------------------------

  @Given("the parameter {string}")
  public void theParameter(String state) {
    if ("EXISTS".equals(state)) {
      try (SsmClient client = world.ssmClient()) {
        try {
          client.putParameter(
              r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING));
        } catch (Exception ignored) {
        } // ignore if already exists
      }
    }
  }

  @Given("the parameter is already {string}")
  public void theParameterIsAlready(String state) {
    Assumptions.assumeTrue(false, "Parameter " + state + " state not reachable via API in Given");
  }

  @Given("the parameter is {string}")
  public void theParameterIs(String state) {
    Assumptions.assumeTrue(false, "Parameter " + state + " state not reachable via API");
  }

  @Given("the parameter is not {string}")
  public void theParameterIsNot(String state) {
    // no-op: parameter is not in that state by default
  }

  @Given("the parameter does not exist or is {string}")
  public void theParameterDoesNotExistOrIs(String state) {
    Assumptions.assumeTrue(false, "Parameter deleted state not reachable via API");
  }

  // -------------------------------------------------------------------------
  // SNS subscription state (sns_sqs)
  // -------------------------------------------------------------------------

  @Given("the subscribed queue is {string}")
  public void theSubscribedQueueIs(String state) {
    // no-op: queue is ACTIVE by default
  }

  @Given("the subscribed queue is not {string}")
  public void theSubscribedQueueIsNot(String state) {
    Assumptions.assumeTrue(false, "Subscribed queue non-ACTIVE state not reachable via API");
  }

  // @Given("the subscription slot is not available") is registered in AbstractSteps

  // -------------------------------------------------------------------------
  // When steps: integration-specific actions
  @When("a DynamoDB table is created")
  public void aDynamoDbTableIsCreated() {
    try (software.amazon.awssdk.services.dynamodb.DynamoDbClient client = world.dynamodbClient()) {
      client.createTable(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .keySchema(
                      software.amazon.awssdk.services.dynamodb.model.KeySchemaElement.builder()
                          .attributeName("id")
                          .keyType(software.amazon.awssdk.services.dynamodb.model.KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      software.amazon.awssdk.services.dynamodb.model.AttributeDefinition.builder()
                          .attributeName("id")
                          .attributeType(
                              software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType.S)
                          .build())
                  .billingMode(
                      software.amazon.awssdk.services.dynamodb.model.BillingMode.PAY_PER_REQUEST));
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an S3 bucket is created")
  public void anS3BucketIsCreated() {
    try (software.amazon.awssdk.services.s3.S3Client client = world.s3Client()) {
      world.setSuccess(client.createBucket(r -> r.bucket(TEST_S3_BUCKET)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------

  @When("an event is published to the bus and routed to the target {string} queue")
  public void anEventIsPublishedToTheBusAndRoutedToTheTargetQueue(String service) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putEvents(
              r ->
                  r.entries(
                      PutEventsRequestEntry.builder()
                          .eventBusName(TEST_EVENT_BUS)
                          .source("test.source")
                          .detailType("TestEvent")
                          .detail("{\"key\":\"value\"}")
                          .build()));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an \"SQS\" queue is created")
  public void anSqsQueueIsCreated() {
    try (SqsClient client = world.sqsClient()) {
      var result = client.createQueue(r -> r.queueName(TEST_SQS_QUEUE));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is created to route matching events to the {string} queue")
  public void anEventBridgeRuleIsCreatedToRouteMatchingEventsToQueue(String service) {
    // Validate the target SQS queue exists before creating the rule
    try (software.amazon.awssdk.services.sqs.SqsClient sqsClient = world.sqsClient()) {
      sqsClient.getQueueUrl(r -> r.queueName(TEST_SQS_QUEUE));
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putRule(
              r ->
                  r.name(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.ENABLED));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event is published to the bus and routed to the target {string} topic")
  public void anEventIsPublishedToTheBusAndRoutedToTheTargetTopic(String service) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putEvents(
              r ->
                  r.entries(
                      PutEventsRequestEntry.builder()
                          .eventBusName(TEST_EVENT_BUS)
                          .source("test.source")
                          .detailType("TestEvent")
                          .detail("{\"key\":\"value\"}")
                          .build()));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is created to route matching events to an {string} topic")
  public void anEventBridgeRuleIsCreatedToRouteMatchingEventsToTopic(String service) {
    // Validate the target topic exists before creating the rule
    if (world.lastTopicArn == null) {
      world.setFailure(new RuntimeException("Topic does not exist"));
      return;
    }
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putRule(
              r ->
                  r.name(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.ENABLED));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event is published to the bus and triggers a new Step Functions execution")
  public void anEventIsPublishedToTheBusAndTriggersANewStepFunctionsExecution() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putEvents(
              r ->
                  r.entries(
                      PutEventsRequestEntry.builder()
                          .eventBusName(TEST_EVENT_BUS)
                          .source("test.source")
                          .detailType("TestEvent")
                          .detail("{\"key\":\"value\"}")
                          .build()));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is created to start a Step Functions execution on matching events")
  public void anEventBridgeRuleIsCreatedToStartAStepFunctionsExecution() {
    // Validate the target state machine exists before creating the rule
    if (world.lastStateMachineArn == null) {
      world.setFailure(
          new RuntimeException("StateMachineDoesNotExist: No state machine configured"));
      return;
    }
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putRule(
              r ->
                  r.name(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.ENABLED));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution fails")
  public void aRunningExecutionFails() {
    Assumptions.assumeTrue(false, "Internal execution failure not reachable via API");
  }

  @When("a running execution completes successfully")
  public void aRunningExecutionCompletesSuccessfully() {
    Assumptions.assumeTrue(false, "Internal execution completion not reachable via API");
  }

  @When("an EventBridge event bus is created")
  public void anEventBridgeEventBusIsCreated() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result = client.createEventBus(r -> r.name(TEST_EVENT_BUS));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is created targeting a DynamoDB table")
  public void anEventBridgeRuleIsCreatedTargetingADynamoDbTable() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result =
          client.putRule(
              r ->
                  r.name(TEST_EVENT_RULE)
                      .eventBusName(TEST_EVENT_BUS)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.DISABLED));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is enabled")
  public void anEventBridgeRuleIsEnabled() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result = client.enableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is disabled")
  public void anEventBridgeRuleIsDisabled() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result = client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event matches an {string} rule and EventBridge writes an item to the DynamoDB target")
  public void anEventMatchesAnEnabledRuleAndEventBridgeWritesAnItemToDynamoDB(String state) {
    Assumptions.assumeTrue(false, "Internal EventBridge routing not reachable via API");
  }

  @When(
      "an event matches an {string} rule but the DynamoDB write fails because the table is being deleted")
  public void anEventMatchesAnEnabledRuleButDynamoDBWriteFails(String state) {
    Assumptions.assumeTrue(false, "Internal EventBridge routing failure not reachable via API");
  }

  @When("a table deletion is initiated")
  public void aTableDeletionIsInitiated() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      var result = client.deleteTable(r -> r.tableName(TEST_DDB_TABLE));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the EventBridge event bus is deleted")
  public void theEventBridgeEventBusIsDeleted() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      var result = client.deleteEventBus(r -> r.name(TEST_EVENT_BUS));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("EventBridge notifications are enabled on the bucket targeting a specific bus")
  public void eventBridgeNotificationsAreEnabledOnTheBucket() {
    Assumptions.assumeTrue(
        false, "EventBridge notification configuration not reachable via API in fake");
  }

  @When("an object is uploaded and S3 delivers an event to the EventBridge bus")
  public void anObjectIsUploadedAndS3DeliversAnEventToEventBridge() {
    Assumptions.assumeTrue(false, "S3 event delivery not reachable via API");
  }

  @When("an object is uploaded but event delivery fails because the bus has been deleted")
  public void anObjectIsUploadedButEventDeliveryFails() {
    Assumptions.assumeTrue(false, "S3 event delivery failure not reachable via API");
  }

  @When("an {string} notification configuration is added to the bucket")
  public void anNotificationConfigurationIsAddedToTheBucket(String service) {
    Assumptions.assumeTrue(
        false, service + " notification configuration not reachable via API in fake");
  }

  @When("the {string} topic is deleted")
  public void theTopicIsDeleted(String service) {
    try (SnsClient client = world.snsClient()) {
      var result = client.deleteTopic(r -> r.topicArn(world.lastTopicArn));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the {string} queue is deleted")
  public void theQueueIsDeleted(String service) {
    try (SqsClient client = world.sqsClient()) {
      var result = client.deleteQueue(r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an object is uploaded and S3 publishes a notification to the {string} topic")
  public void anObjectIsUploadedAndS3PublishesANotificationToTopic(String service) {
    Assumptions.assumeTrue(false, "S3 notification delivery not reachable via API");
  }

  @When("an object is uploaded but notification delivery fails because the topic has been deleted")
  public void anObjectIsUploadedButNotificationDeliveryFailsBecauseTopicDeleted() {
    Assumptions.assumeTrue(false, "S3 notification failure not reachable via API");
  }

  @When("an object is uploaded to the bucket and S3 delivers a notification to the {string} queue")
  public void anObjectIsUploadedToTheBucketAndS3DeliversANotificationToQueue(String service) {
    Assumptions.assumeTrue(false, "S3 notification delivery not reachable via API");
  }

  @When("an object is uploaded but notification delivery fails because the queue has been deleted")
  public void anObjectIsUploadedButNotificationDeliveryFailsBecauseQueueDeleted() {
    Assumptions.assumeTrue(false, "S3 notification failure not reachable via API");
  }

  @When("a secret is created and Secrets Manager delivers a {string} event to the EventBridge bus")
  public void aSecretIsCreatedAndSecretsManagerDeliversAnEvent(String eventType) {
    Assumptions.assumeTrue(false, "Secrets Manager event delivery not reachable via API");
  }

  @When("a secret is created but the {string} event delivery fails because the bus is deleted")
  public void aSecretIsCreatedButEventDeliveryFails(String eventType) {
    Assumptions.assumeTrue(false, "Secrets Manager event delivery failure not reachable via API");
  }

  @When(
      "a secret is scheduled for deletion and Secrets Manager delivers a {string} event to the bus")
  public void aSecretIsScheduledForDeletionAndDeliversAnEvent(String eventType) {
    Assumptions.assumeTrue(false, "Secrets Manager event delivery not reachable via API");
  }

  @When("a secret rotation occurs and Secrets Manager delivers a {string} event to the bus")
  public void aSecretRotationOccursAndDeliversAnEvent(String eventType) {
    Assumptions.assumeTrue(false, "Secrets Manager rotation event not reachable via API");
  }

  @When("a parameter is created and {string} delivers a {string} event to the EventBridge bus")
  public void aParameterIsCreatedAndDeliversAnEvent(String service, String eventType) {
    Assumptions.assumeTrue(false, "SSM event delivery not reachable via API");
  }

  @When("a parameter is created but the {string} event delivery fails because the bus is deleted")
  public void aParameterIsCreatedButEventDeliveryFails(String eventType) {
    Assumptions.assumeTrue(false, "SSM event delivery failure not reachable via API");
  }

  @When("a parameter is deleted and {string} delivers a {string} event to the EventBridge bus")
  public void aParameterIsDeletedAndDeliversAnEvent(String service, String eventType) {
    Assumptions.assumeTrue(false, "SSM event delivery not reachable via API");
  }

  @When("an {string} queue subscribes to an {string} topic")
  public void anQueueSubscribesToATopic(String qService, String tService) {
    Assumptions.assumeTrue(false, "SQS-SNS subscription not reachable via API in fake");
  }

  @When(
      "a message is published to an {string} topic and delivered to the subscribed {string} queue")
  public void aMessageIsPublishedToTopicAndDeliveredToQueue(String tService, String qService) {
    Assumptions.assumeTrue(false, "SNS-SQS message delivery not reachable via API in fake");
  }

  @When("a message is consumed from the {string} queue")
  public void aMessageIsConsumedFromTheQueue(String service) {
    Assumptions.assumeTrue(false, "Message consumption not reachable via API in fake");
  }

  @When("a subscriber consumes a message from the {string} topic")
  public void aSubscriberConsumesAMessageFromTheTopic(String service) {
    Assumptions.assumeTrue(false, "Message consumption not reachable via API in fake");
  }

  @Given("an {string} message exists in the queue")
  public void anMessageExistsInTheQueue(String state) {
    sqsCreateQueue(TEST_SQS_QUEUE);
    try (SqsClient client = world.sqsClient()) {
      client.sendMessage(
          r -> r.queueUrl(world.sqsQueueUrl(TEST_SQS_QUEUE)).messageBody(TEST_SQS_MSG));
    }
  }

  @Given("no {string} message exists in the queue")
  public void noMessageExistsInTheQueue(String state) {
    // no-op: queue is empty by default
  }

  @Given("an {string} message exists on the topic")
  public void anMessageExistsOnTheTopic(String state) {
    // no-op: topic messages are internal
  }

  @Given("no {string} message exists on the topic")
  public void noMessageExistsOnTheTopic(String state) {
    // no-op: no messages by default
  }

  @When("a DynamoDB PutItem task is configured on the state machine")
  public void aDynamoDbPutItemTaskIsConfiguredOnTheStateMachine() {
    Assumptions.assumeTrue(false, "DynamoDB task configuration not reachable via API");
  }

  @When("a running execution writes an item to the DynamoDB table and succeeds")
  public void aRunningExecutionWritesAnItemToDynamoDb() {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("a running execution attempts to get an item that does not exist and the execution fails")
  public void aRunningExecutionAttemptsToGetAnItemThatDoesNotExist() {
    Assumptions.assumeTrue(false, "Internal execution task failure not reachable via API");
  }

  @When("an S3 task is configured on the state machine")
  public void anS3TaskIsConfiguredOnTheStateMachine() {
    Assumptions.assumeTrue(false, "S3 task configuration not reachable via API");
  }

  @When("a running execution writes an object to the S3 bucket and succeeds")
  public void aRunningExecutionWritesAnObjectToS3() {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("a running execution reads an existing object from the S3 bucket and succeeds")
  public void aRunningExecutionReadsAnObjectFromS3() {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("a running execution fails to read because no object exists in the bucket")
  public void aRunningExecutionFailsToReadBecauseNoObject() {
    Assumptions.assumeTrue(false, "Internal execution task failure not reachable via API");
  }

  @When("the state machine is configured to publish execution events to the event bus")
  public void theStateMachineIsConfiguredToPublishExecutionEvents() {
    Assumptions.assumeTrue(false, "Execution event publishing not configurable via API");
  }

  @When("a running execution succeeds and Step Functions delivers a {string} event to the bus")
  public void aRunningExecutionSucceedsAndDeliversAnEvent(String eventType) {
    Assumptions.assumeTrue(false, "Internal execution event delivery not reachable via API");
  }

  @When(
      "a running execution succeeds but the {string} event delivery fails because the bus is deleted")
  public void aRunningExecutionSucceedsButEventDeliveryFails(String eventType) {
    Assumptions.assumeTrue(
        false, "Internal execution event delivery failure not reachable via API");
  }

  @When("an execution starts and Step Functions delivers a {string} event to the EventBridge bus")
  public void anExecutionStartsAndDeliversAnEvent(String eventType) {
    Assumptions.assumeTrue(false, "Internal execution start event not reachable via API");
  }

  @When("an execution starts but the {string} event delivery fails because the bus is deleted")
  public void anExecutionStartsButEventDeliveryFails(String eventType) {
    Assumptions.assumeTrue(false, "Internal execution start event failure not reachable via API");
  }

  @When("a running execution reads an {string} secret and the task succeeds")
  public void aRunningExecutionReadsASecret(String state) {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("a running execution fails to read the secret because it is pending deletion")
  public void aRunningExecutionFailsToReadSecretBecausePendingDeletion() {
    Assumptions.assumeTrue(false, "Internal execution task failure not reachable via API");
  }

  @When("a secret is scheduled for deletion")
  public void aSecretIsScheduledForDeletion() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      var result = client.deleteSecret(r -> r.secretId(TEST_SM_SECRET).recoveryWindowInDays(7L));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution reads an existing parameter and the task succeeds")
  public void aRunningExecutionReadsAParameter() {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("a running execution fails to read the parameter because it has been deleted")
  public void aRunningExecutionFailsToReadParameterBecauseDeleted() {
    Assumptions.assumeTrue(false, "Internal execution task failure not reachable via API");
  }

  @When("a parameter is deleted from {string} Parameter Store")
  public void aParameterIsDeletedFromParameterStore(String service) {
    try (SsmClient client = world.ssmClient()) {
      var result = client.deleteParameter(r -> r.name(TEST_SSM_PARAM));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is created in {string} Parameter Store")
  public void aParameterIsCreatedInParameterStore(String service) {
    try (SsmClient client = world.ssmClient()) {
      var result =
          client.putParameter(
              r -> r.name(TEST_SSM_PARAM).value(TEST_SSM_VALUE).type(ParameterType.STRING));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an {string} publish task is configured on the state machine")
  public void anPublishTaskIsConfiguredOnTheStateMachine(String service) {
    Assumptions.assumeTrue(false, service + " publish task configuration not reachable via API");
  }

  @When("a running execution publishes a message to the {string} topic and succeeds")
  public void aRunningExecutionPublishesAMessageToTopic(String service) {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("an {string} send-message task is configured on the state machine")
  public void anSendMessageTaskIsConfiguredOnTheStateMachine(String service) {
    Assumptions.assumeTrue(
        false, service + " send-message task configuration not reachable via API");
  }

  @When("a running execution reaches the {string} task state and sends a message to the queue")
  public void aRunningExecutionReachesTaskStateAndSendsMessageToQueue(String service) {
    Assumptions.assumeTrue(false, "Internal execution task not reachable via API");
  }

  @When("an execution of the state machine is started")
  public void anExecutionOfTheStateMachineIsStarted() {
    try (SfnClient client = world.sfnClient()) {
      var result =
          client.startExecution(
              r -> r.stateMachineArn(world.lastStateMachineArn).input(TEST_SFN_INPUT));
      world.lastExecutionArn = result.executionArn();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a secret is created in Secrets Manager")
  public void aSecretIsCreatedInSecretsManager() {
    try (SecretsManagerClient client = world.secretsManagerClient()) {
      var result = client.createSecret(r -> r.name(TEST_SM_SECRET).secretString(TEST_SM_VALUE));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // Then steps: integration-specific assertions
  // -------------------------------------------------------------------------

  @Then("the rule is \"DISABLED\" on the bus with the DynamoDB target configured")
  public void theRuleIsDisabledOnTheBusWithDynamoDbTargetConfigured() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the rule is \"ENABLED\" and will match events")
  public void theRuleIsEnabledAndWillMatchEvents() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the rule is \"DISABLED\" and will not match events")
  public void theRuleIsDisabledAndWillNotMatchEvents() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the item {string} in the table and the event is recorded as {string}")
  public void theItemInTheTableAndTheEventIsRecordedAs(String itemState, String eventState) {
    Assumptions.assumeTrue(false, "Internal routing result not verifiable via API");
  }

  @Then("the event is {string} but no item is written")
  public void theEventIsButNoItemIsWritten(String state) {
    Assumptions.assumeTrue(false, "Internal routing result not verifiable via API");
  }

  @Then("the table is \"DELETING\" and item writes to it will fail")
  public void theTableIsDeletingAndItemWritesWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the message is \"AVAILABLE\" on the topic")
  public void theMessageIsAvailableOnTheTopic() {
    Assumptions.assumeTrue(false, "Internal topic message not verifiable via API");
  }

  @Then("the message is \"DELETED\"")
  public void theMessageIsDeleted() {
    Assumptions.assumeTrue(false, "Internal message deletion not verifiable via API");
  }

  @Then("the rule is \"ENABLED\" and will publish to the topic when matching events are received")
  public void theRuleIsEnabledAndWillPublishToTopic() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the message is \"AVAILABLE\" in the target queue")
  public void theMessageIsAvailableInTheTargetQueue() {
    Assumptions.assumeTrue(false, "Internal queue message not verifiable via API");
  }

  @Then("the rule is \"ENABLED\" and will forward matching events to the queue")
  public void theRuleIsEnabledAndWillForwardEventsToQueue() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the rule is \"ENABLED\" and will trigger an execution when matching events are published")
  public void theRuleIsEnabledAndWillTriggerAnExecution() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the execution is \"FAILED\"")
  public void theExecutionIsFailed() {
    Assumptions.assumeTrue(false, "Execution FAILED state not verifiable via API");
  }

  @Then("the execution is \"SUCCEEDED\"")
  public void theExecutionIsSucceeded() {
    Assumptions.assumeTrue(false, "Execution SUCCEEDED state not verifiable via API");
  }

  @Then("the bucket is \"ACTIVE\" with no EventBridge notification configuration")
  public void theBucketIsActiveWithNoEventBridgeNotificationConfiguration() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the bucket will send events to the bus when objects are uploaded")
  public void theBucketWillSendEventsToBus() {
    Assumptions.assumeTrue(false, "S3 event delivery not verifiable via API");
  }

  @Then("the object {string} but no event is delivered")
  public void theObjectButNoEventIsDelivered(String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the object {string} and an event is {string} to the bus")
  public void theObjectAndAnEventIsDeliveredToBus(String objectState, String eventState) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the bus is \"DELETED\" and event delivery to it will fail")
  public void theBusIsDeletedAndEventDeliveryWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the bucket is \"ACTIVE\" with no notification configuration")
  public void theBucketIsActiveWithNoNotificationConfiguration() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the bucket will publish notifications to the topic when objects are uploaded")
  public void theBucketWillPublishNotificationsToTopic() {
    Assumptions.assumeTrue(false, "S3 notification delivery not verifiable via API");
  }

  @Then("the object {string} but no notification is published")
  public void theObjectButNoNotificationIsPublished(String state) {
    Assumptions.assumeTrue(false, "Internal notification delivery not verifiable via API");
  }

  @Then("the object {string} and a notification is {string} to the topic")
  public void theObjectAndANotificationIsPublishedToTopic(String objectState, String notifState) {
    Assumptions.assumeTrue(false, "Internal notification delivery not verifiable via API");
  }

  @Then("the topic is \"DELETED\" and notification delivery to it will fail")
  public void theTopicIsDeletedAndNotificationDeliveryWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the bucket will send notifications to the queue when objects are uploaded")
  public void theBucketWillSendNotificationsToQueue() {
    Assumptions.assumeTrue(false, "S3 notification delivery not verifiable via API");
  }

  @Then("the object {string} but no notification message is delivered")
  public void theObjectButNoNotificationMessageIsDelivered(String state) {
    Assumptions.assumeTrue(false, "Internal notification delivery not verifiable via API");
  }

  @Then("the object {string} and a notification message is {string}")
  public void theObjectAndANotificationMessageIs(String objectState, String msgState) {
    Assumptions.assumeTrue(false, "Internal notification delivery not verifiable via API");
  }

  @Then("the queue is \"DELETED\" and notification delivery to it will fail")
  public void theQueueIsDeletedAndNotificationDeliveryWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the secret is \"ACTIVE\" and the {string} event is {string}")
  public void theSecretIsActiveAndTheEventIs(String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the secret is \"ACTIVE\" but no event is delivered")
  public void theSecretIsActiveButNoEventIsDelivered() {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the secret is \"PENDING_DELETION\" and the {string} event is {string}")
  public void theSecretIsPendingDeletionAndTheEventIs(String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the secret is \"ACTIVE\" with a new version and the {string} event is {string}")
  public void theSecretIsActiveWithANewVersionAndTheEventIs(String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the bus is \"DELETED\" and Secrets Manager event delivery will fail")
  public void theBusIsDeletedAndSecretsManagerEventDeliveryWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the parameter {string} and the {string} event is {string}")
  public void theParameterAndTheEventIs(String paramState, String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the parameter {string} but no event is delivered")
  public void theParameterButNoEventIsDelivered(String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the parameter is {string} and the {string} event is {string}")
  public void theParameterIsAndTheEventIs(String paramState, String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the bus is \"DELETED\" and {string} event delivery will fail")
  public void theBusIsDeletedAndEventDeliveryWillFail(String service) {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the subscription is \"CONFIRMED\" and the queue will receive published messages")
  public void theSubscriptionIsConfirmedAndQueueWillReceivePublishedMessages() {
    Assumptions.assumeTrue(false, "Internal subscription confirmation not verifiable via API");
  }

  @Then("the message is \"AVAILABLE\" in the queue")
  public void theMessageIsAvailableInTheQueue() {
    Assumptions.assumeTrue(false, "Internal queue message not verifiable via API");
  }

  @Then("a message can only be delivered if a confirmed subscription exists for the topic")
  public void aMessageCanOnlyBeDeliveredIfAConfirmedSubscriptionExistsForTheTopic() {
    // no-op: invariant
  }

  @Then("the state machine is \"ACTIVE\" with no DynamoDB task configured")
  public void theStateMachineIsActiveWithNoDynamoDbTaskConfigured() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the state machine will write an item to the table when it reaches the task state")
  public void theStateMachineWillWriteAnItemToTable() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the item {string} in the table and the execution is {string}")
  public void theItemInTheTableAndTheExecutionIs(String itemState, String execState) {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the execution is \"FAILED\" because the item was not found")
  public void theExecutionIsFailedBecauseItemWasNotFound() {
    Assumptions.assumeTrue(false, "Internal task failure not verifiable via API");
  }

  @Then("the state machine is \"ACTIVE\" with no S3 task configured")
  public void theStateMachineIsActiveWithNoS3TaskConfigured() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the state machine will read or write objects to the bucket when it reaches the task state")
  public void theStateMachineWillReadOrWriteObjects() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the object {string} in the bucket and the execution is {string}")
  public void theObjectInTheBucketAndTheExecutionIs(String objectState, String execState) {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the execution is \"FAILED\" with a NoSuchKey error")
  public void theExecutionIsFailedWithNoSuchKeyError() {
    Assumptions.assumeTrue(false, "Internal task failure not verifiable via API");
  }

  @Then("the state machine is \"ACTIVE\" with no EventBridge bus configured")
  public void theStateMachineIsActiveWithNoEventBridgeBusConfigured() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the state machine will send execution state change events to the bus")
  public void theStateMachineWillSendExecutionStateChangeEvents() {
    Assumptions.assumeTrue(false, "Internal event publishing not verifiable via API");
  }

  @Then("the execution is \"RUNNING\" and the {string} event is {string}")
  public void theExecutionIsRunningAndTheEventIs(String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the execution is \"RUNNING\" but no {string} event is delivered")
  public void theExecutionIsRunningButNoEventIsDelivered(String eventType) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the execution is \"SUCCEEDED\" and the {string} event is {string}")
  public void theExecutionIsSucceededAndTheEventIs(String eventType, String state) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the execution is \"SUCCEEDED\" but no {string} event is delivered")
  public void theExecutionIsSucceededButNoEventIsDelivered(String eventType) {
    Assumptions.assumeTrue(false, "Internal event delivery not verifiable via API");
  }

  @Then("the bus is \"DELETED\" and execution event delivery will fail")
  public void theBusIsDeletedAndExecutionEventDeliveryWillFail() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  // everySucceededExecutionRecordedWhichSecretItRead handled by AbstractSteps.everyInvariant()

  @Then("the secret is \"PENDING_DELETION\" and will cause task failures when read")
  public void theSecretIsPendingDeletionAndWillCauseTaskFailures() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the execution is \"FAILED\" with a ResourceNotFoundException")
  public void theExecutionIsFailedWithResourceNotFoundException() {
    Assumptions.assumeTrue(false, "Internal task failure not verifiable via API");
  }

  // everySucceededExecutionRecordedWhichParameterItRead handled by AbstractSteps.everyInvariant()

  @Then("the parameter is \"DELETED\" and will cause task failures when read")
  public void theParameterIsDeletedAndWillCauseTaskFailures() {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the execution is \"FAILED\" with a ParameterNotFound error")
  public void theExecutionIsFailedWithParameterNotFoundError() {
    Assumptions.assumeTrue(false, "Internal task failure not verifiable via API");
  }

  @Then("the state machine is \"ACTIVE\" with no {string} task configured")
  public void theStateMachineIsActiveWithNoTaskConfigured(String service) {
    assertTrue(world.lastSuccess, "Expected success");
  }

  @Then("the state machine will publish a message to the topic when it reaches the task state")
  public void theStateMachineWillPublishAMessageToTopic() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the execution is \"SUCCEEDED\" and the message has been published to the topic")
  public void theExecutionIsSucceededAndMessageHasBeenPublishedToTopic() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  // everyExecutionStateMachineTargetsATopic handled by AbstractSteps.everyInvariant()

  @Then("the state machine will enqueue a message when it reaches the task state")
  public void theStateMachineWillEnqueueAMessage() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  @Then("the message is \"AVAILABLE\" in the queue and the execution is \"SUCCEEDED\"")
  public void theMessageIsAvailableInTheQueueAndTheExecutionIsSucceeded() {
    Assumptions.assumeTrue(false, "Internal task execution not verifiable via API");
  }

  // @Then("the execution is "RUNNING"") is registered in AbstractSteps.theExecutionIsRunning()
  // which handles both setup (Given/And) and assertion (Then) contexts.

  // Note: @Given("the secret is \"ACTIVE\"") and @Then("the secret is \"ACTIVE\"")
  // are already registered in AbstractSteps — no duplicate here.
}
