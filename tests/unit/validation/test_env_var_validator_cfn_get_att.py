"""Tests for ldk.validation.env_var_validator."""

from __future__ import annotations

from lws.graph.builder import AppGraph, GraphNode, NodeType
from lws.validation.engine import ValidationContext
from lws.validation.env_var_validator import EnvVarValidator

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


class TestCfnGetAtt:
    def test_fn_getatt_known_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE_ARN": "Fn::GetAtt MyTable.Arn"})
        issues = validator.validate(ctx)
        assert issues == []

    def test_fn_getatt_unknown_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"ARN": "Fn::GetAtt BadResource.Arn"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "BadResource" in issues[0].message

    def test_bang_getatt_unknown_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"ARN": "!GetAtt Missing.Arn"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "Missing" in issues[0].message
