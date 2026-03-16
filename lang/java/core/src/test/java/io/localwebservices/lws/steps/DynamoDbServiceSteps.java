package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/** DynamoDB step definitions matching the feature file step text exactly. */
public class DynamoDbServiceSteps {

    private static final String ACCOUNT = "000000000000";
    private static final String REGION = "us-east-1";

    private final WorldContext world;

    public DynamoDbServiceSteps(WorldContext world) {
        this.world = world;
    }

    private String tableArn(String tableName) {
        return "arn:aws:dynamodb:" + REGION + ":" + ACCOUNT + ":table/" + tableName;
    }

    @Given("a table {string} was created")
    public void aTableWasCreated(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            try {
                client.createTable(r -> r.tableName(tableName)
                    .keySchema(KeySchemaElement.builder().attributeName("pk").keyType(KeyType.HASH).build())
                    .attributeDefinitions(AttributeDefinition.builder().attributeName("pk").attributeType(ScalarAttributeType.S).build())
                    .billingMode(BillingMode.PAY_PER_REQUEST));
            } catch (Exception ignored) {}
        }
    }

    @Given("an item was put with key {string} and data {string} into table {string}")
    public void anItemWasPutWithKeyAndDataIntoTable(String pk, String data, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            client.putItem(r -> r.tableName(tableName).item(Map.of(
                "pk", AttributeValue.fromS(pk),
                "data", AttributeValue.fromS(data)
            )));
        }
    }

    @Given("an item was put with key {string} and status {string} into table {string}")
    public void anItemWasPutWithKeyAndStatusIntoTable(String pk, String status, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            client.putItem(r -> r.tableName(tableName).item(Map.of(
                "pk", AttributeValue.fromS(pk),
                "status", AttributeValue.fromS(status)
            )));
        }
    }

    @Given("an item was put with key {string} into table {string}")
    public void anItemWasPutWithKeyIntoTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            client.putItem(r -> r.tableName(tableName).item(Map.of("pk", AttributeValue.fromS(pk))));
        }
    }

    @Given("table {string} was tagged with key {string} and value {string}")
    public void tableWasTaggedWithKeyAndValue(String tableName, String key, String value) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            client.tagResource(r -> r.resourceArn(tableArn(tableName))
                .tags(software.amazon.awssdk.services.dynamodb.model.Tag.builder().key(key).value(value).build()));
        }
    }

    @When("I create a table {string}")
    public void iCreateATable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.createTable(r -> r.tableName(tableName)
                .keySchema(KeySchemaElement.builder().attributeName("pk").keyType(KeyType.HASH).build())
                .attributeDefinitions(AttributeDefinition.builder().attributeName("pk").attributeType(ScalarAttributeType.S).build())
                .billingMode(BillingMode.PAY_PER_REQUEST)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I delete table {string}")
    public void iDeleteTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.deleteTable(r -> r.tableName(tableName)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I describe table {string}")
    public void iDescribeTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.describeTable(r -> r.tableName(tableName)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I update table {string} with billing mode {string}")
    public void iUpdateTableWithBillingMode(String tableName, String billingMode) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.updateTable(r -> r.tableName(tableName).billingMode(BillingMode.fromValue(billingMode))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list tables")
    public void iListTables() {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.listTables());
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list DynamoDB tables with timing")
    public void iListDynamoDbTablesWithTiming() {
        long start = System.currentTimeMillis();
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.timedOutput = client.listTables();
            world.timedSuccess = true;
        } catch (Exception e) {
            world.timedSuccess = false;
            world.timedOutput = e;
        } finally {
            world.timedElapsedMs = System.currentTimeMillis() - start;
        }
    }

    @When("I describe time to live for table {string}")
    public void iDescribeTimeToLiveForTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.describeTimeToLive(r -> r.tableName(tableName)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I update time to live for table {string}")
    public void iUpdateTimeToLiveForTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.updateTimeToLive(r -> r.tableName(tableName)
                .timeToLiveSpecification(s -> s.attributeName("ttl").enabled(true))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I describe continuous backups for table {string}")
    public void iDescribeContinuousBackupsForTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.describeContinuousBackups(r -> r.tableName(tableName)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I get item with key {string} from table {string}")
    public void iGetItemWithKeyFromTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.getItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk)))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I put an item with key {string} and data {string} into table {string}")
    public void iPutAnItemWithKeyAndDataIntoTable(String pk, String data, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.putItem(r -> r.tableName(tableName).item(Map.of(
                "pk", AttributeValue.fromS(pk),
                "data", AttributeValue.fromS(data)
            ))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I delete item with key {string} from table {string}")
    public void iDeleteItemWithKeyFromTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.deleteItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk)))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I update item with key {string} setting data to {string} in table {string}")
    public void iUpdateItemWithKeySettingDataToInTable(String pk, String data, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.updateItem(r -> r.tableName(tableName)
                .key(Map.of("pk", AttributeValue.fromS(pk)))
                .updateExpression("SET #d = :d")
                .expressionAttributeNames(Map.of("#d", "data"))
                .expressionAttributeValues(Map.of(":d", AttributeValue.fromS(data)))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I query table {string} for key {string}")
    public void iQueryTableForKey(String tableName, String pk) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.query(r -> r.tableName(tableName)
                .keyConditionExpression("pk = :pk")
                .expressionAttributeValues(Map.of(":pk", AttributeValue.fromS(pk)))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I scan table {string}")
    public void iScanTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.scan(r -> r.tableName(tableName)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I batch get item with key {string} from table {string}")
    public void iBatchGetItemWithKeyFromTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.batchGetItem(r -> r.requestItems(Map.of(
                tableName, KeysAndAttributes.builder().keys(Map.of("pk", AttributeValue.fromS(pk))).build()
            ))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I batch write items with keys {string} and {string} into table {string}")
    public void iBatchWriteItemsWithKeysAndIntoTable(String pk1, String pk2, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.batchWriteItem(r -> r.requestItems(Map.of(tableName, List.of(
                WriteRequest.builder().putRequest(p -> p.item(Map.of("pk", AttributeValue.fromS(pk1)))).build(),
                WriteRequest.builder().putRequest(p -> p.item(Map.of("pk", AttributeValue.fromS(pk2)))).build()
            )))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I transact get item with key {string} from table {string}")
    public void iTransactGetItemWithKeyFromTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.transactGetItems(r -> r.transactItems(
                TransactGetItem.builder().get(g -> g.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk)))).build()
            )));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I transact write with condition check on key {string} and put key {string} with data {string} in table {string}")
    public void iTransactWriteWithConditionCheckOnKeyAndPutKeyWithDataInTable(String guardKey, String newKey, String data, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.transactWriteItems(r -> r.transactItems(
                TransactWriteItem.builder().conditionCheck(cc -> cc.tableName(tableName)
                    .key(Map.of("pk", AttributeValue.fromS(guardKey)))
                    .conditionExpression("attribute_exists(pk)")).build(),
                TransactWriteItem.builder().put(p -> p.tableName(tableName).item(Map.of(
                    "pk", AttributeValue.fromS(newKey),
                    "data", AttributeValue.fromS(data)
                ))).build()
            )));
        } catch (TransactionCanceledException e) {
            // TransactionCanceledException is a valid API response - treat as successful API call
            world.setSuccess(e);
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list tags of table {string}")
    public void iListTagsOfTable(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.listTagsOfResource(r -> r.resourceArn(tableArn(tableName))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I tag table {string} with key {string} and value {string}")
    public void iTagTableWithKeyAndValue(String tableName, String key, String value) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.tagResource(r -> r.resourceArn(tableArn(tableName))
                .tags(software.amazon.awssdk.services.dynamodb.model.Tag.builder().key(key).value(value).build())));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I untag table {string} removing key {string}")
    public void iUntagTableRemovingKey(String tableName, String key) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            world.setSuccess(client.untagResource(r -> r.resourceArn(tableArn(tableName)).tagKeys(key)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @Then("table {string} will exist")
    public void tableWillExist(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            ListTablesResponse r = client.listTables();
            assertTrue(r.tableNames().contains(tableName), "Expected table " + tableName + " to exist");
        }
    }

    @Then("table {string} will not appear in list-tables")
    public void tableWillNotAppearInListTables(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            ListTablesResponse r = client.listTables();
            assertFalse(r.tableNames().contains(tableName), "Expected table " + tableName + " to not appear");
        }
    }

    @Then("table {string} will have 0 items")
    public void tableWillHave0Items(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            ScanResponse r = client.scan(req -> req.tableName(tableName));
            assertEquals(0, r.count(), "Expected 0 items in table " + tableName);
        }
    }

    @Then("the table list will include {string}")
    public void theTableListWillInclude(String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            ListTablesResponse r = client.listTables();
            assertTrue(r.tableNames().contains(tableName), "Expected table " + tableName + " in list");
        }
    }

    @Then("item with key {string} in table {string} will have data {string}")
    public void itemWithKeyInTableWillHaveData(String pk, String tableName, String data) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            GetItemResponse r = client.getItem(req -> req.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk))));
            assertTrue(r.hasItem(), "Expected item with pk=" + pk);
            assertEquals(data, r.item().get("data").s());
        }
    }

    @Then("item with key {string} will not exist in table {string}")
    public void itemWithKeyWillNotExistInTable(String pk, String tableName) {
        try (DynamoDbClient client = world.dynamodbClient()) {
            GetItemResponse r = client.getItem(req -> req.tableName(tableName).key(Map.of("pk", AttributeValue.fromS(pk))));
            assertFalse(r.hasItem(), "Expected item with pk=" + pk + " to not exist");
        }
    }

    @Then("the output will contain item data {string}")
    public void theOutputWillContainItemData(String data) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof GetItemResponse r) {
            assertTrue(r.hasItem(), "Expected item in output");
            assertEquals(data, r.item().get("data").s());
        }
    }

    @Then("the output will contain table name {string}")
    public void theOutputWillContainTableName(String tableName) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof DescribeTableResponse r) {
            assertEquals(tableName, r.table().tableName());
        }
    }

    @Then("the query result will contain at least 1 item")
    public void theQueryResultWillContainAtLeast1Item() {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof QueryResponse r) {
            assertTrue(r.count() >= 1, "Expected at least 1 item in query result");
        }
    }

    @Then("the first query result will have data {string}")
    public void theFirstQueryResultWillHaveData(String data) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof QueryResponse r) {
            assertFalse(r.items().isEmpty(), "Expected query results");
            assertEquals(data, r.items().get(0).get("data").s());
        }
    }

    @Then("the scan result will contain at least 2 items")
    public void theScanResultWillContainAtLeast2Items() {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof ScanResponse r) {
            assertTrue(r.count() >= 2, "Expected at least 2 items in scan result");
        }
    }

    @Then("the scan result will include key {string}")
    public void theScanResultWillIncludeKey(String pk) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof ScanResponse r) {
            boolean found = r.items().stream().anyMatch(i -> pk.equals(i.getOrDefault("pk", AttributeValue.fromS("")).s()));
            assertTrue(found, "Expected key " + pk + " in scan result");
        }
    }

    @Then("the output will contain a TransactionCanceledException")
    public void theOutputWillContainATransactionCanceledException() {
        // The output should be a TransactionCanceledException (set as success via setSuccess)
        assertTrue(world.lastOutput instanceof TransactionCanceledException
            || (world.lastOutput != null && world.lastOutput.toString().contains("TransactionCancel")),
            "Expected output to contain a TransactionCanceledException but got: " + world.lastOutput);
    }
}
