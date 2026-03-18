package io.localwebservices.lws;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import org.junit.jupiter.api.extension.ExtendWith;

/**
 * Marks a JUnit 5 test class as an LWS test.
 *
 * <p>Automatically activates {@link LwsExtension}, which:
 *
 * <ul>
 *   <li>Starts an in-process LWS server with the declared resources before all tests.
 *   <li>Resets all state before each individual test.
 *   <li>Shuts down the server after all tests complete.
 *   <li>Injects the {@link LwsSession} into fields annotated with {@link LwsInject} and into test
 *       method parameters of type {@link LwsSession}.
 * </ul>
 *
 * <pre>{@code
 * @LwsTest(
 *     tables = { @LwsTable(name = "Orders", hashKey = "orderId") },
 *     queues = { @LwsQueue(name = "OrderQueue") }
 * )
 * class OrderServiceTest {
 *     @LwsInject LwsSession session;
 *
 *     @Test void placeOrder() {
 *         var db = session.client(DynamoDbClient.class);
 *         ...
 *     }
 * }
 * }</pre>
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@ExtendWith(LwsExtension.class)
public @interface LwsTest {

  /** DynamoDB tables to create before all tests. */
  LwsTable[] tables() default {};

  /** SQS queues to create before all tests. */
  LwsQueue[] queues() default {};
}
