#!/usr/bin/env python3
"""
fizz_to_gherkin.py

Generates Gherkin .feature files from a FizzBee .fizz spec.

Produces three tiers:
  --tier minimal     One scenario per action (happy path only)
  --tier standard    Adds guard condition violations (default)
  --tier exhaustive  All meaningful action sequences up to --depth N

By default, one file is generated per action into --output <directory>.
Use --single to combine all actions into one file.

Step text is derived from structured comments in the .fizz spec itself —
no hardcoded mappings in this script. Add these comments to each action
and assertion in the spec:

    # step: a table is created
    # result: the table is in CREATING state
    atomic action CreateTable:
        ...

    # check: every table has a valid status
    always assertion TableStatusValid:
        ...

Usage:
    python fizz_to_gherkin.py dynamodb.fizz --output features/dynamodb/
    python fizz_to_gherkin.py dynamodb.fizz --tier minimal --output features/dynamodb/
    python fizz_to_gherkin.py dynamodb.fizz --tier exhaustive --depth 4 --output features/dynamodb/
    python fizz_to_gherkin.py dynamodb.fizz --single --output features/dynamodb.feature
"""

import re
import sys
import argparse
import itertools
from pathlib import Path
from dataclasses import dataclass, field
from typing import Optional


# ---------------------------------------------------------------------------
# Data model
# ---------------------------------------------------------------------------

@dataclass
class Action:
    name: str
    is_init: bool = False
    step_text: str = ""         # from # step: comment
    result_text: str = ""       # from # result: comment
    guard_conditions: list[str] = field(default_factory=list)
    guard_texts: list[str] = field(default_factory=list)           # from # guard: comments
    guard_violation_texts: list[str] = field(default_factory=list) # from # guard_violation: comments
    guard_violation_skips: list[str] = field(default_factory=list) # "lifecycle", "capacity", or "" per guard
    fake_skip: str = ""                                             # from # fake_skip: internal
    state_effects: list[str] = field(default_factory=list)
    any_vars: list[str] = field(default_factory=list)
    raw_body: str = ""


@dataclass
class Assertion:
    name: str
    is_liveness: bool = False
    check_text: str = ""        # from # check: comment
    raw_body: str = ""


@dataclass
class ParsedSpec:
    spec_name: str
    actions: list[Action] = field(default_factory=list)
    assertions: list[Assertion] = field(default_factory=list)

    @property
    def init_action(self) -> Optional[Action]:
        return next((a for a in self.actions if a.is_init), None)

    @property
    def non_init_actions(self) -> list[Action]:
        return [a for a in self.actions if not a.is_init]


# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------

_STEP_RE                       = re.compile(r"^#\s*step:\s*(.+)$")
_RESULT_RE                     = re.compile(r"^#\s*result:\s*(.+)$")
_CHECK_RE                      = re.compile(r"^#\s*check:\s*(.+)$")
_GUARD_RE                      = re.compile(r"^#\s*guard:\s*(.+)$")
_GUARD_VIOLATION_RE            = re.compile(r"^#\s*guard_violation:\s*(.+)$")
_FAKE_SKIP_RE                  = re.compile(r"^#\s*fake_skip:\s*(.+)$")
_GUARD_VIOLATION_LIFECYCLE_RE  = re.compile(r"^#\s*guard_violation_lifecycle:\s*(.+)$")
_GUARD_VIOLATION_CAPACITY_RE   = re.compile(r"^#\s*guard_violation_capacity:\s*(.+)$")

# Matches ALL_CAPS words (status/enum values like ACTIVE, IN_PROGRESS, DELETED)
# that are not already surrounded by double quotes.
_CAPS_WORD_RE = re.compile(r'(?<!")\b([A-Z][A-Z_]*[A-Z])\b(?!")')

_BLOCK_RE = re.compile(
    r"^((?:atomic\s+)?action\s+\w+\s*:|always\s+(?:eventually\s+)?assertion\s+\w+\s*:)",
    re.MULTILINE,
)


