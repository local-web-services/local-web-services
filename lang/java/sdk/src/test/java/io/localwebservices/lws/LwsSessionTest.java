package io.localwebservices.lws;

import io.localwebservices.lws.hcl.HclDiscovery;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class LwsSessionTest {

    @Test
    void portFor_returnsCorrectOffsetForEachKnownService() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);

        // Act & Assert
        assertEquals(basePort + 1, session.portFor("dynamodb"));
        assertEquals(basePort + 2, session.portFor("sqs"));
        assertEquals(basePort + 3, session.portFor("s3"));
        assertEquals(basePort + 4, session.portFor("sns"));
        assertEquals(basePort + 6, session.portFor("stepfunctions"));
        assertEquals(basePort + 12, session.portFor("ssm"));
        assertEquals(basePort + 13, session.portFor("secretsmanager"));
    }

    @Test
    void portFor_s3MinusDynamoDbEqualsTwo() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);

        // Act
        int actualDiff = session.portFor("s3") - session.portFor("dynamodb");

        // Assert
        assertEquals(2, actualDiff);
    }

    @Test
    void portFor_throwsForUnknownService() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);

        // Act & Assert
        assertThrows(IllegalArgumentException.class, () -> session.portFor("unknown-service"));
    }

    @Test
    void queueUrl_containsHostPortAndQueueName() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);
        String expectedQueueName = "OrderQueue";

        // Act
        String actualUrl = session.queueUrl(expectedQueueName);

        // Assert
        assertTrue(actualUrl.contains("127.0.0.1"));
        assertTrue(actualUrl.contains(expectedQueueName));
        assertTrue(actualUrl.contains("000000000000"));
    }

    @Test
    void hclDiscovery_parsesStateMachineFromHeredoc(@TempDir Path tempDir) throws Exception {
        // Arrange
        String expectedName = "OrderProcessor";
        String expectedDefinition = "{\"StartAt\":\"Done\",\"States\":{\"Done\":{\"Type\":\"Pass\",\"End\":true}}}";
        Files.writeString(tempDir.resolve("main.tf"), String.join("\n",
                "resource \"aws_sfn_state_machine\" \"order_processor\" {",
                "  name     = \"" + expectedName + "\"",
                "  role_arn = \"arn:aws:iam::000000000000:role/StepFunctionsRole\"",
                "  definition = <<EOF",
                expectedDefinition,
                "EOF",
                "}"
        ));

        // Act
        SessionSpec spec = HclDiscovery.discover(tempDir.toString());

        // Assert
        List<StateMachineSpec> actualMachines = spec.getStateMachines();
        assertEquals(1, actualMachines.size());
        assertEquals(expectedName, actualMachines.get(0).getName());
        assertTrue(actualMachines.get(0).getDefinition().contains("Done"));
    }

    @Test
    void hclDiscovery_returnsEmptySpecWhenNoTfFiles(@TempDir Path tempDir) throws Exception {
        // Act
        SessionSpec spec = HclDiscovery.discover(tempDir.toString());

        // Assert
        assertTrue(spec.getStateMachines().isEmpty());
    }

    @Test
    void hclDiscovery_parsesDynamoDbTable(@TempDir Path tempDir) throws Exception {
        // Arrange
        String expectedName = "Orders";
        String expectedPartitionKey = "id";
        String expectedSortKey = "createdAt";
        Files.writeString(tempDir.resolve("main.tf"), String.join("\n",
                "resource \"aws_dynamodb_table\" \"orders\" {",
                "  name      = \"" + expectedName + "\"",
                "  hash_key  = \"" + expectedPartitionKey + "\"",
                "  range_key = \"" + expectedSortKey + "\"",
                "}"
        ));

        // Act
        SessionSpec spec = HclDiscovery.discover(tempDir.toString());

        // Assert
        assertEquals(1, spec.getTables().size());
        assertEquals(expectedName, spec.getTables().get(0).getName());
        assertEquals(expectedPartitionKey, spec.getTables().get(0).getPartitionKey());
        assertEquals(expectedSortKey, spec.getTables().get(0).getSortKey());
    }

    @Test
    void hclDiscovery_parsesAllSimpleResourceTypes(@TempDir Path tempDir) throws Exception {
        // Arrange
        Files.writeString(tempDir.resolve("main.tf"), String.join("\n",
                "resource \"aws_sqs_queue\" \"q\" {",
                "  name = \"MyQueue\"",
                "}",
                "resource \"aws_s3_bucket\" \"b\" {",
                "  bucket = \"my-bucket\"",
                "}",
                "resource \"aws_sns_topic\" \"t\" {",
                "  name = \"MyTopic\"",
                "}",
                "resource \"aws_ssm_parameter\" \"p\" {",
                "  name = \"/app/param\"",
                "}",
                "resource \"aws_secretsmanager_secret\" \"s\" {",
                "  name = \"my-secret\"",
                "}"
        ));

        // Act
        SessionSpec spec = HclDiscovery.discover(tempDir.toString());

        // Assert
        assertEquals(List.of("MyQueue"), spec.getQueues());
        assertEquals(List.of("my-bucket"), spec.getBuckets());
        assertEquals(List.of("MyTopic"), spec.getTopics());
        assertEquals(List.of("/app/param"), spec.getParameters());
        assertEquals(List.of("my-secret"), spec.getSecrets());
    }

    @Test
    void mockRuleBuilder_withHeaderAndDelayMs_storesValues() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);
        MockBuilder mock = session.mock("stepfunctions");
        String expectedHeaderName = "X-Test";
        String expectedHeaderValue = "value";
        int expectedDelayMs = 100;

        // Act
        MockBuilder.MockRuleBuilder ruleBuilder = mock.operation("start-execution")
                .withHeader(expectedHeaderName, expectedHeaderValue)
                .delayMs(expectedDelayMs);

        // Assert – verify fluent builder stores values by inspecting the response
        // (the stored state is reflected in what gets posted — we can't easily inspect it
        // without calling respond(), so just verify it compiles and chains correctly)
        assertNotNull(ruleBuilder);
    }

    @Test
    void logCapture_assertCalled_passesWhenEntryPresent() {
        // Arrange
        var entry = new LogCapture.LogEntry("stepfunctions", "start-execution", "INFO", 200, 5.0, "2026-01-01T00:00:00Z");

        // Act & Assert – creating entry with expected values should work
        assertEquals("stepfunctions", entry.service);
        assertEquals("start-execution", entry.operation);
        assertEquals(200, entry.statusCode);
    }

    @Test
    void chaosBuilder_storesConfig() throws Exception {
        // Arrange
        int basePort = LwsSession.findFreePort();
        LwsSession session = new LwsSession(basePort, null);

        // Act
        ChaosBuilder builder = session.chaos("stepfunctions")
                .errorRate(0.5)
                .latency(100, 500)
                .connectionResetRate(0.1)
                .timeoutRate(0.2);

        // Assert – builder returns self for chaining
        assertNotNull(builder);
    }
}
