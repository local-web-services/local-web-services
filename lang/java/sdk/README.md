# local-web-services-java-sdk

Java testing SDK for [local-web-services](https://local-web-services.github.io) — starts
an in-process LWS server and provides pre-configured AWS SDK v2 clients pointing at the local
emulators. No AWS account, credentials, or Docker required.

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
    testImplementation 'io.localwebservices:lws-java-sdk:0.2.2'
}
```

## Quick start

### Auto-discover from Terraform

```java
// LwsSession.fromHcl() reads your .tf files, starts the in-process server, and
// pre-creates all declared resources (tables, queues, state machines, etc.)
try (LwsSession session = LwsSession.fromHcl("terraform")) {
    SfnClient sfn = session.sfnClient();
    // state machine already exists — run your test
}
```

### Auto-discover from CDK

```java
try (LwsSession session = LwsSession.fromCdk("../my-cdk-project")) {
    DynamoDbClient dynamo = session.dynamoDbClient();
    // resources pre-created from CDK cloud assembly
}
```

### Explicit resource declaration

```java
SessionSpec spec = new SessionSpec()
    .withTable(new TableSpec("Orders", "id"))
    .withQueue("OrderQueue")
    .withBucket("ReceiptsBucket")
    .withStateMachine(new StateMachineSpec("OrderProcessor", definitionJson));

try (LwsSession session = LwsSession.create(spec)) {
    DynamoDbClient dynamo = session.dynamoDbClient();
    SqsClient      sqs   = session.sqsClient();
    SfnClient      sfn   = session.sfnClient();
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
    static SfnClient  sfnClient;
    static String     stateMachineArn;

    @BeforeAll
    static void setUp() throws Exception {
        session   = LwsSession.fromHcl("terraform");
        sfnClient = session.sfnClient();
        stateMachineArn = sfnClient
            .listStateMachines(ListStateMachinesRequest.builder().build())
            .stateMachines().get(0).stateMachineArn();
    }

    @AfterAll
    static void tearDown() {
        session.close();
    }

    @BeforeEach
    void reset() throws Exception {
        session.reset(); // clear all state between tests
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

### Session constructors

| Constructor | Description |
|---|---|
| `LwsSession.fromHcl(projectDir)` | Auto-discover resources from Terraform `.tf` files |
| `LwsSession.fromCdk(projectDir)` | Auto-discover resources from CDK cloud assembly |
| `LwsSession.create(spec)` | Start with explicitly declared resources |

### Client methods

| Method | Returns |
|---|---|
| `session.dynamoDbClient()` | `DynamoDbClient` |
| `session.sqsClient()` | `SqsClient` |
| `session.s3Client()` | `S3Client` (path-style) |
| `session.snsClient()` | `SnsClient` |
| `session.sfnClient()` | `SfnClient` |
| `session.ssmClient()` | `SsmClient` |
| `session.secretsManagerClient()` | `SecretsManagerClient` |
| `session.cognitoClient()` | `CognitoIdentityProviderClient` |
| `session.lambdaClient()` | `LambdaClient` |
| `session.apiGatewayClient()` | `ApiGatewayClient` |
| `session.rdsClient()` | `RdsClient` |
| `session.docDbClient()` | `DocDbClient` |
| `session.neptuneClient()` | `NeptuneClient` |
| `session.elastiCacheClient()` | `ElastiCacheClient` |
| `session.memoryDbClient()` | `MemoryDbClient` |
| `session.glacierClient()` | `GlacierClient` |
| `session.elasticsearchClient()` | `ElasticsearchClient` |
| `session.openSearchClient()` | `OpenSearchClient` |
| `session.s3TablesClient()` | `S3TablesClient` |

### Helpers

| Method | Description |
|---|---|
| `session.portFor(service)` | Port number for a named service |
| `session.queueUrl(queueName)` | Local SQS queue URL |
| `session.reset()` | Clear all service state |
| `session.close()` | Stop the in-process server (also via try-with-resources) |

## Supported services

All 20 services are available. See client methods above for the full list.

## How it works

`LwsSession.create` starts the Java LWS core in-process on a randomly chosen base port. Each
service listens at `basePort + offset`. Client methods return AWS SDK v2 clients pre-configured
with `http://127.0.0.1:<port>` endpoint overrides and stub credentials. `close()` (or
try-with-resources) stops the server cleanly.

## License

MIT
