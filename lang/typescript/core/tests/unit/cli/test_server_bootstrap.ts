/**
 * Unit tests for the dev server bootstrap.
 */

import { describe, it, expect, afterEach } from "vitest";
import { startDevServer } from "../../../src/cli/server.js";
import type { DevServerHandle } from "../../../src/cli/server.js";

describe("startDevServer", () => {
  let handle: DevServerHandle | null = null;

  afterEach(async () => {
    await handle?.stop();
    handle = null;
  });

  it("starts and reports a running server", async () => {
    // Arrange
    const expectedPort = 19500;

    // Act
    handle = await startDevServer({ port: expectedPort });

    // Assert
    expect(handle.port).toBe(expectedPort);
  });

  it("responds to /_ldk/status once started", async () => {
    // Arrange
    const expectedStatusCode = 200;
    handle = await startDevServer({ port: 19501 });

    // Act
    const actualResponse = await fetch(`http://localhost:${handle.port}/_ldk/status`);

    // Assert
    expect(actualResponse.status).toBe(expectedStatusCode);
  });

  it("status endpoint returns running=true", async () => {
    // Arrange
    const expectedRunning = true;
    handle = await startDevServer({ port: 19502 });

    // Act
    const actualBody = (await (await fetch(`http://localhost:${handle.port}/_ldk/status`)).json()) as { running: boolean };

    // Assert
    expect(actualBody.running).toBe(expectedRunning);
  });

  it("responds to /_ldk/resources once started", async () => {
    // Arrange
    const expectedStatusCode = 200;
    handle = await startDevServer({ port: 19503 });

    // Act
    const actualResponse = await fetch(`http://localhost:${handle.port}/_ldk/resources`);

    // Assert
    expect(actualResponse.status).toBe(expectedStatusCode);
  });

  it("stop closes the server cleanly", async () => {
    // Arrange
    handle = await startDevServer({ port: 19504 });

    // Act
    await handle.stop();
    handle = null;
    let actualError: Error | null = null;
    try {
      await fetch("http://localhost:19504/_ldk/status");
    } catch (err) {
      actualError = err instanceof Error ? err : new Error(String(err));
    }

    // Assert
    expect(actualError).not.toBeNull();
  });
});