def _preceding_annotations(source: str, block_start: int) -> dict:
    """
    Walk backwards from block_start through blank lines and # comment lines,
    collecting the last # step:, # result:, and # check: values found,
    and all # guard: / # guard_violation: values (in forward order).
    """
    annotations: dict = {}
    guard_list: list[str] = []
    guard_violation_list: list[str] = []
    guard_violation_skip_list: list[str] = []
    preceding = source[:block_start].rstrip("\n")
    for line in reversed(preceding.splitlines()):
        stripped = line.strip()
        if not stripped:
            continue
        if not stripped.startswith("#"):
            break
        for pattern, key in ((_STEP_RE, "step"), (_RESULT_RE, "result"), (_CHECK_RE, "check")):
            m = pattern.match(stripped)
            if m:
                annotations.setdefault(key, m.group(1).strip())
        m = _FAKE_SKIP_RE.match(stripped)
        if m:
            annotations.setdefault("fake_skip", m.group(1).strip())
        m = _GUARD_RE.match(stripped)
        if m:
            guard_list.append(m.group(1).strip())
        m = _GUARD_VIOLATION_RE.match(stripped)
        if m:
            guard_violation_list.append(m.group(1).strip())
            guard_violation_skip_list.append("")
        m = _GUARD_VIOLATION_LIFECYCLE_RE.match(stripped)
        if m:
            guard_violation_list.append(m.group(1).strip())
            guard_violation_skip_list.append("lifecycle")
        m = _GUARD_VIOLATION_CAPACITY_RE.match(stripped)
        if m:
            guard_violation_list.append(m.group(1).strip())
            guard_violation_skip_list.append("capacity")
    annotations["guard"] = list(reversed(guard_list))
    annotations["guard_violation"] = list(reversed(guard_violation_list))
    annotations["guard_violation_skips"] = list(reversed(guard_violation_skip_list))
    return annotations


def parse_fizz(source: str, spec_name: str) -> ParsedSpec:
    spec = ParsedSpec(spec_name=spec_name)

    starts = [(m.start(), m.group(0)) for m in _BLOCK_RE.finditer(source)]

    for i, (start, header) in enumerate(starts):
        end = starts[i + 1][0] if i + 1 < len(starts) else len(source)
        block_body = source[start:end]
        lines = block_body.strip().splitlines()
        body_lines = lines[1:]
        raw_body = "\n".join(body_lines)

        annotations = _preceding_annotations(source, start)

        if "assertion" in header:
            is_liveness = "eventually" in header
            name_match = re.search(r"assertion\s+(\w+)", header)
            if name_match:
                spec.assertions.append(Assertion(
                    name=name_match.group(1),
                    is_liveness=is_liveness,
                    check_text=annotations.get("check", ""),
                    raw_body=raw_body,
                ))
        else:
            name_match = re.search(r"action\s+(\w+)", header)
            if not name_match:
                continue
            name = name_match.group(1)
            is_init = name.lower() == "init"

            any_vars = re.findall(r"(?:any|oneof)\s+(\w+)\s+in\s+\w+", raw_body)
            # Only collect guards before the first 'for' loop — conditions inside
            # for loops are implementation-level filtering, not API preconditions.
            body_for_guards = raw_body
            for_match = re.search(r"^\s*for\s+", raw_body, re.MULTILINE)
            if for_match:
                body_for_guards = raw_body[:for_match.start()]
            guards = [g.strip() for g in re.findall(r"if\s+(.+?):", body_for_guards)]
            # Cap to the number of annotated guards — extras are implementation-level
            # conditions inside nested any/for blocks, not API preconditions.
            n_annotated = len(annotations.get("guard", []))
            if n_annotated > 0:
                guards = guards[:n_annotated]
            effects = [
                f"{lhs.strip()} = {rhs.strip()}"
                for lhs, rhs in re.findall(r'(\w+(?:\[.+?\])*)\s*=\s*(?!"=)(.+)', raw_body)
            ]

            spec.actions.append(Action(
                name=name,
                is_init=is_init,
                step_text=annotations.get("step", ""),
                result_text=annotations.get("result", ""),
                guard_conditions=guards,
                guard_texts=annotations.get("guard", []),
                guard_violation_texts=annotations.get("guard_violation", []),
                guard_violation_skips=annotations.get("guard_violation_skips", []),
                fake_skip=annotations.get("fake_skip", ""),
                state_effects=effects,
                any_vars=any_vars,
                raw_body=raw_body,
            ))

    return spec


# ---------------------------------------------------------------------------
# Step text helpers
# ---------------------------------------------------------------------------

def _when_step(action: Action) -> str:
    text = action.step_text or _camel_to_words(action.name)
    return f"When {_quote_caps(text)}"


def _then_step(action: Action) -> str:
    text = action.result_text or action.step_text or _camel_to_words(action.name)
    return f"Then {_quote_caps(text)}"


def _check_step(assertion: Assertion) -> str:
    text = assertion.check_text or _camel_to_words(assertion.name)
    return f"And {_quote_caps(text)}"


def _is_stub(assertion: Assertion) -> bool:
    code_lines = [
        line.strip() for line in assertion.raw_body.splitlines()
        if line.strip() and not line.strip().startswith("#")
    ]
    return code_lines == ["return True"]


