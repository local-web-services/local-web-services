#!/usr/bin/env node
/**
 * ldk CLI — Local Development Kit.
 *
 * Commands:
 *   ldk dev    Start the local development server
 *   ldk stop   Stop a running ldk dev instance
 *   ldk reset  Reset all local state
 *   ldk setup  Pull Docker images for local service emulation
 */

import { Command } from "commander";
import { startDevServer } from "./server.js";
import { fetchStatus, postShutdown, postReset, waitUntilReady } from "./http.js";

const DEFAULT_PORT = 3000;

const program = new Command()
  .name("ldk")
  .description("Local Development Kit — run AWS services locally");

program
  .command("dev")
  .description("Start the local development server")
  .option("-p, --port <number>", "Port to listen on", String(DEFAULT_PORT))
  .option("-b, --background", "Run in the background (detached)")
  .action(async (opts: { port: string; background?: boolean }) => {
    const port = parseInt(opts.port, 10);

    if (opts.background) {
      await runBackground(port);
      return;
    }

    try {
      const handle = await startDevServer({ port });
      console.log(`ldk dev running on http://localhost:${port}`);
      console.log(`  Status: http://localhost:${port}/_ldk/status`);
      console.log("  Press Ctrl+C to stop");
      await handle.waitForShutdown();
      await handle.stop();
    } catch (err) {
      console.error("ldk dev failed:", String(err));
      process.exit(1);
    }
  });

async function runBackground(port: number): Promise<void> {
  const { spawn } = await import("node:child_process");
  const logDir = ".lws";
  const { mkdirSync, openSync } = await import("node:fs");
  mkdirSync(logDir, { recursive: true });
  const logFd = openSync(`${logDir}/ldk-dev.log`, "w");

  const child = spawn(process.execPath, [process.argv[1] ?? "ldk", "dev", "--port", String(port)], {
    detached: true,
    stdio: ["ignore", logFd, logFd],
  });
  child.unref();

  console.log(`Starting ldk dev in background (PID ${child.pid ?? "unknown"})...`);
  console.log(`  Log: ${logDir}/ldk-dev.log`);

  const ready = await waitUntilReady(port);
  if (ready) {
    console.log(`ldk dev is running on port ${port}`);
    console.log(`  Stop with: ldk stop --port ${port}`);
  } else {
    console.warn("ldk dev did not become ready within 30 s — check the log");
  }
}

program
  .command("stop")
  .description("Stop a running ldk dev instance")
  .option("-p, --port <number>", "ldk dev port", String(DEFAULT_PORT))
  .action(async (opts: { port: string }) => {
    const port = parseInt(opts.port, 10);
    try {
      await postShutdown(port);
      console.log("ldk dev stopped.");
    } catch {
      console.warn(`No ldk dev instance found on port ${port}.`);
    }
  });

program
  .command("reset")
  .description("Reset all ldk local state (queues, tables, etc.)")
  .option("-p, --port <number>", "Management API port", String(DEFAULT_PORT))
  .option("-y, --yes", "Skip confirmation prompt")
  .action(async (opts: { port: string; yes?: boolean }) => {
    const port = parseInt(opts.port, 10);

    if (!opts.yes) {
      const { createInterface } = await import("node:readline");
      const rl = createInterface({ input: process.stdin, output: process.stdout });
      const answer = await new Promise<string>((resolve) =>
        rl.question("Reset all local state? [y/N] ", resolve),
      );
      rl.close();
      if (answer.trim().toLowerCase() !== "y") {
        console.log("Aborted.");
        return;
      }
    }

    try {
      await postReset(port);
      console.log("Reset complete.");
    } catch {
      console.warn(`Could not reach ldk dev on port ${port} — skipping server reset.`);
    }
  });

const SUPPORTED_SERVICES = ["lambda", "elasticache", "memorydb", "docdb", "rds", "neptune"];

program
  .command("setup <service>")
  .description("Pull Docker images required for local service emulation")
  .action((service: string) => {
    if (!SUPPORTED_SERVICES.includes(service) && service !== "all") {
      console.error(
        `Unknown service '${service}'. Supported: ${SUPPORTED_SERVICES.join(", ")}, all`,
      );
      process.exit(1);
    }
    console.log(`Docker image setup for '${service}' is not yet implemented in this version.`);
    console.log("Use the Python ldk setup command for Docker-backed services.");
  });

program
  .command("status")
  .description("Show status of a running ldk dev instance")
  .option("-p, --port <number>", "ldk dev port", String(DEFAULT_PORT))
  .action(async (opts: { port: string }) => {
    const port = parseInt(opts.port, 10);
    try {
      const status = await fetchStatus(port);
      console.log(`Running: ${status.running}`);
      for (const p of status.providers) {
        console.log(`  ${p.name}: ${p.healthy ? "healthy" : "unhealthy"}`);
      }
    } catch {
      console.error(`Cannot reach ldk dev on port ${port}. Is it running?`);
      process.exit(1);
    }
  });

program.parseAsync(process.argv).catch((err: unknown) => {
  console.error(String(err));
  process.exit(1);
});
