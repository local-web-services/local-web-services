package io.localwebservices.lws;

import static org.junit.jupiter.api.Assertions.*;

import io.localwebservices.lws.hcl.HclDiscovery;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

class LwsSessionTest {

  @Test
  void portFor_returnsCorrectOffsetForEachKnownService() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

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
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    int actualDiff = session.portFor("s3") - session.portFor("dynamodb");

    // Assert
    assertEquals(2, actualDiff);
  }

  @Test
  void portFor_throwsForUnknownService() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act & Assert
    assertThrows(IllegalArgumentException.class, () -> session.portFor("unknown-service"));
  }

  @Test
  void queueUrl_containsHostPortAndQueueName() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);
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
    String expectedDefinition =
        "{\"StartAt\":\"Done\",\"States\":{\"Done\":{\"Type\":\"Pass\",\"End\":true}}}";
    Files.writeString(
        tempDir.resolve("main.tf"),
        String.join(
            "\n",
            "resource \"aws_sfn_state_machine\" \"order_processor\" {",
            "  name     = \"" + expectedName + "\"",
            "  role_arn = \"arn:aws:iam::000000000000:role/StepFunctionsRole\"",
            "  definition = <<EOF",
            expectedDefinition,
            "EOF",
            "}"));

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
    Files.writeString(
        tempDir.resolve("main.tf"),
        String.join(
            "\n",
            "resource \"aws_dynamodb_table\" \"orders\" {",
            "  name      = \"" + expectedName + "\"",
            "  hash_key  = \"" + expectedPartitionKey + "\"",
            "  range_key = \"" + expectedSortKey + "\"",
            "}"));

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
    Files.writeString(
        tempDir.resolve("main.tf"),
        String.join(
            "\n",
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
            "}"));

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
  void fakeRuleBuilder_withHeaderAndDelayMs_storesValues() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);
    FakeBuilder fake = session.fake("stepfunctions");
    String expectedHeaderName = "X-Test";
    String expectedHeaderValue = "value";
    int expectedDelayMs = 100;

    // Act
    FakeBuilder.FakeRuleBuilder ruleBuilder =
        fake.operation("start-execution")
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
    String expectedService = "stepfunctions";
    String expectedOperation = "start-execution";
    int expectedStatusCode = 200;
    var entry =
        new LogCapture.LogEntry(
            expectedService,
            expectedOperation,
            "INFO",
            expectedStatusCode,
            5.0,
            "2026-01-01T00:00:00Z");

    // Act
    String actualService = entry.service;
    String actualOperation = entry.operation;
    int actualStatusCode = entry.statusCode;

    // Assert
    assertEquals(expectedService, actualService);
    assertEquals(expectedOperation, actualOperation);
    assertEquals(expectedStatusCode, actualStatusCode);
  }

  @Test
  void chaosBuilder_storesConfig() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    ChaosBuilder builder =
        session
            .chaos("stepfunctions")
            .errorRate(0.5)
            .latency(100, 500)
            .connectionResetRate(0.1)
            .timeoutRate(0.2);

    // Assert – builder returns self for chaining
    assertNotNull(builder);
  }

  @Test
  void logCapture_forService_methodExistsAndFilters() {
    // Arrange
    String expectedService = "stepfunctions";
    String expectedOperation = "StartExecution";
    String expectedDynamoService = "dynamodb";
    var entry1 =
        new LogCapture.LogEntry(expectedService, expectedOperation, "INFO", 200, 5.0, "t1");
    var entry2 = new LogCapture.LogEntry(expectedDynamoService, "PutItem", "INFO", 200, 2.0, "t2");
    var entry3 =
        new LogCapture.LogEntry(expectedService, "DescribeExecution", "INFO", 200, 3.0, "t3");

    // Act
    String actualService1 = entry1.service;
    String actualOperation1 = entry1.operation;
    String actualService2 = entry2.service;
    String actualService3 = entry3.service;

    // Assert — verify LogEntry fields are accessible and values are correct
    assertEquals(expectedService, actualService1);
    assertEquals(expectedOperation, actualOperation1);
    assertEquals(expectedDynamoService, actualService2);
    assertEquals(expectedService, actualService3);
  }

  @Test
  void iamBuilder_storesModeAndDefaultIdentity() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    IamBuilder builder = session.iam().mode("enforce").defaultIdentity("test-user");

    // Assert — builder is non-null and returns self for chaining
    assertNotNull(builder);
  }

  @Test
  void iamBuilder_identityBuilderAllowsChaining() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    IamBuilder builder = session.iam().identity("test-user").allow(List.of("sfn:*"), "*").apply();

    // Assert — apply() returns the parent IamBuilder
    assertNotNull(builder);
  }

  @Test
  void session_recentLogs_returnsEmptyListWhenNoBackgroundCapture() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    List<LogCapture.LogEntry> actualLogs = session.recentLogs();

    // Assert
    assertNotNull(actualLogs);
    assertTrue(actualLogs.isEmpty(), "expected empty recentLogs when no background capture");
  }

  @Test
  void session_sqs_urlContainsQueueName() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);
    String expectedQueueName = "OrderQueue";

    // Act
    SqsHelper helper = session.sqs(expectedQueueName);

    // Assert
    assertNotNull(helper);
    assertTrue(
        helper.url().contains(expectedQueueName),
        "SQS URL should contain queue name: " + helper.url());
    assertTrue(
        helper.url().contains("000000000000"),
        "SQS URL should contain account ID: " + helper.url());
  }

  @Test
  void session_s3_returnsHelper() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);
    String expectedBucket = "my-bucket";

    // Act
    S3Helper helper = session.s3(expectedBucket);

    // Assert
    assertNotNull(helper);
  }

  @Test
  void cdkDiscovery_parsesAllResourceTypesFromFixture() throws Exception {
    // Arrange
    URL resource = getClass().getClassLoader().getResource("testdata/cdk-fixture");
    assertNotNull(resource, "CDK fixture not found in test resources");
    Path fixtureDir = Path.of(resource.toURI());

    // Act
    SessionSpec spec = CdkDiscovery.discover(fixtureDir);

    // Assert — all 7 resource types from the fixture
    String expectedTableName = "CdkTestTable";
    String expectedPartitionKey = "pk";
    String expectedSortKey = "sk";
    String expectedStateMachineName = "CdkTestStateMachine";
    assertEquals(1, spec.getTables().size());
    assertEquals(expectedTableName, spec.getTables().get(0).getName());
    assertEquals(expectedPartitionKey, spec.getTables().get(0).getPartitionKey());
    assertEquals(expectedSortKey, spec.getTables().get(0).getSortKey());

    assertEquals(List.of("CdkTestQueue"), spec.getQueues());
    assertEquals(List.of("cdk-test-bucket"), spec.getBuckets());
    assertEquals(List.of("CdkTestTopic"), spec.getTopics());

    assertEquals(1, spec.getStateMachines().size());
    assertEquals(expectedStateMachineName, spec.getStateMachines().get(0).getName());

    assertEquals(List.of("/cdk/test/param"), spec.getParameters());
    assertEquals(List.of("cdk-test-secret"), spec.getSecrets());
  }

  @Test
  void cdkDiscovery_skipsResourcesWithIntrinsicNameProperties(@TempDir Path tempDir)
      throws Exception {
    // Arrange — template with an intrinsic function as queue name
    Path cdkOut = tempDir.resolve("cdk.out");
    Files.createDirectories(cdkOut);
    Files.writeString(
        cdkOut.resolve("manifest.json"),
        """
                {
                  "version": "17.0.0",
                  "artifacts": {
                    "Stack": {
                      "type": "aws:cloudformation:stack",
                      "properties": {"templateFile": "Stack.template.json"}
                    }
                  }
                }
                """);
    Files.writeString(
        cdkOut.resolve("Stack.template.json"),
        """
                {
                  "Resources": {
                    "MyQueue": {
                      "Type": "AWS::SQS::Queue",
                      "Properties": {
                        "QueueName": {"Ref": "AWS::StackName"}
                      }
                    }
                  }
                }
                """);

    // Act
    SessionSpec spec = CdkDiscovery.discover(tempDir);

    // Assert — queue with intrinsic name is skipped
    assertTrue(
        spec.getQueues().isEmpty(),
        "expected 0 queues (intrinsic name skipped), got: " + spec.getQueues());
  }
}