def _camel_to_words(name: str) -> str:
    return re.sub(r"([A-Z])", r" \1", name).strip().lower()


def _quote_caps(text: str) -> str:
    """Wrap ALL_CAPS status/enum words in double quotes for Gherkin readability."""
    return _CAPS_WORD_RE.sub(r'"\1"', text)


def _format_guard(guard: str, first: bool) -> str:
    readable = (
        guard
        .replace('"', "'")
        .replace("==", "is")
        .replace("!=", "is not")
    )
    keyword = "Given" if first else "And"
    return f"{keyword} {_quote_caps(readable)}"


def _negate_guard(guard: str) -> str:
    if "==" in guard:
        return guard.replace("==", "!=").replace('"', "'")
    if "!=" in guard:
        return guard.replace("!=", "==").replace('"', "'")
    return f"not ({guard})"


def _tag(name: str) -> str:
    return re.sub(r"([A-Z])", r"_\1", name).lower().lstrip("_")


def _snake(name: str) -> str:
    return re.sub(r"([A-Z])", r"_\1", name).lower().lstrip("_")


# ---------------------------------------------------------------------------
# Scenario builders
# ---------------------------------------------------------------------------

def build_background(init_action: Optional[Action]) -> list[str]:
    lines = ["  Background:"]
    if init_action:
        text = init_action.step_text or "the system is initialized"
        lines.append(f"    Given {text}")
    else:
        lines.append("    Given a clean environment")
    lines.append("")
    return lines


def build_happy_scenario(action: Action, spec: ParsedSpec) -> list[str]:
    extra_tags = f" @{action.fake_skip}" if action.fake_skip else ""
    lines = [
        f"  @minimal @happy @{_tag(action.name)}{extra_tags}",
        f"  Scenario: {_quote_caps(action.step_text or _camel_to_words(action.name))}",
    ]
    for i, guard in enumerate(action.guard_conditions):
        if i < len(action.guard_texts):
            keyword = "Given" if i == 0 else "And"
            lines.append(f"    {keyword} {_quote_caps(action.guard_texts[i])}")
        else:
            lines.append(f"    {_format_guard(guard, first=(i == 0))}")
    lines.append(f"    {_when_step(action)}")
    lines.append(f"    {_then_step(action)}")
    for a in spec.assertions:
        if not a.is_liveness and not _is_stub(a):
            lines.append(f"    {_check_step(a)}")
    return lines


def build_negative_scenarios_for_action(action: Action) -> list[list[str]]:
    scenarios = []
    for i, guard in enumerate(action.guard_conditions):
        if i < len(action.guard_violation_texts):
            violation_text = action.guard_violation_texts[i]
        else:
            violation_text = _negate_guard(guard)
        skip_tag = action.fake_skip
        if not skip_tag and i < len(action.guard_violation_skips):
            skip_tag = action.guard_violation_skips[i]
        extra_tags = f" @{skip_tag}" if skip_tag else ""
        qviolation = _quote_caps(violation_text)
        qstep = _quote_caps(action.step_text or _camel_to_words(action.name))
        lines = [
            f"  @guard @negative @{_tag(action.name)}{extra_tags}",
            f"  Scenario: {qstep} fails when {qviolation}",
        ]
        for j in range(i):
            keyword = "Given" if j == 0 else "And"
            if j < len(action.guard_texts):
                lines.append(f"    {keyword} {_quote_caps(action.guard_texts[j])}")
            else:
                lines.append(f"    {_format_guard(action.guard_conditions[j], first=(j == 0))}")
        keyword = "Given" if i == 0 else "And"
        lines.append(f"    {keyword} {qviolation}")
        lines.append(f"    {_when_step(action)}")
        lines.append(f"    Then the operation is rejected")
        scenarios.append(lines)
    return scenarios


