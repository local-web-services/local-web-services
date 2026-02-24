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
        # Arrange
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE_ARN": "Fn::GetAtt MyTable.Arn"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert issues == []

    def test_fn_getatt_unknown_resource(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_resource_name = "BadResource"
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"ARN": f"Fn::GetAtt {expected_resource_name}.Arn"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert expected_resource_name in issues[0].message

    def test_bang_getatt_unknown_resource(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_resource_name = "Missing"
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"ARN": f"!GetAtt {expected_resource_name}.Arn"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert expected_resource_name in issues[0].message
