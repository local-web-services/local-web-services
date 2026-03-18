package io.localwebservices.lws;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.extension.AfterAllCallback;
import org.junit.jupiter.api.extension.BeforeAllCallback;
import org.junit.jupiter.api.extension.BeforeEachCallback;
import org.junit.jupiter.api.extension.ExtensionContext;
import org.junit.jupiter.api.extension.ExtensionContext.Namespace;
import org.junit.jupiter.api.extension.ExtensionContext.Store;
import org.junit.jupiter.api.extension.ParameterContext;
import org.junit.jupiter.api.extension.ParameterResolver;
import org.junit.jupiter.api.extension.TestInstancePostProcessor;

/**
 * JUnit 5 extension that manages an {@link LwsSession} lifecycle for test classes annotated with
 * {@link LwsTest}.
 *
 * <p>The session is started once before all tests in the class, reset before each individual test,
 * and closed after all tests complete.
 *
 * <p>Use via {@link LwsTest}:
 *
 * <pre>{@code
 * @LwsTest(tables = { @LwsTable(name = "Orders", hashKey = "id") })
 * class MyTest { ... }
 * }</pre>
 */
public class LwsExtension
    implements BeforeAllCallback,
        AfterAllCallback,
        BeforeEachCallback,
        ParameterResolver,
        TestInstancePostProcessor {

  private static final Namespace NS = Namespace.create(LwsExtension.class);
  private static final String SESSION_KEY = "lwsSession";

  @Override
  public void beforeAll(ExtensionContext ctx) throws Exception {
    Class<?> testClass = ctx.getRequiredTestClass();
    LwsTest lwsTest = testClass.getAnnotation(LwsTest.class);
    SessionSpec spec = buildSpec(lwsTest);
    LwsSession session = LwsSession.createInProcess(spec);
    store(ctx).put(SESSION_KEY, session);
  }

  @Override
  public void beforeEach(ExtensionContext ctx) throws Exception {
    LwsSession session = getSession(ctx);
    if (session != null) {
      session.reset();
    }
  }

  @Override
  public void afterAll(ExtensionContext ctx) {
    LwsSession session = getSession(ctx);
    if (session != null) {
      session.close();
      store(ctx).remove(SESSION_KEY);
    }
  }

  @Override
  public boolean supportsParameter(ParameterContext paramCtx, ExtensionContext extCtx) {
    return paramCtx.getParameter().getType() == LwsSession.class;
  }

  @Override
  public Object resolveParameter(ParameterContext paramCtx, ExtensionContext extCtx) {
    return getSession(extCtx);
  }

  @Override
  public void postProcessTestInstance(Object testInstance, ExtensionContext ctx) throws Exception {
    LwsSession session = getSession(ctx);
    if (session == null) return;
    for (Field field : testInstance.getClass().getDeclaredFields()) {
      if (field.isAnnotationPresent(LwsInject.class) && field.getType() == LwsSession.class) {
        field.setAccessible(true);
        field.set(testInstance, session);
      }
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  private static SessionSpec buildSpec(LwsTest lwsTest) {
    SessionSpec spec = new SessionSpec();
    if (lwsTest == null) return spec;

    List<TableSpec> tables = new ArrayList<>();
    for (LwsTable t : lwsTest.tables()) {
      TableSpec ts = new TableSpec(t.name(), t.hashKey());
      if (!t.sortKey().isEmpty()) {
        ts.sortKey(t.sortKey());
      }
      tables.add(ts);
    }
    if (!tables.isEmpty()) spec.tables(tables);

    List<String> queues = new ArrayList<>();
    for (LwsQueue q : lwsTest.queues()) {
      queues.add(q.name());
    }
    if (!queues.isEmpty()) spec.queues(queues);

    return spec;
  }

  private static Store store(ExtensionContext ctx) {
    return ctx.getStore(NS);
  }

  private static LwsSession getSession(ExtensionContext ctx) {
    // Walk up to the class-level context where the session was stored.
    ExtensionContext current = ctx;
    while (current != null) {
      LwsSession session = current.getStore(NS).get(SESSION_KEY, LwsSession.class);
      if (session != null) return session;
      current = current.getParent().orElse(null);
    }
    return null;
  }
}