def build_sequence_scenarios(spec: ParsedSpec, depth: int = 3) -> list[list[str]]:
    """Build the minimal transition-pair covering set for sequence scenarios.

    Generates all N*(N-1) length-2 pairs, which form the complete
    transition-pair covering set: every consecutive (A -> B) pair appears
    exactly once.

    The naive approach of generating all N*(N-1)*(N-2) length-3 permutations
    repeats each pair N-2 times with no new transition-pair coverage - for a
    30-action spec that produces 24,360 redundant scenarios instead of 870.

    With depth >= 3, each pair is extended by one representative third action
    (selected by cycling through candidates) so every pair (A -> B) also
    appears as the prefix of at least one length-3 sequence, distributing
    depth-3 coverage uniformly without the O(N^3) explosion.
    """
    names = [a.name for a in spec.non_init_actions]
    if not names:
        return []

    # All length-2 pairs: complete transition-pair coverage - N*(N-1) scenarios.
    pairs = list(itertools.permutations(names, 2))
    chains: list[list[str]] = [list(p) for p in pairs]

    # Depth-3 extension: one triple per pair, cycling through third-action
    # candidates so coverage is distributed across all actions.
    if depth >= 3 and len(names) >= 3:
        for i, (a, b) in enumerate(pairs):
            candidates = [n for n in names if n != a and n != b]
            c = candidates[i % len(candidates)]
            chains.append([a, b, c])

    seen: set[tuple[str, ...]] = set()
    unique: list[list[str]] = []
    for chain in chains:
        key = tuple(chain)
        if key not in seen:
            seen.add(key)
            unique.append(chain)

    scenarios = []
    for chain in unique:
        action_objs = [next((a for a in spec.non_init_actions if a.name == n), None) for n in chain]
        if any(a is None for a in action_objs):
            continue

        steps = [_quote_caps(a.step_text or _camel_to_words(a.name)) for a in action_objs]  # type: ignore[union-attr]
        chain_label = " then ".join(steps)
        lines = [
            f"  @sequence",
            f"  Scenario: {chain_label}",
        ]
        first_guard = True
        for action in action_objs:
            if first_guard and action.guard_conditions:  # type: ignore[union-attr]
                lines.append(f"    {_format_guard(action.guard_conditions[0], first=True)}")  # type: ignore[union-attr]
                first_guard = False
            lines.append(f"    {_when_step(action)}")  # type: ignore[union-attr]
        for a in spec.assertions:
            if not a.is_liveness and not _is_stub(a):
                lines.append(f"    {_check_step(a)}")
        scenarios.append(lines)
    return scenarios


# ---------------------------------------------------------------------------
# Feature file assembly
# ---------------------------------------------------------------------------

def _feature_header(service: str, title: str, spec: ParsedSpec) -> list[str]:
    safety   = [a for a in spec.assertions if not a.is_liveness and not _is_stub(a)]
    liveness = [a for a in spec.assertions if a.is_liveness]
    lines = [
        f"@{service.lower()} @generated",
        f"Feature: {title}",
        "",
        f"  # Generated from FizzBee spec: {spec.spec_name}",
    ]
    if safety:
        lines.append(f"  # Safety invariants: {', '.join(a.name for a in safety)}")
    if liveness:
        lines.append(f"  # Liveness properties: {', '.join(a.name for a in liveness)}")
    lines.append("")
    return lines


def generate_action_feature(action: Action, spec: ParsedSpec, service: str, tier: str) -> str:
    """Generate a feature file for a single action."""
    title = f"{service} - {action.step_text.title() if action.step_text else _camel_to_words(action.name).title()}"
    lines = _feature_header(service, title, spec)
    lines.extend(build_background(spec.init_action))

    lines.extend(build_happy_scenario(action, spec))
    lines.append("")

    if tier in ("standard", "exhaustive"):
        for scenario in build_negative_scenarios_for_action(action):
            lines.extend(scenario)
            lines.append("")

    return "\n".join(lines)


def generate_stub_assertion_feature(assertion: Assertion, spec: ParsedSpec, service: str) -> str:
    text = assertion.check_text or _camel_to_words(assertion.name)
    tag = _tag(assertion.name)
    title = f"{service.title()} - {text.capitalize()}"
    lines = [
        f"@{service.lower()} @generated",
        f"Feature: {title}",
        "",
        f"  # Generated from FizzBee spec: {spec.spec_name}",
        "",
    ]
    lines.extend(build_background(spec.init_action))
    lines += [
        f"  @invariant @{tag}",
        f"  Scenario: {_quote_caps(text)}",
        f"    Then {_quote_caps(text)}",
        "",
    ]
    return "\n".join(lines)


