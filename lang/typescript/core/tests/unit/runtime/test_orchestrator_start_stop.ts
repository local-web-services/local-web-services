import { describe, it, expect } from "vitest";
import { Orchestrator } from "../../../src/runtime/orchestrator.js";
import type { IProvider } from "../../../src/interfaces/provider.js";

function makeProvider(name: string, healthy = true): IProvider {
  return {
    name,
    async start() {},
    async stop() {},
    async healthCheck() {
      return healthy;
    },
  };
}

describe("Orchestrator", () => {
  it("running is false before start", () => {
    // Arrange
    const orchestrator = new Orchestrator();
    const expectedRunning = false;

    // Act
    const actualRunning = orchestrator.running;

    // Assert
    expect(actualRunning).toBe(expectedRunning);
  });

  it("running is true after start", async () => {
    // Arrange
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([["sqs", makeProvider("sqs")]]);
    const expectedRunning = true;

    // Act
    await orchestrator.start(providers, ["sqs"]);
    const actualRunning = orchestrator.running;

    // Assert
    expect(actualRunning).toBe(expectedRunning);
  });

  it("running is false after stop", async () => {
    // Arrange
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([["sqs", makeProvider("sqs")]]);
    await orchestrator.start(providers, ["sqs"]);
    const expectedRunning = false;

    // Act
    await orchestrator.stop();
    const actualRunning = orchestrator.running;

    // Assert
    expect(actualRunning).toBe(expectedRunning);
  });

  it("start calls start on each provider in order", async () => {
    // Arrange
    const started: string[] = [];
    const makeTracked = (name: string): IProvider => ({
      name,
      async start() {
        started.push(name);
      },
      async stop() {},
      async healthCheck() {
        return true;
      },
    });
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([
      ["a", makeTracked("a")],
      ["b", makeTracked("b")],
    ]);
    const expectedOrder = ["a", "b"];

    // Act
    await orchestrator.start(providers, ["a", "b"]);

    // Assert
    expect(started).toEqual(expectedOrder);
  });

  it("stop calls stop on providers in reverse order", async () => {
    // Arrange
    const stopped: string[] = [];
    const makeTracked = (name: string): IProvider => ({
      name,
      async start() {},
      async stop() {
        stopped.push(name);
      },
      async healthCheck() {
        return true;
      },
    });
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([
      ["a", makeTracked("a")],
      ["b", makeTracked("b")],
    ]);
    const expectedOrder = ["b", "a"];

    // Act
    await orchestrator.start(providers, ["a", "b"]);
    await orchestrator.stop();

    // Assert
    expect(stopped).toEqual(expectedOrder);
  });

  it("flush is called on providers that implement it", async () => {
    // Arrange
    let flushed = false;
    const flushableProvider: IProvider = {
      name: "dynamo",
      async start() {},
      async stop() {},
      async healthCheck() {
        return true;
      },
      async flush() {
        flushed = true;
      },
    };
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([["dynamo", flushableProvider]]);
    const expectedFlushed = true;

    // Act
    await orchestrator.start(providers, ["dynamo"]);
    await orchestrator.stop();

    // Assert
    expect(flushed).toBe(expectedFlushed);
  });

  it("requestShutdown resolves waitForShutdown", async () => {
    // Arrange
    const orchestrator = new Orchestrator();
    const providers = new Map<string, IProvider>([["sqs", makeProvider("sqs")]]);
    await orchestrator.start(providers, ["sqs"]);
    let resolved = false;

    // Act
    const waitPromise = orchestrator.waitForShutdown().then(() => {
      resolved = true;
    });
    orchestrator.requestShutdown();
    await waitPromise;

    // Assert
    expect(resolved).toBe(true);
  });
});
