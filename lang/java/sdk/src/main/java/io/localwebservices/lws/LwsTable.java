package io.localwebservices.lws;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Declares a DynamoDB table resource for an {@link LwsTest} class.
 *
 * <pre>{@code
 * @LwsTest(tables = { @LwsTable(name = "Orders", hashKey = "orderId") })
 * class MyTest { ... }
 * }</pre>
 */
@Target(ElementType.ANNOTATION_TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface LwsTable {

  /** Table name. */
  String name();

  /** Partition (hash) key attribute name. */
  String hashKey();

  /** Sort (range) key attribute name, or empty string for a simple key (default). */
  String sortKey() default "";
}
