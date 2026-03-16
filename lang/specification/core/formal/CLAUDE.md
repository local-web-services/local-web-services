# FizzBee Formal Specification Notes

## Language Reference

FizzBee is a formal methods language for distributed systems. Specs are `.fizz` files
using Starlark (Python subset) syntax with model-checking extensions.

## Key Syntax

```fizzbee
# Constants declared at top level (these are FROZEN — cannot be mutated)
TABLE_NAMES = ["TableA", "TableB"]

# Mutable state declared inside action Init: (REQUIRED — top-level vars are frozen)
action Init:
    table_status = {}
    count = 0

# Atomic action: all statements execute as one step
atomic action CreateTable:
    oneof name in TABLE_NAMES:
        if name not in table_status:
            table_status[name] = "CREATING"

# Non-atomic action: yield point after each statement
action FundTransfer:
    any amount in range(1, 10):
        if balances["Alice"] >= amount:
            balances["Alice"] -= amount
            balances["Bob"] += amount

# oneof: exactly one branch executes (non-deterministic choice)
# NO comments inside oneof blocks
atomic action Resolve:
    oneof:
        status = "COMMITTED"
        status = "ROLLED_BACK"

# oneof with multi-statement branches: use atomic sub-blocks
atomic action ResolveMulti:
    oneof:
        atomic:
            status = "COMMITTED"
            count = count + 1
        atomic:
            status = "ROLLED_BACK"

# Safety invariant (must hold in every state)
always assertion StatusValid:
    for name in table_status:
        if table_status[name] not in ["CREATING", "ACTIVE"]:
            return False
    return True

# Liveness guarantee (must eventually hold from any state)
always eventually assertion EventuallyActive:
    for name in table_status:
        if table_status[name] == "CREATING":
            return False
    return True
```

## Critical Constraint 1: Use Fixed Lists for `any` Loops

**Never iterate over a mutable dict with `any:`. Always iterate over a fixed list/set.**

The two-phase commit example in FizzBee uses `any rm in rms:` where `rms = set(['r1', 'r2'])` is
a fixed set, and `rmState` is a separate mutable dict.

```fizzbee
# GOOD: iterate over fixed list, mutate separate dict
NAMES = ["TableA", "TableB"]
table_status = {}

atomic action ActivateTable:
    any name in NAMES:
        if name in table_status:
            if table_status[name] == "CREATING":
                table_status[name] = "ACTIVE"

# BAD: iterating over the same dict being mutated — COMPILATION ERROR
atomic action ActivateTable:
    any name in table_status:
        if table_status[name] == "CREATING":
            table_status[name] = "ACTIVE"  # FAILS
```

The same error pattern as double subscript: `('visitStmt childProto (unknown) type', 'list', [...])`

## Critical Constraint 2: Single-Level Subscript Assignments Only

**FizzBee's grammar only supports single-level subscript on the left-hand side of assignments.**

```fizzbee
# GOOD: single subscript assignment
table_status[name] = "ACTIVE"
items[key] = True

# BAD: double subscript assignment — COMPILATION ERROR
tables[name]["status"] = "ACTIVE"  # FAILS
tables[name]["items"][key] = True   # FAILS
```

**Fix**: Flatten nested state into separate top-level dicts with compound keys:

```fizzbee
# Instead of: tables = {}  where tables[name] = {"status": ..., "items": {}}
# Use:
table_status = {}               # table_status[name] = "ACTIVE"
items = {}                      # items[table+"#"+pk] = True
gsi_pending = {}                # gsi_pending[name] = 0  (integer counter)
```

## Critical Constraint 3: `del dict[key]` is NOT Supported

**`del dict[key]` causes a parser error** — FizzBee sees `[key]` after `del identifier` as a
list literal, producing an unparseable node.

**Fix**: Use sentinel values instead of deletion:

```fizzbee
# Instead of: del table_status[name]
table_status[name] = "DELETED"

# Instead of: del items[key]
items[key] = False
```

The parser error looks like:
```
Exception: ('visitStmt childProto (unknown) type', 'list', [...], ['table_status[name]'])
```

## Critical Constraint 4: Mutable State Must Be in `action Init:`

**Top-level variables in FizzBee are frozen (constants).** Any dict/list/variable you need to mutate
in actions MUST be declared inside `action Init:`.

```fizzbee
# GOOD: constants at top level, mutable state in Init
TABLE_NAMES = ["TableA", "TableB"]   # frozen constant — OK at top level

action Init:
    table_status = {}    # mutable — must be in Init
    count = 0            # mutable — must be in Init

# BAD: mutable variables at top level — runtime panic
table_status = {}        # FAILS: "cannot insert into frozen hash table"
```

## Other Syntax Rules

