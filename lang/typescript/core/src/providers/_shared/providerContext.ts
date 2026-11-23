/**
 * Cross-cutting provider context.
 *
 * Bundles optional cross-cutting concerns into a single object so that adding
 * a new concern requires one field here rather than touching every
 * `create*App()` factory signature.
 *
 * Mirrors `providers/_shared/provider_context.py`.
 */
export interface ProviderContext {
  /** CloudTrail provider reference — undefined if not running. */
  cloudtrail?: unknown;
}
