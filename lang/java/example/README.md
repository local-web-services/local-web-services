# local-web-services Java SDK — Example Project

An example project showing how to test an AWS Step Functions workflow using the [local-web-services Java SDK](https://github.com/local-web-services/local-web-services-java-sdk).

## What this example does

- Defines a simple `OrderProcessor` class that starts a Step Functions execution and waits for it to complete
- Uses `LwsSession` to run a local Step Functions emulator during tests — no AWS account or credentials required
- Discovers the state machine definition from `terraform/main.tf` automatically via `LwsSession.fromHcl()`
- Tests pass on any machine with Java and `local-web-services` installed

## Project structure

```
src/
  main/java/com/example/orders/
    OrderProcessor.java        # Production code — plain AWS SDK v2, no test-specific config
  test/java/com/example/orders/
    OrderProcessorTest.java    # JUnit 5 tests using LwsSession
terraform/
  main.tf                      # Terraform config declaring the OrderProcessor state machine
```

## Prerequisites

```bash
pip install local-web-services   # installs the ldk binary
```

## Running the tests

```bash
./gradlew test
```

## How it works

```java
// OrderProcessorTest.java
import io.localwebservices.lws.LwsSession;
import software.amazon.awssdk.services.sfn.SfnClient;

class OrderProcessorTest {

    static LwsSession session;
    static SfnClient sfnClient;
    static String stateMachineArn;

    @BeforeAll
    static void setUp() throws Exception {
        // Start ldk dev and discover resources declared in terraform/main.tf
        // The OrderProcessor state machine is created automatically
        session = LwsSession.fromHcl("terraform");
        sfnClient = session.sfnClient();  // pre-configured client pointing at local SFN emulator

        stateMachineArn = sfnClient.listStateMachines(ListStateMachinesRequest.builder().build())
                .stateMachines().get(0).stateMachineArn();
    }

    @AfterAll
    static void tearDown() {
        session.close();  // stops ldk dev
    }

    @Test
    void processOrder_runsStateMachineAndReturnsResult() throws Exception {
        // Pass the local SFN client — production code accepts an optional client
        // for testability; in production it creates one with default AWS settings
        OrderProcessor processor = new OrderProcessor(sfnClient);

        String actualOutput = processor.processOrder("order-001", stateMachineArn);

        assertTrue(actualOutput.contains("order-001"));
    }
}
```

## Links

- [local-web-services](https://github.com/local-web-services/local-web-services) — the core tool
- [Java SDK](https://github.com/local-web-services/local-web-services-java-sdk) — `io.localwebservices:local-web-services-java-sdk`
