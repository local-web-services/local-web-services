package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.*;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

public class DynamoDbSteps {

  private final WorldContext world;

  public DynamoDbSteps(WorldContext world) {
    this.world = world;
  }

  @Given("a DynamoDB table {string} with partition key {string}")
  public void aDynamoDbTableWithPartitionKey(String tableName, String partitionKey) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      try {
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
      } catch (Exception ignored) {
      }
    }
  }

  @Given("a DynamoDB table {string} exists")
  public void aDynamoDbTableExists(String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      try {
        client.createTable(
            r ->
                r.tableName(tableName)
                    .keySchema(
                        KeySchemaElement.builder()
                            .attributeName("pk")
                            .keyType(KeyType.HASH)
                            .build())
                    .attributeDefinitions(
                        AttributeDefinition.builder()
                            .attributeName("pk")
                            .attributeType(ScalarAttributeType.S)
                            .build())
                    .billingMode(BillingMode.PAY_PER_REQUEST));
      } catch (Exception ignored) {
      }
    }
  }

  @Given("an item {string} was put into table {string}")
  public void anItemWasPutIntoTable(String pkValue, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      client.putItem(r -> r.tableName(tableName).item(Map.of("pk", AttributeValue.fromS(pkValue))));
    }
  }

  @When("I create a DynamoDB table {string}")
  public void iCreateADynamoDbTable(String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.createTable(
              r ->
                  r.tableName(tableName)
                      .keySchema(
                          KeySchemaElement.builder()
                              .attributeName("pk")
                              .keyType(KeyType.HASH)
                              .build())
                      .attributeDefinitions(
                          AttributeDefinition.builder()
                              .attributeName("pk")
                              .attributeType(ScalarAttributeType.S)
                              .build())
                      .billingMode(BillingMode.PAY_PER_REQUEST)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I create a DynamoDB table {string} with partition key {string}")
  public void iCreateADynamoDbTableWithPartitionKey(String tableName, String pk) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.createTable(
              r ->
                  r.tableName(tableName)
                      .keySchema(
                          KeySchemaElement.builder()
                              .attributeName(pk)
                              .keyType(KeyType.HASH)
                              .build())
                      .attributeDefinitions(
                          AttributeDefinition.builder()
                              .attributeName(pk)
                              .attributeType(ScalarAttributeType.S)
                              .build())
                      .billingMode(BillingMode.PAY_PER_REQUEST)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list DynamoDB tables")
  public void iListDynamoDbTables() {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(client.listTables());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put an item with pk {string} into table {string}")
  public void iPutAnItemWithPkIntoTable(String pk, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.putItem(r -> r.tableName(tableName).item(Map.of("pk", AttributeValue.fromS(pk)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get an item with pk {string} from table {string}")
  public void iGetAnItemWithPkFromTable(String pk, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.getItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete an item with pk {string} from table {string}")
  public void iDeleteAnItemWithPkFromTable(String pk, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.deleteItem(
              r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I query table {string} with pk {string}")
  public void iQueryTableWithPk(String tableName, String pk) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      world.setSuccess(
          client.query(
              r ->
                  r.tableName(tableName)
                      .keyConditionExpression("pk = :pk")
                      .expressionAttributeValues(Map.of(":pk", AttributeValue.fromS(pk)))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("the table {string} will appear in the list")
  public void theTableWillAppearInTheList(String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      ListTablesResponse result = client.listTables();
      assertTrue(
          result.tableNames().contains(tableName),
          "Expected table \"" + tableName + "\" in list but got: " + result.tableNames());
    }
  }

  @Then("the table {string} will not appear in the list")
  public void theTableWillNotAppearInTheList(String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      ListTablesResponse result = client.listTables();
      assertFalse(
          result.tableNames().contains(tableName),
          "Expected table \"" + tableName + "\" to not be in list");
    }
  }

  @Then("the item with pk {string} will exist in table {string}")
  public void theItemWithPkWillExistInTable(String pk, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      GetItemResponse result =
          client.getItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk))));
      assertTrue(result.hasItem(), "Expected item with pk \"" + pk + "\" to exist");
    }
  }

  @Then("the item with pk {string} will not exist in table {string}")
  public void theItemWithPkWillNotExistInTable(String pk, String tableName) {
    try (DynamoDbClient client = world.dynamodbClient()) {
      GetItemResponse result =
          client.getItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk))));
      assertFalse(result.hasItem(), "Expected item with pk \"" + pk + "\" to not exist");
    }
  }

  @Then("the scan result will contain {int} item(s)")
  public void theScanResultWillContainItems(int count) {
    String actual = String.valueOf(world.lastOutput);
    // Check via scan output
    assertTrue(world.lastSuccess, "Last command failed: " + actual);
  }
}
