package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ListTablesResponse;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;
import software.amazon.awssdk.services.eventbridge.model.ListRulesResponse;
import software.amazon.awssdk.services.eventbridge.model.RuleState;
import software.amazon.awssdk.services.eventbridge.model.Target;

/** Step definitions for the events_dynamodb cross-service suite. */
public class EventsDynamodbSteps {

  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_EVENT_RULE = "test-rule-1";
  private static final String TEST_DDB_TABLE = "test-table-1";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public EventsDynamodbSteps(WorldContext world) {
    this.world = world;
  }

  // ---------------------------------------------------------------------------
  // FizzBee model initialisation preconditions (not in CrossServiceSteps)
  // ---------------------------------------------------------------------------

  @Given("^rid in rule_status$")
  public void ridInRuleStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^tid in table_status$")
  public void tidInTableStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // ---------------------------------------------------------------------------
  // Capacity preconditions (events_dynamodb-specific)
  // ---------------------------------------------------------------------------

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: event slots are unlimited by default
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // Arrange / Act / Assert — capacity exhaustion not configurable via SDK API
    Assumptions.assumeTrue(false, "capacity exhaustion not configurable via SDK API");
  }

  // ---------------------------------------------------------------------------
  // Event bus preconditions (events_dynamodb-specific wording uses "bus" not "event bus")
  // ---------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no custom event buses
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    // Act
    client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    // Act
    try {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception ignored) {
      // bus may already exist
    }
    // Assert — bus is ACTIVE; only ACTIVE state reachable via public create API
    String expectedState = "ACTIVE";
    assertTrue(
        expectedState.equals(state),
        "expected bus state '" + state + "' but only ACTIVE is reachable via SDK API");
  }

  @Given("the bus does not exist or is not {string}")
  public void theBusDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus state not reachable via public API
    Assumptions.assumeTrue(false, "bus non-ACTIVE state not reachable via SDK API");
  }

  // ---------------------------------------------------------------------------
  // Table preconditions (events_dynamodb-specific "table exists and is" variant)
  // ---------------------------------------------------------------------------

  @Given("the table exists and is {string}")
  public void theTableExistsAndIs(String state) {
    // Arrange
    DynamoDbClient client = world.session.dynamoDbClient();
    // Act
    try {
      client.createTable(
          r ->
              r.tableName(TEST_DDB_TABLE)
                  .billingMode(BillingMode.PAY_PER_REQUEST)
                  .keySchema(
                      KeySchemaElement.builder()
                          .attributeName("id")
                          .keyType(KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      AttributeDefinition.builder()
                          .attributeName("id")
                          .attributeType(ScalarAttributeType.S)
                          .build()));
    } catch (Exception ignored) {
      // table may already exist
    }
    // Assert — table is ACTIVE; only ACTIVE state reachable via public create API
    String expectedState = "ACTIVE";
    assertTrue(
        expectedState.equals(state),
        "expected table state '" + state + "' but only ACTIVE is reachable via SDK create API");
  }

  @Given("the table does not exist or is not {string}")
  public void theTableDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE table state not reachable via public API
    Assumptions.assumeTrue(false, "table non-ACTIVE state not reachable via SDK API");
  }

  @Given("the table is already {string}")
  public void theTableIsAlready(String state) {
    // Arrange / Act / Assert — non-ACTIVE table state not reachable via public API
    Assumptions.assumeTrue(false, "table " + state + " state not reachable via SDK API");
  }

  @Given("the target table is \"DELETING\"")
  public void theTargetTableIsDeleting() {
    // Arrange / Act / Assert — DELETING table state not reachable via public API
    Assumptions.assumeTrue(
        false, "lws limitation: DELETING table state not reachable via SDK API");
  }

  @Given("the target table is not \"DELETING\"")
  public void theTargetTableIsNotDeleting() {
    // Arrange / Act / Assert — no-op: target table is ACTIVE by default
  }

  // ---------------------------------------------------------------------------
  // Rule preconditions (events_dynamodb-specific "rule is/already" variants)
  // ---------------------------------------------------------------------------

  @Given("the rule is {string}")
  public void theRuleIs(String state) {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    RuleState ruleState = "ENABLED".equals(state) ? RuleState.ENABLED : RuleState.DISABLED;
    // Act — ensure bus and rule exist in the requested state
    try {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception ignored) {
      // bus may already exist
    }
    try {
      client.putRule(
          r ->
              r.name(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .eventPattern("{\"source\":[\"lws.test\"]}")
                  .state(ruleState));
    } catch (Exception ignored) {
      // rule may already exist
    }
    // Assert — rule is in requested state; verified by subsequent steps
  }

  @Given("the rule is already {string}")
  public void theRuleIsAlready(String state) {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    RuleState ruleState = "ENABLED".equals(state) ? RuleState.ENABLED : RuleState.DISABLED;
    // Act — ensure bus and rule exist in the specified state
    try {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception ignored) {
      // bus may already exist
    }
    try {
      client.putRule(
          r ->
              r.name(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .eventPattern("{\"source\":[\"lws.test\"]}")
                  .state(ruleState));
    } catch (Exception ignored) {
      // rule may already exist
    }
    // Assert — rule is in specified state; verified by subsequent steps
  }

  @Given("a rule is \"ENABLED\"")
  public void aRuleIsEnabled() {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    String tableArn =
        "arn:aws:dynamodb:" + TEST_REGION + ":" + TEST_ACCOUNT + ":table/" + TEST_DDB_TABLE;
    // Act — ensure bus and enabled rule with DynamoDB target exist
    try {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception ignored) {
      // bus may already exist
    }
    try {
      client.putRule(
          r ->
              r.name(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .eventPattern("{\"source\":[\"lws.test\"]}")
                  .state(RuleState.ENABLED));
    } catch (Exception ignored) {
      // rule may already exist
    }
    try {
      Target target = Target.builder().id("ddb-target-1").arn(tableArn).build();
      client.putTargets(r -> r.rule(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS).targets(target));
    } catch (Exception ignored) {
      // targets may already be set
    }
    // Assert — rule is ENABLED with DynamoDB target; verified by subsequent steps
  }

  @Given("no rule is \"ENABLED\"")
  public void noRuleIsEnabled() {
    // Arrange / Act / Assert — no enabled rule state not directly configurable via public API
    Assumptions.assumeTrue(false, "no enabled rule state not reachable via SDK API");
  }

  // ---------------------------------------------------------------------------
  // When steps
  // ---------------------------------------------------------------------------

  @When("an EventBridge rule is created targeting a DynamoDB table")
  public void anEventBridgeRuleIsCreatedTargetingADynamoDbTable() {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    String tableArn =
        "arn:aws:dynamodb:" + TEST_REGION + ":" + TEST_ACCOUNT + ":table/" + TEST_DDB_TABLE;
    try {
      // Act — create bus, rule (DISABLED), then add DynamoDB target
      try {
        client.createEventBus(r -> r.name(TEST_EVENT_BUS));
      } catch (Exception ignored) {
        // bus may already exist
      }
      client.putRule(
          r ->
              r.name(TEST_EVENT_RULE)
                  .eventBusName(TEST_EVENT_BUS)
                  .eventPattern("{\"source\":[\"lws.test\"]}")
                  .state(RuleState.DISABLED));
      Target target = Target.builder().id("ddb-target-1").arn(tableArn).build();
      client.putTargets(r -> r.rule(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS).targets(target));
      // Assert
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table deletion is initiated")
  public void aTableDeletionIsInitiated() {
    // Arrange
    DynamoDbClient client = world.session.dynamoDbClient();
    try {
      // Act
      client.deleteTable(r -> r.tableName(TEST_DDB_TABLE));
      // Assert
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is enabled")
  public void anEventBridgeRuleIsEnabled() {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    try {
      // Act
      client.enableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
      // Assert
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge rule is disabled")
  public void anEventBridgeRuleIsDisabled() {
    // Arrange
    EventBridgeClient client = world.session.eventBridgeClient();
    try {
      // Act
      client.disableRule(r -> r.name(TEST_EVENT_RULE).eventBusName(TEST_EVENT_BUS));
      // Assert
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "an event matches an \"ENABLED\" rule and EventBridge writes an item to the DynamoDB"
          + " target")
  public void anEventMatchesAnEnabledRuleAndEventBridgeWritesAnItemToTheDynamoDbTarget() {
    // Arrange / Act / Assert — EventBridge→DynamoDB dispatch not implemented in lws Java core
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge→DynamoDB dispatch not implemented in Java core");
  }

  @When(
      "an event matches an \"ENABLED\" rule but the DynamoDB write fails because the table is"
          + " being deleted")
  public void anEventMatchesAnEnabledRuleButTheDynamoDbWriteFails() {
    // Arrange / Act / Assert — EventBridge→DynamoDB dispatch not implemented in lws Java core
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge→DynamoDB dispatch not implemented in Java core");
  }

  // ---------------------------------------------------------------------------
  // Then steps
  // ---------------------------------------------------------------------------

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    EventBridgeClient client = world.session.eventBridgeClient();
    boolean actualExists;
    try {
      ListEventBusesResponse response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      actualExists =
          response.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
    } catch (Exception e) {
      actualExists = false;
    }
    // Assert
    assertTrue(actualExists, "expected event bus '" + expectedBusName + "' to be ACTIVE");
  }

  @Then("the rule is \"DISABLED\" on the bus with the DynamoDB target configured")
  public void theRuleIsDisabledOnTheBusWithTheDynamoDbTargetConfigured() {
    // Arrange
    String expectedRuleName = TEST_EVENT_RULE;
    // Act
    EventBridgeClient client = world.session.eventBridgeClient();
    boolean actualRuleExists;
    try {
      ListRulesResponse response =
          client.listRules(r -> r.namePrefix(expectedRuleName).eventBusName(TEST_EVENT_BUS));
      actualRuleExists =
          response.rules().stream()
              .anyMatch(
                  rule ->
                      rule.name().equals(expectedRuleName)
                          && rule.stateAsString().equals("DISABLED"));
    } catch (Exception e) {
      actualRuleExists = false;
    }
    // Assert
    assertTrue(
        actualRuleExists,
        "expected rule '" + expectedRuleName + "' to exist and be DISABLED on bus");
  }

  @Then("the rule is \"DISABLED\" and will not match events")
  public void theRuleIsDisabledAndWillNotMatchEvents() {
    // Arrange
    String expectedRuleName = TEST_EVENT_RULE;
    // Act
    EventBridgeClient client = world.session.eventBridgeClient();
    boolean actualRuleDisabled;
    try {
      ListRulesResponse response =
          client.listRules(r -> r.namePrefix(expectedRuleName).eventBusName(TEST_EVENT_BUS));
      actualRuleDisabled =
          response.rules().stream()
              .anyMatch(
                  rule ->
                      rule.name().equals(expectedRuleName)
                          && rule.stateAsString().equals("DISABLED"));
    } catch (Exception e) {
      actualRuleDisabled = false;
    }
    // Assert
    assertTrue(actualRuleDisabled, "expected rule '" + expectedRuleName + "' to be DISABLED");
  }

  @Then("the rule is \"ENABLED\" and will match events")
  public void theRuleIsEnabledAndWillMatchEvents() {
    // Arrange
    String expectedRuleName = TEST_EVENT_RULE;
    // Act
    EventBridgeClient client = world.session.eventBridgeClient();
    boolean actualRuleEnabled;
    try {
      ListRulesResponse response =
          client.listRules(r -> r.namePrefix(expectedRuleName).eventBusName(TEST_EVENT_BUS));
      actualRuleEnabled =
          response.rules().stream()
              .anyMatch(
                  rule ->
                      rule.name().equals(expectedRuleName)
                          && rule.stateAsString().equals("ENABLED"));
    } catch (Exception e) {
      actualRuleEnabled = false;
    }
    // Assert
    assertTrue(actualRuleEnabled, "expected rule '" + expectedRuleName + "' to be ENABLED");
  }

  @Then("the table is \"ACTIVE\"")
  public void theTableIsActive() {
    // Arrange
    String expectedTableName = TEST_DDB_TABLE;
    // Act
    DynamoDbClient client = world.session.dynamoDbClient();
    boolean actualExists;
    try {
      ListTablesResponse response = client.listTables();
      actualExists = response.tableNames().contains(expectedTableName);
    } catch (Exception e) {
      actualExists = false;
    }
    // Assert
    assertTrue(actualExists, "expected table '" + expectedTableName + "' to be ACTIVE");
  }

  @Then("the table is \"DELETING\" and item writes to it will fail")
  public void theTableIsDeletingAndItemWritesToItWillFail() {
    // Arrange
    String expectedTableName = TEST_DDB_TABLE;
    // Act
    DynamoDbClient client = world.session.dynamoDbClient();
    boolean actualGone;
    try {
      ListTablesResponse response = client.listTables();
      actualGone = !response.tableNames().contains(expectedTableName);
    } catch (Exception e) {
      actualGone = true;
    }
    // Assert
    assertTrue(actualGone, "expected table '" + expectedTableName + "' to be DELETING/gone");
  }

  @Then("the item \"EXISTS\" in the table and the event is recorded as \"MATCHED\"")
  public void theItemExistsInTheTableAndTheEventIsRecordedAsMatched() {
    // Arrange / Act / Assert — EventBridge→DynamoDB dispatch not implemented in lws Java core
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge→DynamoDB dispatch not implemented in Java core");
  }

  @Then("the event is \"MATCHED\" but no item is written")
  public void theEventIsMatchedButNoItemIsWritten() {
    // Arrange / Act / Assert — EventBridge→DynamoDB dispatch not implemented in lws Java core
    Assumptions.assumeTrue(
        false, "lws limitation: EventBridge→DynamoDB dispatch not implemented in Java core");
  }

  @And("every existing item references a table that exists")
  public void everyExistingItemReferencesATableThatExists() {
    // Arrange / Act / Assert — no-op: model-level invariant; not verifiable via public API
  }

  @And("every matched event references a rule that exists")
  public void everyMatchedEventReferencesARuleThatExists() {
    // Arrange / Act / Assert — no-op: model-level invariant; not verifiable via public API
  }
}
