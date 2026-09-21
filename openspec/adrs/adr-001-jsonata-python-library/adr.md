# ADR-001: JSONata Python Library Choice

## Status
Accepted

## Context

Adding JSONata expression support to the Step Functions provider requires a Python library that
can evaluate JSONata expressions. JSONata is a query and transformation language for JSON
(https://jsonata.org). AWS Step Functions uses it as an alternative to JSONPath.

No stdlib or existing LWS dependency covers JSONata evaluation.

## Options Considered

- **`jsonata-python`** — Pure Python port of the reference JSONata JS implementation.
  Installs as `pip install jsonata-python`, imported as `import jsonata`.
  Actively maintained. No native extension required. Covers the JSONata function library.

- **`pyjsonata`** — Wraps the Node.js JSONata runtime via subprocess/IPC.
  Requires Node.js at runtime, introducing a hard external dependency on a second runtime.
  Adds process-spawn latency per evaluation.

- **Implement a subset of JSONata from scratch** — Only feasible for trivial expressions;
  would diverge from the AWS implementation and require ongoing maintenance.

## Decision

Use `jsonata-python` (`pip install jsonata-python`, `import jsonata`).

## Rationale

- Pure Python: no secondary runtime (Node.js) required — consistent with LWS's no-Docker-for-core policy.
- Follows the reference JS implementation closely, giving the best chance of parity with AWS behaviour.
- Single pip dependency with no native extensions; works on all platforms and Python versions LWS targets.

## Consequences / Limitations

- `jsonata-python` may lag behind the upstream JS reference for newer JSONata features; gaps will
  surface at runtime when user state machines use unsupported functions.
- Adds ~1 MB to the installed package size.
- Evaluation is synchronous Python; very complex expressions on large payloads may be slower than
  the AWS runtime, but this is acceptable in local development.
