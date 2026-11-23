/** Provider lifecycle status. */
export type ProviderStatus = "stopped" | "starting" | "running" | "error";

/** Raised when a provider fails to start. */
export class ProviderStartError extends Error {
  constructor(message: string, cause?: unknown) {
    super(message);
    this.name = "ProviderStartError";
    if (cause instanceof Error) {
      this.cause = cause;
    }
  }
}

/** Raised when a provider fails to stop. */
export class ProviderStopError extends Error {
  constructor(message: string, cause?: unknown) {
    super(message);
    this.name = "ProviderStopError";
    if (cause instanceof Error) {
      this.cause = cause;
    }
  }
}

/**
 * Abstract contract every LWS provider must satisfy.
 *
 * Mirrors the Python `Provider` ABC in `interfaces/provider.py`.
 */
export interface IProvider {
  /** Unique name of this provider (e.g. "sqs", "dynamodb"). */
  readonly name: string;

  /** Start the provider, making it ready to serve requests. */
  start(): Promise<void>;

  /** Stop the provider and release any resources. */
  stop(): Promise<void>;

  /** Return true when the provider is healthy and operational. */
  healthCheck(): Promise<boolean>;

  /**
   * Flush in-memory state to persistent storage.
   * Optional — only implemented by persistent providers (DynamoDB, Cognito).
   */
  flush?(): Promise<void>;

  /**
   * Reset all provider state (clear queues, tables, etc.).
   * Called by the management API `POST /_ldk/reset`.
   */
  reset?(): Promise<void>;
}