def generate_feature(spec: ParsedSpec, service: str, tier: str, depth: int) -> str:
    """Generate a single combined feature file for all actions."""
    title = f"{service} - {spec.spec_name.replace('.fizz', '').replace('_', ' ').title()}"
    lines = _feature_header(service, title, spec)
    lines.append(f"  # Actions modelled: {', '.join(a.name for a in spec.non_init_actions)}")
    lines.append("")
    lines.extend(build_background(spec.init_action))

    for action in spec.non_init_actions:
        lines.extend(build_happy_scenario(action, spec))
        lines.append("")

    if tier in ("standard", "exhaustive"):
        for action in spec.non_init_actions:
            for scenario in build_negative_scenarios_for_action(action):
                lines.extend(scenario)
                lines.append("")

    if tier == "exhaustive":
        for scenario in build_sequence_scenarios(spec, depth=depth):
            lines.extend(scenario)
            lines.append("")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Generate Gherkin feature files from a FizzBee .fizz spec."
    )
    parser.add_argument("spec", help="Path to the .fizz file")
    parser.add_argument("--service", default="", help="Service name for tags/title (e.g. DynamoDB)")
    parser.add_argument(
        "--tier",
        choices=["minimal", "standard", "exhaustive"],
        default="standard",
        help="Generation tier (default: standard)",
    )
    parser.add_argument("--depth", type=int, default=3, help="Max sequence depth for exhaustive tier")
    parser.add_argument("--output", default=None, help="Output directory (per-action files) or file path with --single")
    parser.add_argument("--single", action="store_true", help="Write one combined file instead of one file per action")
    args = parser.parse_args()

    spec_path = Path(args.spec)
    if not spec_path.exists():
        print(f"Error: {spec_path} not found", file=sys.stderr)
        sys.exit(1)

    source = spec_path.read_text()
    service = args.service or spec_path.stem.split("_")[0].upper()
    spec = parse_fizz(source, spec_path.name)

    n = len(spec.non_init_actions)
    pairs = n * (n - 1)
    old_triples = n * (n - 1) * (n - 2) if n >= 3 and args.depth >= 3 else 0
    new_triples = pairs if n >= 3 and args.depth >= 3 else 0

    print(f"Parsed from {spec_path.name}:", file=sys.stderr)
    print(f"  Init action  : {spec.init_action.name if spec.init_action else 'None'}", file=sys.stderr)
    print(f"  Actions      : {[a.name for a in spec.non_init_actions]}", file=sys.stderr)
    print(f"  Assertions   : {[a.name for a in spec.assertions if not a.is_liveness]}", file=sys.stderr)
    print(f"  Liveness     : {[a.name for a in spec.assertions if a.is_liveness]}", file=sys.stderr)
    print(f"  Tier         : {args.tier}", file=sys.stderr)
    if args.tier == "exhaustive":
        print(f"  Covering set : {pairs} pairs + {new_triples} triples = {pairs + new_triples} scenarios", file=sys.stderr)
        print(f"  (vs naive    : {pairs} pairs + {old_triples} triples = {pairs + old_triples} scenarios)", file=sys.stderr)

    if args.single:
        output = generate_feature(spec, service, args.tier, args.depth)
        if args.output:
            out_path = Path(args.output)
            out_path.parent.mkdir(parents=True, exist_ok=True)
            out_path.write_text(output)
            print(f"Written to {args.output}", file=sys.stderr)
        else:
            print(output)
    else:
        if args.output:
            out_dir = Path(args.output)
            out_dir.mkdir(parents=True, exist_ok=True)
            for action in spec.non_init_actions:
                content = generate_action_feature(action, spec, service, args.tier)
                out_path = out_dir / f"{_snake(action.name)}.feature"
                out_path.write_text(content)
                print(f"Written to {out_path}", file=sys.stderr)
            for assertion in spec.assertions:
                if _is_stub(assertion):
                    content = generate_stub_assertion_feature(assertion, spec, service)
                    out_path = out_dir / f"{_snake(assertion.name)}.feature"
                    out_path.write_text(content)
                    print(f"Written to {out_path}", file=sys.stderr)
            if args.tier == "exhaustive":
                sequences = build_sequence_scenarios(spec, depth=args.depth)
                if sequences:
                    lines = _feature_header(service, f"{service} - Action Sequences", spec)
                    lines.extend(build_background(spec.init_action))
                    for scenario in sequences:
                        lines.extend(scenario)
                        lines.append("")
                    out_path = out_dir / "sequences.feature"
                    out_path.write_text("\n".join(lines))
                    print(f"Written to {out_path}", file=sys.stderr)
        else:
            # stdout: print all actions separated by a blank line
            for action in spec.non_init_actions:
                print(generate_action_feature(action, spec, service, args.tier))
            for assertion in spec.assertions:
                if _is_stub(assertion):
                    print(generate_stub_assertion_feature(assertion, spec, service))
            if args.tier == "exhaustive":
                sequences = build_sequence_scenarios(spec, depth=args.depth)
                if sequences:
                    lines = _feature_header(service, f"{service} - Action Sequences", spec)
                    lines.extend(build_background(spec.init_action))
                    for scenario in sequences:
                        lines.extend(scenario)
                        lines.append("")
                    print("\n".join(lines))


if __name__ == "__main__":
    main()
