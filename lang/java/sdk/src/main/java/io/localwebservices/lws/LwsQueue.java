package io.localwebservices.lws;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Declares an SQS queue resource for an {@link LwsTest} class.
 *
 * <pre>{@code
 * @LwsTest(queues = { @LwsQueue(name = "OrderQueue") })
 * class MyTest { ... }
 * }</pre>
 */
@Target(ElementType.ANNOTATION_TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface LwsQueue {

  /** Queue name. */
  String name();
}