- Comments: `#` on their **own line only** — never inline after code
- **No comments inside `oneof:` blocks** — they may cause parser errors
- No f-strings, no `.format()` — use `+` string concatenation
- No imports
- `oneof var in collection:` — non-deterministic loop (preferred over deprecated `any`)
- `any var in collection:` — **deprecated** alias for `oneof`, still works but emits warnings
- `for var in collection:` — deterministic loop (use in assertions only)
- `set([])` — empty set; `.add()` and `.remove()` work on sets
- List `.append()` and `.remove()` work
- `pass` — forces action to always be enabled (no guard)
- `len(x)` — works on dicts, lists, sets
- Two `if` blocks at the same indentation in one action may cause issues — split into separate actions

## State Design Patterns

Declare all resource name sets at the top level; all mutable state in `action Init:`:

```fizzbee
TABLE_NAMES = ["TableA", "TableB", "TableC"]
QUEUE_NAMES = ["QueueA", "QueueB"]

action Init:
    # Status dicts start empty
    table_status = {}

# Iterate over fixed names, check dict for membership
atomic action ActivateTable:
    oneof name in TABLE_NAMES:
        if name in table_status:
            if table_status[name] == "CREATING":
                table_status[name] = "ACTIVE"
```

For services with resources that have sub-fields, use separate flat dicts in `action Init:`:

```fizzbee
action Init:
    # Resource lifecycle
    resource_status = {}      # resource_status[id] = "CREATING"|"ACTIVE"|"DELETING"

    # Resource properties (separate dict per property)
    resource_owner = {}       # resource_owner[id] = "user1"
    resource_tags = {}        # resource_tags[id+"#"+key] = value

    # Relationships (use compound keys)
    queue_messages = {}       # queue_messages[queue+"#"+msg_id] = True
    msg_status = {}           # msg_status[queue+"#"+msg_id] = "AVAILABLE"|"IN_FLIGHT"
```

## oneof Branches

Each branch of `oneof:` is **one statement**. For multi-statement branches wrap with `atomic:`.
**Never put comments inside `oneof:` blocks.**

```fizzbee
# Single-statement branches (OK)
oneof:
    status = "COMMITTED"
    status = "ROLLED_BACK"

# Multi-statement branches (must use atomic:)
oneof:
    atomic:
        status = "COMMITTED"
        count = count + 1
    atomic:
        status = "ROLLED_BACK"
```

## Gherkin Annotations (REQUIRED)

Every action and assertion **must** have structured comment annotations immediately above it.
These are parsed by `tools/fizz_to_gherkin.py` to generate human-readable Gherkin feature files
without any hardcoded mappings.

| Annotation | Placed before | Used as |
|---|---|---|
| `# step: <description>` | every `action` | Gherkin `When` step |
| `# result: <description>` | every `action` | Gherkin `Then` step |
| `# check: <description>` | every `assertion` | Gherkin `And` invariant step |
| `# guard: <description>` | every action with guard conditions | Gherkin `Given` step (happy path) |
| `# guard_violation: <description>` | every action with guard conditions | Gherkin `Given` step (negative scenario) |
| `# guard_violation_lifecycle: <description>` | guard violations for transient lifecycle states | Gherkin `Given` step + `@lifecycle` tag on negative scenario |
| `# guard_violation_capacity: <description>` | guard violations for slot/quota limits | Gherkin `Given` step + `@capacity` tag on negative scenario |
| `# fake_skip: internal` | system/timer-driven actions only | adds `@internal` tag to ALL scenarios for that action |

Rules:
- Place annotations on lines immediately preceding the `action`/`assertion` header (blank lines between are OK)
- If `# result:` is omitted, the generator falls back to `# step:` text
- Do **not** annotate `action Init:` — it is the background setup, not a test step
- Use plain English, lowercase, no trailing period
- Describe the *observable outcome*, not internal state details
- One `# guard:` + one `# guard_violation:` (or `_lifecycle`/`_capacity` variant) pair per `if` condition in the action, in order
- Actions with no guard conditions need no guard annotations
- The pair should read as natural opposites: "the API does not already exist" / "the API already exists"

**Choosing the right guard_violation variant:**
- `# guard_violation:` — for existence checks ("already exists", "does not exist") and config checks ("has no X configured") — these are **always testable**
- `# guard_violation_lifecycle:` — for violations that require a resource to be in a transient lifecycle state (CREATING, DELETING, MODIFYING, FAILING_OVER, etc.) that real fakes skip past — marks the negative scenario `@lifecycle`
- `# guard_violation_capacity:` — for violations that require hitting a slot or quota limit ("no X slot is available") that real fakes don't enforce — marks the negative scenario `@capacity`

**Using `# fake_skip: internal`:**
Use this on actions that are **never triggered by an API call** — only by timers, background daemons, or async runtime events (e.g. `VisibilityTimeoutExpires`, `CompleteClusterCreation`, `InvocationSucceeds`, `ESMPollAndInvoke`). The `@internal` tag is added to every scenario (happy path and all negatives) for that action, marking them as impossible to test through the fake's API surface.

Place `# fake_skip: internal` as the **first** annotation, immediately before `# step:`.

