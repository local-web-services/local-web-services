"""Tests for ldk.validation.env_var_validator."""

from __future__ import annotations

from ldk.graph.builder import AppGraph, GraphNode, NodeType
from ldk.validation.engine import ValidationContext
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


class TestValidatorName:
    def test_name_is_env_var(self) -> None:
        graph = _make_graph([])
        assert EnvVarValidator(graph).name == "env_var"
