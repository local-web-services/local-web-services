"""Tests for ldk.providers.ecs.alb."""

from __future__ import annotations

from lws.providers.ecs.alb import (
    parse_listener_rules,
)

# ---------------------------------------------------------------------------
# Path matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Rule matching tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Listener rule parsing tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# _extract_path_pattern tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ALB FastAPI app tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ListenerRule tests
# ---------------------------------------------------------------------------


class TestParseListenerRules:
    def test_parse_path_pattern_field(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 10,
                    "Conditions": [
                        {"Field": "path-pattern", "Values": ["/api/*"]},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert len(rules) == 1, f"Expected {1!r} but got {len(rules)!r}"
        assert rules[0].priority == 10, f"Expected {10!r} but got {rules[0].priority!r}"
        assert rules[0].path_pattern == "/api/*", (
            f'Expected {"/api/*"!r} but got {rules[0].path_pattern!r}'
        )

    def test_parse_path_pattern_config(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 20,
                    "Conditions": [
                        {"PathPatternConfig": {"Values": ["/web/*"]}},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert len(rules) == 1, f"Expected {1!r} but got {len(rules)!r}"
        assert rules[0].path_pattern == "/web/*", (
            f'Expected {"/web/*"!r} but got {rules[0].path_pattern!r}'
        )

    def test_skip_non_listener_rules(self) -> None:
        resources = {
            "Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {},
            }
        }
        rules = parse_listener_rules(resources)
        assert rules == [], f"Expected {[]!r} but got {rules!r}"

    def test_skip_rules_without_path_condition(self) -> None:
        resources = {
            "Rule1": {
                "Type": "AWS::ElasticLoadBalancingV2::ListenerRule",
                "Properties": {
                    "Priority": 10,
                    "Conditions": [
                        {"Field": "host-header", "Values": ["example.com"]},
                    ],
                    "Actions": [],
                },
            }
        }
        rules = parse_listener_rules(resources)
        assert rules == [], f"Expected {[]!r} but got {rules!r}"