```fizzbee
# step: a REST API is created
# result: the API is ACTIVE
# guard: the API does not already exist
# guard_violation: the API already exists
atomic action CreateRestApi:
    any aid in API_IDS:
        if aid not in api_status:
            api_status[aid] = "ACTIVE"

# check: every table has a valid status (CREATING, ACTIVE, or DELETED)
always assertion TableStatusValid:
    for name in table_status:
        if table_status[name] not in ["CREATING", "ACTIVE", "DELETED"]:
            return False
    return True
```

Example using all annotation variants:

```fizzbee
# step: a message is sent to the queue
# result: the message is AVAILABLE for delivery
# guard: the queue exists
# guard_violation: the queue does not exist
# guard: the queue is ACTIVE
# guard_violation_lifecycle: the queue is not ACTIVE
# guard: a message slot is available
# guard_violation_capacity: no message slot is available
atomic action SendMessage:
    ...

# fake_skip: internal
# step: the visibility timeout expires
# result: the message becomes AVAILABLE again
# guard: the message exists
# guard_violation: the message does not exist
# guard: the message is IN_FLIGHT
# guard_violation_lifecycle: the message is not IN_FLIGHT
atomic action VisibilityTimeoutExpires:
    ...
```

To generate Gherkin from a spec:
```bash
python tools/fizz_to_gherkin.py lang/specification/core/formal/dynamodb/dynamodb.fizz
python tools/fizz_to_gherkin.py lang/specification/core/formal/dynamodb/dynamodb.fizz --tier exhaustive
```

## Modelling Delete Operations: Cascade Dependencies

When writing a `Delete` action, always ask: **what other resources reference this one?**

If resource B references resource A (e.g. a rule references a bus, a target references a rule,
an object lives in a bucket), then deleting A must either:

1. **Be blocked** if dependents exist (real AWS behaviour in most cases), OR
2. **Cascade** to mark all dependents as DELETED

Failing to model this leaves the spec in a state where deleted resources still have live
dependents — a silent gap that no existing assertion will catch.

**Checklist when writing any Delete action:**

- Who holds a reference to this resource? (check all `*_bus`, `*_queue`, `*_table`, etc. dicts)
- Should delete be blocked if dependents exist? Add a guard using `all([...])` over the fixed list.
- Add a corresponding `always assertion` that verifies no live dependent references a deleted parent.

**Example — blocking delete when dependents exist:**

```fizzbee
# guard: the event bus has no rules
# guard_violation: the event bus has rules
atomic action DeleteEventBus:
    any name in BUS_NAMES:
        if name != "default":
            if name in bus_status:
                if bus_status[name] == "ACTIVE":
                    if all([rule_name not in rule_bus or rule_bus[rule_name] != name for rule_name in RULE_NAMES]):
                        bus_status[name] = "DELETED"
```

**Example — assertion that catches a missing cascade:**

```fizzbee
# check: no enabled rule references a deleted event bus
always assertion RuleOnlyEnabledOnActiveBus:
    for rule_name in RULE_NAMES:
        if rule_name in rule_status:
            if rule_status[rule_name] == "ENABLED":
                if rule_name in rule_bus:
                    bus = rule_bus[rule_name]
                    if bus in bus_status:
                        if bus_status[bus] != "ACTIVE":
                            return False
    return True
```

Write the assertion **first** — if it passes without a guard fix, the cascade is already handled.
If it fails, add the guard to the Delete action.

## Modelling Actions Holistically (Not in Isolation)

When writing any action, consider its effect on the **entire system**, not just the resource it
directly modifies.

**Questions to ask for every action:**

1. **What does this action enable or prevent in other actions?**
   - If I delete resource A, can other actions still fire that require A to exist?
   - If I update resource A's status, do any other actions depend on that status?

2. **What existing assertions could this action violate?**
   - Go through every `always assertion` and ask: "can this action produce a state that violates it?"
   - If an assertion checks a relationship between two resource types, verify BOTH resources are
     handled correctly when either one changes.

3. **What assertions are missing?**
   - For every relationship between resources (rule→bus, target→rule, object→bucket), ask:
     "Is there an assertion that verifies the integrity of this relationship?"
   - If no assertion exists, add one before writing the action — the assertion makes the gap visible.

**The canonical mistake to avoid:**

> Modelling `DeleteEventBus` only in terms of what it does to the bus (`bus_status[name] = "DELETED"`),
> without asking: *"What happens to all the rules that reference this bus?"*

The fix is always the same: write the cross-resource assertion first, then add the guard that
prevents the violation.

**Checklist for every action:**

- What resources does this action read or write?
- For each resource written: what other resources hold a reference to it?
- Do any existing assertions span multiple resource types? Does this action respect all of them?
- Is there a `Delete`/`Disable`/`DELETED` transition? → Apply the cascade checklist above.

## File Location

Specs live in `lang/specification/core/formal/{service}/{service}.fizz`
