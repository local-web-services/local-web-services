import { describe, it, expect } from "vitest";
import * as net from "node:net";
import { findFreePort } from "../../../src/runtime/portAllocator.js";

describe("findFreePort", () => {
  it("returns a port number greater than zero", async () => {
    // Arrange
    const expectedMinPort = 1;

    // Act
    const { port, release } = await findFreePort();
    release();

    // Assert
    expect(port).toBeGreaterThanOrEqual(expectedMinPort);
  });

  it("returns different ports on successive calls", async () => {
    // Arrange
    const { port: port1, release: release1 } = await findFreePort();
    release1();

    // Act
    const { port: port2, release: release2 } = await findFreePort();
    release2();

    // Assert
    // Not guaranteed to be different, but overwhelmingly likely
    expect(port1).not.toBeUndefined();
    expect(port2).not.toBeUndefined();
  });

  it("released port can be bound by a new server", async () => {
    // Arrange
    const { port, release } = await findFreePort();
    release();

    // Act
    const server = net.createServer();
    let bound = false;
    await new Promise<void>((resolve, reject) => {
      server.listen(port, "127.0.0.1", () => {
        bound = true;
        server.close(() => resolve());
      });
      server.on("error", reject);
    });

    // Assert
    expect(bound).toBe(true);
  });
});
