package com.example.orders;

import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.MockBuilder;
import io.localwebservices.lws.SessionSpec;
import io.localwebservices.lws.StateMachineSpec;
import org.junit.jupiter.api.Test;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.SfnException;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesRequest;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class OrderProcessorTest {

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

    @Test
    void processOrder_runsStateMachineAndReturnsResult() throws Exception {
        // Arrange — start ldk with an explicit state machine spec
        try (LwsSession session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))))) {
            SfnClient sfnClient = session.sfnClient();
            String stateMachineArn = resolveStateMachineArn(sfnClient);
            OrderProcessor processor = new OrderProcessor(sfnClient);
            String expectedOrderId = "order-001";

            // Act
            String actualOutput = processor.processOrder(expectedOrderId, stateMachineArn);

            // Assert
            assertNotNull(actualOutput);
            assertTrue(actualOutput.contains(expectedOrderId));
        }
    }

    @Test
    void processOrder_handlesMultipleOrders() throws Exception {
        // Arrange — start ldk with an explicit state machine spec
        try (LwsSession session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))))) {
            SfnClient sfnClient = session.sfnClient();
            String stateMachineArn = resolveStateMachineArn(sfnClient);
            OrderProcessor processor = new OrderProcessor(sfnClient);
            String expectedFirstOrderId = "order-101";
            String expectedSecondOrderId = "order-102";
            String expectedThirdOrderId = "order-103";

            // Act
            String actualFirstOutput = processor.processOrder(expectedFirstOrderId, stateMachineArn);
            String actualSecondOutput = processor.processOrder(expectedSecondOrderId, stateMachineArn);
            String actualThirdOutput = processor.processOrder(expectedThirdOrderId, stateMachineArn);

            // Assert
            assertTrue(actualFirstOutput.contains(expectedFirstOrderId));
            assertTrue(actualSecondOutput.contains(expectedSecondOrderId));
            assertTrue(actualThirdOutput.contains(expectedThirdOrderId));
        }
    }

    @Test
    void processOrder_returnsErrorForUnknownStateMachine() throws Exception {
        // Arrange — start ldk with no state machines declared
        try (LwsSession session = LwsSession.create(SessionSpec.empty())) {
            SfnClient sfnClient = session.sfnClient();
            OrderProcessor processor = new OrderProcessor(sfnClient);
            String nonExistentArn = "arn:aws:states:us-east-1:000000000000:stateMachine:DoesNotExist";

            // Act + Assert — production code should propagate the AWS error, not swallow it
            assertThrows(SfnException.class, () ->
                    processor.processOrder("order-999", nonExistentArn));
        }
    }

    @Test
    void processOrder_usingTerraformDefinition() throws Exception {
        // Arrange — start ldk from the Terraform config; it reads terraform/main.tf
        // and provisions the OrderProcessor state machine automatically
        try (LwsSession session = LwsSession.fromHcl("terraform")) {
            SfnClient sfnClient = session.sfnClient();
            String stateMachineArn = resolveStateMachineArn(sfnClient);
            OrderProcessor processor = new OrderProcessor(sfnClient);
            String expectedOrderId = "order-tf";

            // Act
            String actualOutput = processor.processOrder(expectedOrderId, stateMachineArn);

            // Assert
            assertNotNull(actualOutput);
            assertTrue(actualOutput.contains(expectedOrderId));
        }
    }

    @Test
    void processOrder_withMockedSuccessResponse() throws Exception {
        // Arrange — start ldk with no state machines; we will mock the SFN calls
        try (LwsSession session = LwsSession.create(SessionSpec.empty())) {
            SfnClient sfnClient = session.sfnClient();
            OrderProcessor processor = new OrderProcessor(sfnClient);

            String expectedOrderId = "order-mock";
            String expectedExecutionArn = "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:mock-exec";
            String expectedStateMachineArn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";

            // Mock StartExecution to return a pre-defined execution ARN
            MockBuilder sfnMock = session.mock("stepfunctions")
                    .operation("start-execution").respond(200, Map.of(
                            "executionArn", expectedExecutionArn,
                            "startDate", 1704067200.0));

            // Mock DescribeExecution to return SUCCEEDED with the order in the output
            sfnMock.operation("describe-execution").respond(200, Map.of(
                    "executionArn", expectedExecutionArn,
                    "stateMachineArn", expectedStateMachineArn,
                    "name", "mock-exec",
                    "status", "SUCCEEDED",
                    "startDate", 1704067200.0,
                    "output", "{\"orderId\":\"order-mock\"}"));

            // Act
            String actualOutput = processor.processOrder(expectedOrderId, expectedStateMachineArn);

            // Assert
            assertNotNull(actualOutput);
            assertTrue(actualOutput.contains(expectedOrderId));

            // Cleanup — clear mocks so subsequent tests are unaffected
            sfnMock.clear();
        }
    }

    @Test
    void processOrder_withInjectedError() throws Exception {
        // Arrange — start ldk with no state machines; we will inject an error
        try (LwsSession session = LwsSession.create(SessionSpec.empty())) {
            SfnClient sfnClient = session.sfnClient();
            OrderProcessor processor = new OrderProcessor(sfnClient);
            String expectedStateMachineArn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";

            // Mock StartExecution to return an AWS error
            MockBuilder sfnMock = session.mock("stepfunctions")
                    .operation("start-execution").error(
                            "ExecutionLimitExceeded",
                            "You have exceeded the maximum number of running executions.");

            // Act + Assert — production code should propagate the AWS error
            assertThrows(SfnException.class, () ->
                    processor.processOrder("order-999", expectedStateMachineArn));

            // Cleanup — clear mocks so subsequent tests are unaffected
            sfnMock.clear();
        }
    }

    @Test
    void processOrder_withMockDelayAndHeader() throws Exception {
        // Arrange — start ldk with no state machines; mock with delay
        try (LwsSession session = LwsSession.create(SessionSpec.empty())) {
            SfnClient sfnClient = session.sfnClient();
            OrderProcessor processor = new OrderProcessor(sfnClient);

            String expectedOrderId = "order-header";
            String expectedExecutionArn = "arn:aws:states:us-east-1:000000000000:execution:OrderProcessor:header-exec";
            String expectedStateMachineArn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor";

            // Mock StartExecution with a 10ms delay
            MockBuilder sfnMock = session.mock("stepfunctions")
                    .operation("start-execution").delayMs(10).respond(200, Map.of(
                            "executionArn", expectedExecutionArn,
                            "startDate", 1704067200.0));

            sfnMock.operation("describe-execution").respond(200, Map.of(
                    "executionArn", expectedExecutionArn,
                    "stateMachineArn", expectedStateMachineArn,
                    "name", "header-exec",
                    "status", "SUCCEEDED",
                    "startDate", 1704067200.0,
                    "output", "{\"orderId\":\"order-header\"}"));

            // Act
            String actualOutput = processor.processOrder(expectedOrderId, expectedStateMachineArn);

            // Assert
            assertNotNull(actualOutput);
            assertTrue(actualOutput.contains(expectedOrderId));

            sfnMock.clear();
        }
    }

    @Test
    void processOrder_resetClearsState() throws Exception {
        // Arrange — start ldk with a state machine and run an execution
        try (LwsSession session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))))) {
            SfnClient sfnClient = session.sfnClient();
            String stateMachineArn = resolveStateMachineArn(sfnClient);
            OrderProcessor processor = new OrderProcessor(sfnClient);

            // Act — run an execution before reset
            processor.processOrder("order-before-reset", stateMachineArn);

            // Act — reset state
            session.reset();

            // Assert — session is still functional after reset (no exception thrown)
            session.reset();
        }
    }

    @Test
    void processOrder_chaosInjectsErrors() throws Exception {
        // Arrange — start ldk with a state machine
        try (LwsSession session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))))) {
            SfnClient sfnClient = session.sfnClient();
            String stateMachineArn = resolveStateMachineArn(sfnClient);
            OrderProcessor processor = new OrderProcessor(sfnClient);

            // Act — enable chaos with 100% error rate
            session.chaos("stepfunctions").errorRate(1.0).apply();

            // Act — attempt to process order under chaos
            Exception chaosErr = null;
            try {
                processor.processOrder("order-chaos", stateMachineArn);
            } catch (Exception e) {
                chaosErr = e;
            } finally {
                session.chaos("stepfunctions").clear();
            }

            // Assert — chaos should have caused an error
            assertNotNull(chaosErr, "expected an error under 100% error rate chaos");
        }
    }

    @Test
    void processOrder_logCaptureRecordsStartExecution() throws Exception {
        // Arrange — start ldk with a state machine and log capture
        try (LwsSession session = LwsSession.create(new SessionSpec()
                .stateMachines(List.of(new StateMachineSpec("OrderProcessor", STATE_MACHINE_DEFINITION))))) {
            try (io.localwebservices.lws.LogCapture logs = session.startLogCapture()) {
                SfnClient sfnClient = session.sfnClient();
                String stateMachineArn = resolveStateMachineArn(sfnClient);
                OrderProcessor processor = new OrderProcessor(sfnClient);

                // Act
                processor.processOrder("order-logged", stateMachineArn);

                // Assert — start-execution should have been logged
                logs.assertCalled("stepfunctions", "StartExecution");
                logs.assertNoErrors();
            }
        }
    }

    private static String resolveStateMachineArn(SfnClient sfnClient) {
        ListStateMachinesResponse result = sfnClient.listStateMachines(
                ListStateMachinesRequest.builder().build());
        if (result.stateMachines().isEmpty()) {
            throw new IllegalStateException("No state machines found in local session");
        }
        return result.stateMachines().get(0).stateMachineArn();
    }
}
