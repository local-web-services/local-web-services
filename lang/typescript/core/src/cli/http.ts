/**
 * HTTP helpers for CLI commands that talk to a running ldk dev server.
 */

export interface LdkStatus {
  running: boolean;
  providers: Array<{ name: string; healthy: boolean }>;
}

export interface LdkResources {
  services: Record<string, { port: number; resources: unknown[] }>;
}

export async function fetchStatus(port: number): Promise<LdkStatus> {
  const response = await fetch(`http://localhost:${port}/_ldk/status`);
  if (!response.ok) {
    throw new Error(`/_ldk/status returned ${response.status}`);
  }
  return (await response.json()) as LdkStatus;
}

export async function fetchResources(port: number): Promise<LdkResources> {
  const response = await fetch(`http://localhost:${port}/_ldk/resources`);
  if (!response.ok) {
    throw new Error(`/_ldk/resources returned ${response.status}`);
  }
  return (await response.json()) as LdkResources;
}

export async function postShutdown(port: number): Promise<void> {
  const response = await fetch(`http://localhost:${port}/_ldk/shutdown`, { method: "POST" });
  if (!response.ok) {
    throw new Error(`/_ldk/shutdown returned ${response.status}`);
  }
}

export async function postReset(port: number): Promise<void> {
  const response = await fetch(`http://localhost:${port}/_ldk/reset`, { method: "POST" });
  if (!response.ok) {
    throw new Error(`/_ldk/reset returned ${response.status}`);
  }
}

export async function waitUntilReady(port: number, timeoutMs = 30_000): Promise<boolean> {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    try {
      const status = await fetchStatus(port);
      if (status.running) return true;
    } catch {
      // not ready yet
    }
    await new Promise((resolve) => setTimeout(resolve, 500));
  }
  return false;
}
