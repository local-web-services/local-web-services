package io.localwebservices.lws;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Marks a field or parameter in a JUnit 5 test class for {@link LwsSession} injection.
 *
 * <p>When used on a field, {@link LwsExtension} sets the field to the shared session
 * before each test method runs. When used on a test method parameter, JUnit 5's
 * parameter resolution injects the session automatically.
 *
 * <pre>{@code
 * @LwsTest(tables = { @LwsTable(name = "Orders", hashKey = "id") })
 * class MyTest {
 *     @LwsInject LwsSession session;
 *
 *     @Test void test() { session.client(DynamoDbClient.class).listTables(); }
 * }
 * }</pre>
 */
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface LwsInject {
}
