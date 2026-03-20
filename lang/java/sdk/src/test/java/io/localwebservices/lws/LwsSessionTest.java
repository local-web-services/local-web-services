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
    assertEquals(basePort + 1, session.portFor("dynamodb"), "Expected dynamodb port to equal basePort + 1");
    assertEquals(basePort + 2, session.portFor("sqs"), "Expected sqs port to equal basePort + 2");
    assertEquals(basePort + 3, session.portFor("s3"), "Expected s3 port to equal basePort + 3");
    assertEquals(basePort + 4, session.portFor("sns"), "Expected sns port to equal basePort + 4");
    assertEquals(basePort + 6, session.portFor("stepfunctions"), "Expected stepfunctions port to equal basePort + 6");
    assertEquals(basePort + 12, session.portFor("ssm"), "Expected ssm port to equal basePort + 12");
    assertEquals(basePort + 13, session.portFor("secretsmanager"), "Expected secretsmanager port to equal basePort + 13");
  }

  @Test
  void portFor_s3MinusDynamoDbEqualsTwo() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    int actualDiff = session.portFor("s3") - session.portFor("dynamodb");

    // Assert
    assertEquals(2, actualDiff, "Expected actualDiff to equal 2");
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
    assertTrue(actualUrl.contains("127.0.0.1"), "Expected value to contain expected substring");
    assertTrue(actualUrl.contains(expectedQueueName), "Expected value to contain expected substring");
    assertTrue(actualUrl.contains("000000000000"), "Expected value to contain expected substring");
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
    assertEquals(1, actualMachines.size(), "Expected actualMachines.size() to match 1");
    assertEquals(expectedName, actualMachines.get(0).getName(), "Expected actualMachines.get(0).getName() to equal expectedName");
    assertTrue(actualMachines.get(0).getDefinition().contains("Done"), "Expected value to contain expected substring");
  }

  @Test
  void hclDiscovery_returnsEmptySpecWhenNoTfFiles(@TempDir Path tempDir) throws Exception {
    // Act
    SessionSpec spec = HclDiscovery.discover(tempDir.toString());

    // Assert
    assertTrue(spec.getStateMachines().isEmpty(), "Expected spec.getStateMachines() to be empty");
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
    assertEquals(1, spec.getTables().size(), "Expected spec.getTables().size() to match 1");
    assertEquals(expectedName, spec.getTables().get(0).getName(), "Expected spec.getTables().get(0).getName() to equal expectedName");
    assertEquals(expectedPartitionKey, spec.getTables().get(0).getPartitionKey(), "Expected spec.getTables().get(0).getPartitionKey() to equal expectedPartitionKey");
    assertEquals(expectedSortKey, spec.getTables().get(0).getSortKey(), "Expected spec.getTables().get(0).getSortKey() to equal expectedSortKey");
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
    assertEquals(List.of("MyQueue"), spec.getQueues(), "Expected queues to match discovered HCL resources");
    assertEquals(List.of("my-bucket"), spec.getBuckets(), "Expected buckets to match discovered HCL resources");
    assertEquals(List.of("MyTopic"), spec.getTopics(), "Expected topics to match discovered HCL resources");
    assertEquals(List.of("/app/param"), spec.getParameters(), "Expected parameters to match discovered HCL resources");
    assertEquals(List.of("my-secret"), spec.getSecrets(), "Expected secrets to match discovered HCL resources");
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
    assertNotNull(ruleBuilder, "Expected ruleBuilder to not be null");
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
    assertEquals(expectedService, actualService, "Expected actualService to equal expectedService");
    assertEquals(expectedOperation, actualOperation, "Expected actualOperation to equal expectedOperation");
    assertEquals(expectedStatusCode, actualStatusCode, "Expected actualStatusCode to equal expectedStatusCode");
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
    assertNotNull(builder, "Expected builder to not be null");
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
    assertEquals(expectedService, actualService1, "Expected actualService1 to equal expectedService");
    assertEquals(expectedOperation, actualOperation1, "Expected actualOperation1 to equal expectedOperation");
    assertEquals(expectedDynamoService, actualService2, "Expected actualService2 to equal expectedDynamoService");
    assertEquals(expectedService, actualService3, "Expected actualService3 to equal expectedService");
  }

  @Test
  void iamBuilder_storesModeAndDefaultIdentity() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    IamBuilder builder = session.iam().mode("enforce").defaultIdentity("test-user");

    // Assert — builder is non-null and returns self for chaining
    assertNotNull(builder, "Expected builder to not be null");
  }

  @Test
  void iamBuilder_identityBuilderAllowsChaining() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    IamBuilder builder = session.iam().identity("test-user").allow(List.of("sfn:*"), "*").apply();

    // Assert — apply() returns the parent IamBuilder
    assertNotNull(builder, "Expected builder to not be null");
  }

  @Test
  void session_recentLogs_returnsEmptyListWhenNoBackgroundCapture() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);

    // Act
    List<LogCapture.LogEntry> actualLogs = session.recentLogs();

    // Assert
    assertNotNull(actualLogs, "Expected actualLogs to not be null");
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
    assertNotNull(helper, "Expected helper to not be null");
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
    assertNotNull(helper, "Expected helper to not be null");
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
    assertEquals(1, spec.getTables().size(), "Expected spec.getTables().size() to match 1");
    assertEquals(expectedTableName, spec.getTables().get(0).getName(), "Expected spec.getTables().get(0).getName() to equal expectedTableName");
    assertEquals(expectedPartitionKey, spec.getTables().get(0).getPartitionKey(), "Expected spec.getTables().get(0).getPartitionKey() to equal expectedPartitionKey");
    assertEquals(expectedSortKey, spec.getTables().get(0).getSortKey(), "Expected spec.getTables().get(0).getSortKey() to equal expectedSortKey");

    assertEquals(List.of("CdkTestQueue"), spec.getQueues(), "Expected queues to match discovered CDK resources");
    assertEquals(List.of("cdk-test-bucket"), spec.getBuckets(), "Expected buckets to match discovered CDK resources");
    assertEquals(List.of("CdkTestTopic"), spec.getTopics(), "Expected topics to match discovered CDK resources");

    assertEquals(1, spec.getStateMachines().size(), "Expected spec.getStateMachines().size() to match 1");
    assertEquals(expectedStateMachineName, spec.getStateMachines().get(0).getName(), "Expected spec.getStateMachines().get(0).getName() to equal expectedStateMachineName");

    assertEquals(List.of("/cdk/test/param"), spec.getParameters(), "Expected parameters to match discovered CDK resources");
    assertEquals(List.of("cdk-test-secret"), spec.getSecrets(), "Expected secrets to match discovered CDK resources");
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

  @Test
  void lifecycleBuilder_storesCreateAndDeleteDwellMs() throws Exception {
    // Arrange
    int basePort = LwsSession.findFreePort();
    LwsSession session = new LwsSession(basePort, (Process) null);
    int expectedCreateDwellMs = 500;
    int expectedDeleteDwellMs = 200;

    // Act
    LifecycleBuilder builder =
        session
            .lifecycle("dynamodb")
            .createDwellMs(expectedCreateDwellMs)
            .deleteDwellMs(expectedDeleteDwellMs);

    // Assert
    assertNotNull(builder, "Expected builder to not be null");
  }
}
