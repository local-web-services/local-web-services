package com.example.orders;

import io.cucumber.java.After;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.LogCapture;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.FakeBuilder;
import io.localwebservices.lws.SessionSpec;
import io.localwebservices.lws.StateMachineSpec;
import io.localwebservices.lws.TableSpec;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesRequest;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;
import software.amazon.awssdk.services.sfn.model.SfnException;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class OrderProcessorSteps {

    private static final String STATE_MACHINE_DEFINITION = """
            {
              "Comment": "Simple order processor — passes input through as output",
              "StartAt": "ProcessOrder",
              "States": {
                "ProcessOrder": {
                  "Type": "Pass",
                  "End": true
                }
              }
            }""";

    private LwsSession session;
    private SfnClient sfnClient;
    private String stateMachineArn;
    private String lastOutput;
    private Exception lastError;
    private LogCapture logCapture;
    private FakeBuilder sfnFakeBuilder;
    private String fakeExecutionArn;

    // Multi-order scenario state
    private List<String> processedOutputs;
    private List<String> processedIDs;

    // DynamoDB / SQS helpers
    private io.localwebservices.lws.DynamoDbHelper ddbHelper;
    private io.localwebservices.lws.SqsHelper sqsHelper;

    @After
    public void tearDown() throws Exception {
        if (logCapture != null) {
            logCapture.close();
            logCapture = null;
        }
        if (session != null) {
            session.close();
            session = null;
        }
    }

    // --- Session setup ---

    @Given("an OrderProcessor state machine is running")
    public void anOrderProcessorStateMachineIsRunning() throws Exception {
        session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))));
        sfnClient = session.sfnClient();
        stateMachineArn = resolveStateMachineArn(sfnClient);
    }

    @Given("no state machines are configured")
    public void noStateMachinesConfigured() throws Exception {
        session = LwsSession.create(SessionSpec.empty());
        sfnClient = session.sfnClient();
    }

    @Given("a session started from the {string} HCL directory")
    public void aSessionStartedFromHCLDirectory(String dir) throws Exception {
        session = LwsSession.fromHcl(dir);
        sfnClient = session.sfnClient();
        stateMachineArn = resolveStateMachineArn(sfnClient);
    }

    @Given("a DynamoDB table {string} with partition key {string}")
    public void aDynamoDBTableWithPartitionKey(String tableName, String partitionKey) throws Exception {
        session = LwsSession.create(new SessionSpec()
                .tables(List.of(new TableSpec(tableName, partitionKey))));
        ddbHelper = session.dynamoDb(tableName);
    }

    @Given("an SQS queue named {string}")
    public void anSQSQueueNamed(String queueName) throws Exception {
        session = LwsSession.create(new SessionSpec()
                .queues(List.of(queueName)));
        sqsHelper = session.sqs(queueName);
    }

    // --- Fake steps ---

    @And("StartExecution is faked to return execution ARN {string}")
    public void startExecutionFakedReturnArn(String executionArn) throws Exception {
        fakeExecutionArn = executionArn;
        sfnFakeBuilder = session.fake("stepfunctions")
                .operation("start-execution").respond(200, Map.of(
                        "executionArn", executionArn,
                        "startDate", 1704067200.0));
    }

    @And("DescribeExecution is faked to return SUCCEEDED with output containing order ID {string}")
    public void describeExecutionFakedSucceeded(String orderId) throws Exception {
        String stateMachineArnForFake = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";
        sfnFakeBuilder.operation("describe-execution").respond(200, Map.of(
                "executionArn", fakeExecutionArn,
                "stateMachineArn", stateMachineArnForFake,
                "name", "fake-exec",
                "status", "SUCCEEDED",
                "startDate", 1704067200.0,
                "output", "{\"orderId\":\"" + orderId + "\"}"));
    }

    @And("StartExecution is faked to return error {string}")
    public void startExecutionFakedError(String errorCode) throws Exception {
        session.fake("stepfunctions")
                .operation("start-execution").error(errorCode,
                        "Injected error for testing");
    }

    @And("StartExecution is faked with a 10ms delay returning execution ARN {string}")
    public void startExecutionFakedWithDelay(String executionArn) throws Exception {
        fakeExecutionArn = executionArn;
        sfnFakeBuilder = session.fake("stepfunctions")
                .operation("start-execution").delayMs(10).respond(200, Map.of(
                        "executionArn", executionArn,
                        "startDate", 1704067200.0));
    }

    // --- IAM steps ---

    @And("IAM is in enforce mode with identity {string} allowed all actions on all resources")
    public void iamEnforceModeWithIdentity(String identity) throws Exception {
        session.iam()
                .mode("enforce")
                .defaultIdentity(identity)
                .identity(identity)
                    .allow(List.of("*"), "*")
                    .apply()
                .apply();
    }

    // --- Chaos steps ---

    @And("stepfunctions chaos is set to 100% error rate")
    public void stepfunctionsChaos100Percent() throws Exception {
        session.chaos("stepfunctions").errorRate(1.0).apply();
    }

    // --- Action steps ---

    @When("I process order {string}")
    public void iProcessOrder(String orderId) {
        OrderProcessor processor = new OrderProcessor(sfnClient);
        try {
            lastOutput = processor.processOrder(orderId, stateMachineArn);
            lastError = null;
        } catch (Exception e) {
            lastOutput = null;
            lastError = e;
        }
    }

    @When("I process order {string} via ARN {string}")
    public void iProcessOrderViaArn(String orderId, String arn) {
        OrderProcessor processor = new OrderProcessor(sfnClient);
        try {
            lastOutput = processor.processOrder(orderId, arn);
            lastError = null;
        } catch (Exception e) {
            lastOutput = null;
            lastError = e;
        }
    }

    @When("I process orders {string}, {string}, {string}")
    public void iProcessMultipleOrders(String first, String second, String third) throws Exception {
        OrderProcessor processor = new OrderProcessor(sfnClient);
        processedOutputs = new ArrayList<>();
        processedIDs = List.of(first, second, third);
        for (String id : processedIDs) {
            String output = processor.processOrder(id, stateMachineArn);
            processedOutputs.add(output);
        }
    }

    @And("order {string} has been processed")
    public void orderHasBeenProcessed(String orderId) throws Exception {
        OrderProcessor processor = new OrderProcessor(sfnClient);
        processor.processOrder(orderId, stateMachineArn);
    }

    @When("I reset the session")
    public void iResetTheSession() throws Exception {
        session.reset();
    }

    @And("log capture is active")
    public void logCaptureIsActive() throws Exception {
        logCapture = session.startLogCapture();
    }

    @When("I start log capture and process order {string}")
    public void iStartLogCaptureAndProcessOrder(String orderId) throws Exception {
        logCapture = session.startLogCapture();
        OrderProcessor processor = new OrderProcessor(sfnClient);
        try {
            lastOutput = processor.processOrder(orderId, stateMachineArn);
            lastError = null;
        } catch (Exception e) {
            lastOutput = null;
            lastError = e;
        }
    }

    @When("I put item with orderId {string} and status {string} into {string}")
    public void iPutItemWithOrderIdAndStatus(String orderId, String status, String tableName) throws Exception {
        ddbHelper.put(Map.of(
                "orderId", AttributeValue.fromS(orderId),
                "status", AttributeValue.fromS(status)));
    }

    @When("I send message body {string} to {string}")
    public void iSendMessageBody(String body, String queueName) throws Exception {
        sqsHelper.send(body);
    }

    // --- Assertion steps ---

    @Then("the output will contain order ID {string}")
    public void theOutputWillContainOrderID(String expectedOrderId) {
        assertNull(lastError, "expected no error but got: " + lastError);
        assertNotNull(lastOutput, "expected non-nil output");
        assertTrue(lastOutput.contains(expectedOrderId),
                "output does not contain orderId " + expectedOrderId + ": " + lastOutput);
    }

    @Then("each output will contain the corresponding order ID")
    public void eachOutputWillContainCorrespondingOrderID() {
        assertNotNull(processedOutputs, "no outputs recorded");
        assertEquals(processedIDs.size(), processedOutputs.size(),
                "output count mismatch");
        for (int i = 0; i < processedIDs.size(); i++) {
            String expectedId = processedIDs.get(i);
            String output = processedOutputs.get(i);
            assertTrue(output.contains(expectedId),
                    "output[" + i + "] does not contain orderId " + expectedId + ": " + output);
        }
    }

    @Then("an AWS error is returned")
    public void anAWSErrorIsReturned() {
        assertNotNull(lastError, "expected an AWS error but got nil; output: " + lastOutput);
    }

    @Then("the session accepts a second reset without error")
    public void theSessionAcceptsASecondResetWithoutError() throws Exception {
        session.reset();
    }

    @Then("the log capture will have recorded a {string} {string} call")
    public void theLogCaptureWillHaveRecorded(String service, String operation) {
        assertNotNull(logCapture, "log capture is not active");
        Instant deadline = Instant.now().plusSeconds(5);
        while (Instant.now().isBefore(deadline)) {
            for (LogCapture.LogEntry e : logCapture.getEntries()) {
                if (service.equals(e.service) && operation.equals(e.operation)) {
                    return;
                }
            }
            try { Thread.sleep(50); } catch (InterruptedException ex) { Thread.currentThread().interrupt(); break; }
        }
        throw new AssertionError("log capture: expected call to " + service + "/" + operation + " but none was recorded");
    }

    @And("no errors will appear in the log capture")
    public void noErrorsWillAppearInLogCapture() {
        assertNotNull(logCapture, "log capture is not active");
        logCapture.assertNoErrors();
    }

    @Then("recent logs will be non-empty")
    public void recentLogsWillBeNonEmpty() {
        List<LogCapture.LogEntry> logs = session.recentLogs();
        assertFalse(logs.isEmpty(), "expected non-empty recent logs after activity");
    }

    @And("filtering logs by service {string} will return entries")
    public void filteringLogsByServiceWillReturnEntries(String service) {
        assertNotNull(logCapture, "log capture is not active");
        List<LogCapture.LogEntry> entries = logCapture.forService(service);
        assertFalse(entries.isEmpty(),
                "expected forService('" + service + "') to return entries but got none");
    }

    @And("filtering logs by operation {string} will return entries")
    public void filteringLogsByOperationWillReturnEntries(String operation) {
        assertNotNull(logCapture, "log capture is not active");
        List<LogCapture.LogEntry> entries = logCapture.forOperation(operation);
        assertFalse(entries.isEmpty(),
                "expected forOperation('" + operation + "') to return entries but got none");
    }

    @Then("the table {string} will contain {int} item")
    public void theTableWillContainNItems(String tableName, int expected) {
        ddbHelper.assertItemCount(expected);
    }

    @And("the table {string} will contain an item with orderId {string}")
    public void theTableWillContainItemWithOrderId(String tableName, String orderId) {
        ddbHelper.assertItemExists(Map.of("orderId", AttributeValue.fromS(orderId)));
    }

    @Then("receiving {int} message from {string} will return body {string}")
    public void receivingMessageWillReturnBody(int count, String queueName, String expectedBody) throws Exception {
        var msgs = sqsHelper.receive(count);
        assertEquals(count, msgs.size(),
                "expected " + count + " message(s), got " + msgs.size());
        assertEquals(expectedBody, msgs.get(0).body(),
                "message body mismatch");
    }

    // --- Helpers ---

    private static String resolveStateMachineArn(SfnClient sfnClient) {
        ListStateMachinesResponse result = sfnClient.listStateMachines(
                ListStateMachinesRequest.builder().build());
        if (result.stateMachines().isEmpty()) {
            throw new IllegalStateException("No state machines found in local session");
        }
        return result.stateMachines().get(0).stateMachineArn();
    }
}
