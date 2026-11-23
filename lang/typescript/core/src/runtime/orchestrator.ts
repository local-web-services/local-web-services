/**
 * Provider lifecycle orchestrator.
 *
 * Starts and stops providers in the given dependency order, health-checks
 * each provider after start, and performs reverse-order shutdown on stop or
 * process signal.  Providers that implement `flush()` are flushed before stop.
 *
 * Mirrors `runtime/orchestrator.py`.
 */

import { IProvider, ProviderStartError } from "../interfaces/provider.js";

export class Orchestrator {
  private _providers: Map<string, IProvider> = new Map();
  private _startupOrder: string[] = [];
  private _running = false;
  private _shuttingDown = false;
  private _stopResolve: (() => void) | null = null;
  private _stopPromise: Promise<void> | null = null;

  // ------------------------------------------------------------------
  // Public API
  // ------------------------------------------------------------------

  /**
   * Start all providers in `startupOrder` (dependency-first).
   *
   * Installs SIGINT / SIGTERM handlers for graceful shutdown.
   * On failure, stops all already-started providers before throwing.
   */
  async start(providers: Map<string, IProvider>, startupOrder: string[]): Promise<void> {
    this._providers = providers;
    this._startupOrder = startupOrder;
    this._stopPromise = new Promise((resolve) => {
      this._stopResolve = resolve;
    });

    this._installSignalHandlers();

    for (const nodeId of this._startupOrder) {
      const provider = this._providers.get(nodeId);
      if (provider === undefined) continue;

      try {
        await provider.start();
      } catch (err) {
        await this.stop();
        throw new ProviderStartError(
          `Provider ${provider.name} failed to start: ${String(err)}`,
          err,
        );
      }

      const healthy = await provider.healthCheck();
      if (!healthy) {
        console.warn(`[ldk] Provider ${provider.name} started but health check failed`);
      }
    }

    this._running = true;
  }

  /**
   * Stop all providers in reverse startup order.
   *
   * Providers implementing `flush()` are flushed before stopping.
   */
  async stop(): Promise<void> {
    if (this._providers.size === 0) return;

    await this._flushProviders();

    for (const nodeId of [...this._startupOrder].reverse()) {
      const provider = this._providers.get(nodeId);
      if (provider === undefined) continue;
      try {
        await Promise.race([
          provider.stop(),
          new Promise<void>((_, reject) =>
            setTimeout(() => reject(new Error("stop timeout")), 30_000),
          ),
        ]);
      } catch {
        console.warn(`[ldk] Error or timeout stopping provider ${provider.name}`);
      }
    }

    this._running = false;
    this._providers.clear();
    this._startupOrder = [];
  }

  /** Block until `requestShutdown()` is called or a signal is received. */
  waitForShutdown(): Promise<void> {
    return this._stopPromise ?? Promise.resolve();
  }

  /** Trigger graceful shutdown (equivalent to receiving SIGTERM). */
  requestShutdown(): void {
    if (this._shuttingDown) return;
    this._shuttingDown = true;
    this._stopResolve?.();
  }

  get running(): boolean {
    return this._running;
  }

  get providers(): Map<string, IProvider> {
    return this._providers;
  }

  // ------------------------------------------------------------------
  // Internal
  // ------------------------------------------------------------------

  private async _flushProviders(): Promise<void> {
    for (const nodeId of this._startupOrder) {
      const provider = this._providers.get(nodeId);
      if (provider?.flush !== undefined) {
        try {
          await provider.flush();
        } catch {
          console.warn(`[ldk] Error flushing provider ${provider.name}`);
        }
      }
    }
  }

  private _installSignalHandlers(): void {
    const handle = (): void => {
      if (this._shuttingDown) {
        process.exit(1);
      }
      this.requestShutdown();
    };
    process.once("SIGINT", handle);
    process.once("SIGTERM", handle);
  }
}
