package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.DynamoDbHelper;
import io.localwebservices.lws.SqsHelper;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.sqs.model.Message;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class HelperSteps {

    private final WorldContext world;

    public HelperSteps(WorldContext world) {
        this.world = world;
    }

    // ---- dynamodb_helper.feature ----

    @When("I put item with orderId {string} and status {string} into {string}")
    public void iPutItemWithOrderIdAndStatusInto(String orderId, String status, String tableName) {
        world.session.dynamoDb(tableName).put(Map.of(
                "orderId", AttributeValue.fromS(orderId),
                "status",  AttributeValue.fromS(status)));
    }

    @Then("the table {string} will contain {int} item")
    public void theTableWillContainOneItem(String tableName, int expectedCount) {
        world.session.dynamoDb(tableName).assertItemCount(expectedCount);
    }

    @Then("the table {string} will contain {int} items")
    public void theTableWillContainItems(String tableName, int expectedCount) {
        world.session.dynamoDb(tableName).assertItemCount(expectedCount);
    }

    @Then("the table {string} will contain an item with orderId {string}")
    public void theTableWillContainAnItemWithOrderId(String tableName, String orderId) {
        world.session.dynamoDb(tableName).assertItemExists(
                Map.of("orderId", AttributeValue.fromS(orderId)));
    }

    @Then("the table {string} will not contain an item with orderId {string}")
    public void theTableWillNotContainAnItemWithOrderId(String tableName, String orderId) {
        DynamoDbHelper helper = world.session.dynamoDb(tableName);
        Map<String, AttributeValue> item = helper.get(
                Map.of("orderId", AttributeValue.fromS(orderId)));
        assertTrue(item == null || item.isEmpty(),
                "expected no item with orderId '" + orderId + "' but found one");
    }

    // ---- sqs_helper.feature ----

    @When("I send message body {string} to {string}")
    public void iSendMessageBodyTo(String body, String queueName) {
        world.session.sqs(queueName).send(body);
    }

    @Then("receiving {int} message from {string} returns body {string}")
    public void receivingMessageFromReturnsBody(int count, String queueName, String expectedBody) {
        SqsHelper helper = world.session.sqs(queueName);
        List<Message> messages = helper.receive(count);
        assertFalse(messages.isEmpty(), "expected at least one message from '" + queueName + "'");
        String actualBody = messages.get(0).body();
        assertEquals(expectedBody, actualBody,
                "expected message body '" + expectedBody + "' but got '" + actualBody + "'");
    }

    @When("I receive {int} message from {string}")
    public void iReceiveMessageFrom(int count, String queueName) {
        SqsHelper helper = world.session.sqs(queueName);
        world.lastMessages = helper.receive(count);
        world.lastMessageCount = world.lastMessages.size();
    }

    @Then("exactly {int} message is returned")
    public void exactlyMessageIsReturned(int expectedCount) {
        assertEquals(expectedCount, world.lastMessageCount,
                "expected " + expectedCount + " messages but got " + world.lastMessageCount);
    }
}
