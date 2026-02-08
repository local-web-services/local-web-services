"""Tests for ldk.validation.env_var_validator."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, GraphNode, NodeType
from ldk.validation.engine import ValidationContext, ValidationLevel
from ldk.validation.env_var_validator import EnvVarValidator

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_graph(node_ids: list[str] | None = None) -> AppGraph:
    """Create a graph with the given node IDs as Lambda functions."""
    graph = AppGraph()
    for nid in node_ids or []:
        graph.add_node(GraphNode(id=nid, node_type=NodeType.LAMBDA_FUNCTION))
    return graph


def _make_context(
    environment: dict[str, str] | None = None,
    handler_id: str = "handler1",
) -> ValidationContext:
    return ValidationContext(
        handler_id=handler_id,
        resource_id=handler_id,
        operation="startup",
        data={"environment": environment or {}},
    )


# ---------------------------------------------------------------------------
# Resolved references (no issues)
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Unresolved ${ref} references
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# CloudFormation Ref markers
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# CloudFormation Fn::GetAtt markers
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# No environment data
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestUnresolvedInterpolation:
    def test_unknown_interpolation_ref(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE_ARN": "${UnknownTable}"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert issues[0].level == ValidationLevel.ERROR
        assert "UnknownTable" in issues[0].message
        assert "TABLE_ARN" in issues[0].message

    def test_arn_like_ref_is_skipped(self) -> None:
        graph = _make_graph([])
        validator = EnvVarValidator(graph)
        ctx = _make_context(
            environment={"SOMETHING": "${arn:aws:dynamodb:us-east-1:123:table/users}"}
        )
        issues = validator.validate(ctx)
        assert issues == []
