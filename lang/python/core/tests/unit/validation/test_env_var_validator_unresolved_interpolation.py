"""Tests for ldk.validation.env_var_validator."""

from __future__ import annotations

from lws.graph.builder import AppGraph, GraphNode, NodeType
from lws.validation.engine import ValidationContext, ValidationLevel
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


class TestUnresolvedInterpolation:
    def test_unknown_interpolation_ref(self) -> None:
        # Arrange
        expected_issue_count = 1
        expected_ref_name = "UnknownTable"
        expected_env_var_name = "TABLE_ARN"
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={expected_env_var_name: f"${{{expected_ref_name}}}"})

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert len(issues) == expected_issue_count
        assert issues[0].level == ValidationLevel.ERROR
        assert expected_ref_name in issues[0].message
        assert expected_env_var_name in issues[0].message

    def test_arn_like_ref_is_skipped(self) -> None:
        # Arrange
        graph = _make_graph([])
        validator = EnvVarValidator(graph)
        ctx = _make_context(
            environment={"SOMETHING": "${arn:aws:dynamodb:us-east-1:123:table/users}"}
        )

        # Act
        issues = validator.validate(ctx)

        # Assert
        assert issues == []
