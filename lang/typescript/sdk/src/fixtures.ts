/**
 * Vitest fixture helpers for LwsSession.
 *
 * Mirrors `lws_testing/fixtures.py`.
 *
 * Usage — wrap in beforeAll/afterAll:
 *
 *   const { getSession } = lwsSessionFixture(new SqsQueue("Orders"))
 *
 *   beforeAll(async () => { await getSession.start() })
 *   afterAll(async ()  => { await getSession.stop() })
 *   beforeEach(async () => { await getSession.reset() })
 *
 * Or use the `test.extend()` variant for per-test sessions:
 *
 *   const test = lwsSessionTest(new SqsQueue("Orders"))
 *   test("my test", async ({ session }) => { ... })
 */

import { LwsSession } from "./session.js";
import type { ResourceSpec } from "./specs.js";

/**
 * Returns a session-scoped helper object.
 *
 * Call `beforeAll(fixture.start)`, `afterAll(fixture.stop)`, and
 * optionally `beforeEach(fixture.reset)` in your describe block.
 */
export function lwsSessionFixture(...resources: ResourceSpec[]): {
  readonly session: LwsSession;
  start: () => Promise<void>;
  stop: () => Promise<void>;
  reset: () => Promise<void>;
} {
  const session = new LwsSession(...resources);
  return {
    get session() {
      return session;
    },
    start: () => session.start(),
    stop: () => session.stop(),
    reset: () => session.reset(),
  };
}
