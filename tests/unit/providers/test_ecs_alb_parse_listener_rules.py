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
        assert len(rules) == 1
        assert rules[0].priority == 10
        assert rules[0].path_pattern == "/api/*"

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
        assert len(rules) == 1
        assert rules[0].path_pattern == "/web/*"

    def test_skip_non_listener_rules(self) -> None:
        resources = {
            "Bucket": {
                "Type": "AWS::S3::Bucket",
                "Properties": {},
            }
        }
        rules = parse_listener_rules(resources)
        assert rules == []

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
        assert rules == []
