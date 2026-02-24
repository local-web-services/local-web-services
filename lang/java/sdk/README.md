# local-web-services-java-sdk

Java testing SDK for [local-web-services](https://local-web-services.github.io) — spawns `ldk dev` as a subprocess and provides pre-configured AWS SDK v2 clients pointing at the local emulators. No AWS account or credentials required.

## Prerequisites

Install `local-web-services`:

```bash
pip install local-web-services
```

This installs the `ldk` binary that the SDK uses to start the local AWS emulators.

## Installation

Add to your `build.gradle`:

```groovy
repositories {
    mavenCentral()
    maven {
        name = 'GitHubPackages'
        url = uri('https://maven.pkg.github.com/local-web-services/local-web-services-java-sdk')
        credentials {
            username = System.getenv('GITHUB_ACTOR') ?: project.findProperty('gpr.user') ?: ''
            password = System.getenv('GITHUB_TOKEN') ?: project.findProperty('gpr.key') ?: ''
        }
    }
}

dependencies {
    testImplementation 'io.localwebservices:local-web-services-java-sdk:0.1.0'
}
```

## Quick start

### Auto-discover from Terraform

```java
// LwsSession.fromHcl() reads your .tf files, starts ldk dev, and pre-creates
// all declared resources (tables, queues, state machines, etc.)
try (LwsSession session = LwsSession.fromHcl("terraform")) {
    SfnClient sfn = session.sfnClient();
    // state machine already exists — run your test
}
```

### Explicit resource declaration

```java
SessionSpec spec = new SessionSpec()
    .withTable(new TableSpec("Orders", "id"))
    .withQueue("OrderQueue")
    .withStateMachine(new StateMachineSpec("OrderProcessor", definitionJson));

try (LwsSession session = LwsSession.create(spec)) {
    DynamoDbClient dynamo = session.dynamoDbClient();
    SqsClient sqs = session.sqsClient();
    SfnClient sfn = session.sfnClient();
    // run your tests
}
```

## JUnit 5 example

```java
// OrderProcessorTest.java
import io.localwebservices.lws.LwsSession;
import org.junit.jupiter.api.*;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.*;

class OrderProcessorTest {

    static LwsSession session;
    static SfnClient sfnClient;
    static String stateMachineArn;

    @BeforeAll
    static void setUp() throws Exception {
        // Start ldk dev and discover resources from terraform/
        session = LwsSession.fromHcl("terraform");
        sfnClient = session.sfnClient();

        // Resolve the state machine ARN
        stateMachineArn = sfnClient.listStateMachines(ListStateMachinesRequest.builder().build())
                .stateMachines().get(0).stateMachineArn();
    }

    @AfterAll
    static void tearDown() {
        session.close();
    }

    @Test
    void processOrder_runsStateMachineAndReturnsResult() throws Exception {
        OrderProcessor processor = new OrderProcessor(sfnClient);

        Map<String, Object> result = processor.processOrder("order-001", stateMachineArn);

        assertEquals("order-001", result.get("orderId"));
    }
}
```

## API

### `LwsSession`

| Method | Description |
|--------|-------------|
| `LwsSession.fromHcl(projectDir)` | Auto-discover resources from Terraform `.tf` files and start `ldk dev` |
| `LwsSession.create(spec)` | Start `ldk dev` with explicitly declared resources |
| `session.dynamoDbClient()` | Pre-configured `DynamoDbClient` |
| `session.sqsClient()` | Pre-configured `SqsClient` |
| `session.s3Client()` | Pre-configured `S3Client` (path-style) |
| `session.snsClient()` | Pre-configured `SnsClient` |
| `session.sfnClient()` | Pre-configured `SfnClient` |
| `session.ssmClient()` | Pre-configured `SsmClient` |
| `session.secretsManagerClient()` | Pre-configured `SecretsManagerClient` |
| `session.portFor(service)` | Port number for a named service |
| `session.queueUrl(queueName)` | Local SQS queue URL |
| `session.close()` | Stop `ldk dev` (also called automatically by try-with-resources) |

### `SessionSpec`

| Method | Description |
|--------|-------------|
| `withTable(TableSpec)` | Declare a DynamoDB table |
| `withQueue(name)` | Declare an SQS queue |
| `withStateMachine(StateMachineSpec)` | Declare a Step Functions state machine |

### Supported services

`dynamodb`, `s3`, `sqs`, `sns`, `ssm`, `secretsmanager`, `stepfunctions`

## License

MIT
