#!/usr/bin/env node
/**
 * lws CLI — management commands for a running ldk dev instance.
 *
 * Commands:
 *   lws status  Show the status of the running ldk dev instance
 *   lws init    Scaffold agent configuration into a project
 */

import { Command } from "commander";
import { fetchStatus, fetchResources } from "./http.js";

const DEFAULT_PORT = 3000;

const program = new Command()
  .name("lws")
  .description("Management commands for a running ldk dev instance");

program
  .command("status")
  .description("Show the status of the running ldk dev instance and all providers")
  .option("-p, --port <number>", "ldk dev port", String(DEFAULT_PORT))
  .option("--json", "Output as JSON")
  .action(async (opts: { port: string; json?: boolean }) => {
    const port = parseInt(opts.port, 10);
    try {
      const [status, resources] = await Promise.all([
        fetchStatus(port),
        fetchResources(port),
      ]);

      if (opts.json) {
        const services = Object.entries(resources.services).map(([name, svc]) => ({
          name,
          port: svc.port,
          resources: svc.resources.length,
        }));
        process.stdout.write(JSON.stringify({ running: status.running, providers: status.providers, services }, null, 2) + "\n");
        return;
      }

      console.log(status.running ? "LDK is running" : "LDK is not fully started");
      console.log();
      console.log("Providers:");
      for (const p of status.providers) {
        console.log(`  ${p.name.padEnd(16)} ${p.healthy ? "healthy" : "unhealthy"}`);
      }

      const serviceEntries = Object.entries(resources.services);
      if (serviceEntries.length > 0) {
        console.log();
        console.log("Services:");
        for (const [name, svc] of serviceEntries) {
          console.log(`  ${name.padEnd(16)} port=${svc.port}  resources=${svc.resources.length}`);
        }
      }
    } catch {
      console.error(`Cannot reach ldk dev on port ${port}. Is it running?`);
      process.exit(1);
    }
  });

const CLAUDE_MD_SNIPPET = `
## lws — Local Web Services

This project uses \`lws\` to emulate AWS services locally.

### Quick start

\`\`\`bash
ldk dev          # start the local server (port 3000)
lws status       # check what's running
ldk stop         # stop the server
\`\`\`

### SDK usage (TypeScript)

\`\`\`ts
import { LwsSession } from "local-web-services-typescript-sdk";

const session = new LwsSession();
await session.start();
// configure AWS clients with session.clientConfig("sqs")
await session.stop();
\`\`\`
`.trimStart();

const MARKER_START = "<!-- LWS:START -->";
const MARKER_END = "<!-- LWS:END -->";

program
  .command("init")
  .description("Scaffold agent configuration into a project")
  .option("-d, --project-dir <path>", "Project root directory", ".")
  .action(async (opts: { projectDir: string }) => {
    const { resolve, join } = await import("node:path");
    const { existsSync, readFileSync, writeFileSync, mkdirSync } = await import("node:fs");

    const projectDir = resolve(opts.projectDir);
    const claudeMd = join(projectDir, "CLAUDE.md");
    const block = `${MARKER_START}\n${CLAUDE_MD_SNIPPET}\n${MARKER_END}`;

    if (existsSync(claudeMd)) {
      let content = readFileSync(claudeMd, "utf8");
      if (content.includes(MARKER_START) && content.includes(MARKER_END)) {
        const start = content.indexOf(MARKER_START);
        const end = content.indexOf(MARKER_END) + MARKER_END.length;
        content = content.slice(0, start) + block + content.slice(end);
      } else {
        content = content.trimEnd() + "\n\n" + block + "\n";
      }
      writeFileSync(claudeMd, content);
    } else {
      writeFileSync(claudeMd, block + "\n");
    }

    console.log(`Updated CLAUDE.md`);

    const commandsDir = join(projectDir, ".claude", "commands", "lws");
    mkdirSync(commandsDir, { recursive: true });
    writeFileSync(
      join(commandsDir, "status.md"),
      `Run \`lws status\` and summarize which providers are healthy.\n`,
    );
    console.log(`  Wrote .claude/commands/lws/status.md`);
  });

program.parseAsync(process.argv).catch((err: unknown) => {
  console.error(String(err));
  process.exit(1);
});
