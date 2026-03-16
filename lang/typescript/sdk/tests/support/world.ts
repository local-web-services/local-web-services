/** Cucumber World for the LWS TypeScript SDK BDD tests. */

import {
  setWorldConstructor,
  Before,
  After,
  World,
  IWorldOptions,
} from "@cucumber/cucumber";
import { LwsSession } from "../../src/session";
import type { LogCapture } from "../../src/logs";

export interface LastCallResult {
  success: boolean;
  output: unknown;
  error?: unknown;
}

export class SdkWorld extends World {
  session: LwsSession | null = null;
  lastCallResult: LastCallResult = { success: false, output: null };
  lastLogCapture: LogCapture | null = null;
  lastMessages: unknown[] = [];

  // Pending spec state for multi-step resource building
  _pendingSpec: {
    tables?: Array<{ name: string; partitionKey: string }>;
    queues?: string[];
    buckets?: string[];
    topics?: string[];
    stateMachines?: Array<{ name: string; definition: object }>;
  } = {};

  constructor(options: IWorldOptions) {
    super(options);
  }

  /** Return the ARN of a state machine named `name` from the running session. */
  async getStateMachineArn(name: string): Promise<string> {
    if (!this.session) throw new Error("No session running");
    const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
    const client = this.session.client<typeof SFNClient>("stepfunctions");
    const result = await client.send(new ListStateMachinesCommand({}));
    const machines: Array<{ name: string; stateMachineArn: string }> =
      result.stateMachines ?? [];
    const match = machines.find((m) => m.name === name);
    if (!match) {
      throw new Error(
        `State machine "${name}" not found. Available: ${machines
          .map((m) => m.name)
          .join(", ")}`
      );
    }
    return match.stateMachineArn;
  }
}

// ── Lifecycle hooks ────────────────────────────────────────────────────────────

Before(async function (this: SdkWorld) {
  // Close any session left open from a previous scenario
  if (this.session) {
    await this.session.close();
    this.session = null;
  }
  this.lastCallResult = { success: false, output: null };
  this.lastLogCapture = null;
  this.lastMessages = [];
  this._pendingSpec = {};
});

After(async function (this: SdkWorld) {
  if (this.session) {
    try {
      await this.session.close();
    } catch {
      // ignore close errors
    }
    this.session = null;
  }
});

setWorldConstructor(SdkWorld);
