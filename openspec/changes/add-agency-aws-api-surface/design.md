# Design: Agency AWS API Surface

## Context

Agency components assume IAM roles in target accounts and then call AWS services
(CloudFormation, SSM, Service Catalog) against those accounts. LWS must simulate
this: the session token returned by `AssumeRole` must carry the target account ID
so that subsequent service calls can be routed to per-account state stores.

The current STS implementation returns opaque session tokens and a fixed account ID
(`000000000000`) for all identity calls. The current Organizations, CloudFormation,
and SSM providers all use a single global state store.

## Goals / Non-Goals

- **Goals:**
  - All five proposals from the Agency requirements document (lws-requirements.md)
  - FizzBee formal specs for every new provider behaviour
  - Gherkin feature files generated from FizzBee specs
  - SDK e2e suites for every new service surface
  - Wire-format fidelity sufficient for real boto3/Go SDK clients with zero code changes
  - In-memory state (reset on restart) — no persistence required

- **Non-Goals:**
  - Real IAM policy enforcement (role validation is optional / best-effort)
  - Persistent state across restarts (optional future extension)
  - CloudFormation template execution (stacks are stored and describable but not executed)

## Decisions

### Decision: Account ID Encoding in Session Token

**What:** `AssumeRole` encodes the target account ID in the session token using a
deterministic prefix format: `lws-acct-{account_id}-{uuid}`. The STS handler and
every per-account provider extract `account_id` by splitting on `-` and reading the
second segment (index 1 after `lws-acct`).

**Why:** Keeps STS stateless (no session store required). The account ID is already
present in the `RoleArn` parameter and in the `AssumedRoleUser.Arn` returned in the
response — encoding it in the token is consistent and avoids an extra lookup.

**Alternatives considered:**
- JWT/signed token — overkill; LWS is a local test double, not a security boundary
- Server-side session map keyed on token UUID — requires shared mutable state between
  STS and every per-account provider; more complex than encoding inline

### Decision: Per-Account Routing via Middleware

**What:** A new `AwsAccountRoutingMiddleware` reads the `Authorization` header (which
contains the `Credential=ACCESS_KEY/...` segment), extracts the session token from the
`X-Amz-Security-Token` header, parses the account ID out of the token, and sets a
request-scoped context variable `lws_account_id`. Route handlers receive a
`PerAccountStateRegistry` dependency that returns the correct account-scoped state
object for the resolved account ID.

**Why:** Middleware is consistent with the existing chain
(`RequestLoggingMiddleware → IamAuthMiddleware → ChaosMiddleware → OperationFakeMiddleware`).
Adding account routing as another middleware keeps route handlers free of routing logic.

**Alternatives considered:**
- Parse account from `RoleArn` at call site — `RoleArn` is only available during
  `AssumeRole`, not during subsequent service calls
- Separate port per account — combinatorial explosion; not practical

### Decision: YAML Config Schema

**What:** A single YAML file at a path passed via `--config` (or `--seed` for built-ins)
with top-level keys: `organization`, `roots`, `ous`, `accounts`. Account entries may
include an optional `tags` map and an optional `roles` list. The config loader
populates `_OrganizationsState` at startup and also initialises per-account STS role
lists for optional role validation.

**Why:** Matches the example schema in the requirements document exactly. YAML is
human-readable and already used throughout the project for sample configs.

### Decision: CloudFormation Stack States

**What:** Stacks cycle through: `CREATE_IN_PROGRESS → CREATE_COMPLETE`,
`UPDATE_IN_PROGRESS → UPDATE_COMPLETE`, `DELETE_IN_PROGRESS → DELETE_COMPLETE`.
Transitions are synchronous (state is set immediately on the same request) since LWS is
a local test double and async polling adds friction without value for most Agency tests.

**Why:** Agency's Desired State Engine polls `DescribeStacks` for terminal states.
Making transitions synchronous removes the need for polling loops in tests.

**Alternatives considered:**
- Async with artificial delay (sleep) — adds latency and complexity; not needed

### Decision: Service Catalog Record States

**What:** `ProvisionProduct` returns a `RecordId` and immediately sets the record
status to `SUCCEEDED`. `DescribeRecord` always returns `SUCCEEDED`.

**Why:** Service Catalog Puppet polls `DescribeRecord`. Synchronous success is the
simplest correct behaviour for a local test double.

## Risks / Trade-offs

- **Account ID in token is plaintext** — fine for a local test double; not a security risk
- **Synchronous CloudFormation transitions** — if Agency tests specifically exercise
  polling loops, they will pass trivially. This is acceptable; the goal is integration
  correctness, not timing fidelity.
- **SSM per-account isolation** — the existing SSM provider uses a single global state.
  Per-account SSM requires either a new provider factory (one app per account) or
  account-keyed state within the existing provider. We choose account-keyed state within
  a single provider to avoid multiplying HTTP ports.

## Migration Plan

- No breaking changes to existing APIs
- New endpoints added to existing providers (Organizations, STS)
- New providers (CloudFormation, Service Catalog) run on new ports
- Existing SSM provider gains per-account keying; existing single-account behaviour is
  preserved when no session token is present (account defaults to `000000000000`)

## Open Questions

- None — all decisions above are settled based on the requirements document
