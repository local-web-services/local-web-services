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


class TestResolvedReferences:
    def test_no_env_vars_is_clean(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={})
        issues = validator.validate(ctx)
        assert issues == []

    def test_plain_values_are_clean(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE_NAME": "users", "REGION": "us-east-1"})
        issues = validator.validate(ctx)
        assert issues == []

    def test_known_ref_resolves(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE_ARN": "${MyTable}"})
        issues = validator.validate(ctx)
        assert issues == []


# ---------------------------------------------------------------------------
# Unresolved ${ref} references
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


# ---------------------------------------------------------------------------
# CloudFormation Ref markers
# ---------------------------------------------------------------------------


class TestCfnRefMarkers:
    def test_ref_colon_known_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE": "Ref: MyTable"})
        issues = validator.validate(ctx)
        assert issues == []

    def test_ref_colon_unknown_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE": "Ref: UnknownResource"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "UnknownResource" in issues[0].message

    def test_bang_ref_unknown_resource(self) -> None:
        graph = _make_graph(["MyTable"])
        validator = EnvVarValidator(graph)
        ctx = _make_context(environment={"TABLE": "!Ref UnknownRes"})
        issues = validator.validate(ctx)
        assert len(issues) == 1
        assert "UnknownRes" in issues[0].message


# ---------------------------------------------------------------------------
# CloudFormation Fn::GetAtt markers
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


# ---------------------------------------------------------------------------
# No environment data
# ---------------------------------------------------------------------------


class TestNoEnvironment:
    def test_missing_environment_key(self) -> None:
        graph = _make_graph([])
        validator = EnvVarValidator(graph)
        ctx = ValidationContext(
            handler_id="h",
            resource_id="h",
            operation="startup",
            data={},
        )
        issues = validator.validate(ctx)
        assert issues == []


# ---------------------------------------------------------------------------
# Validator name
# ---------------------------------------------------------------------------


class TestValidatorName:
    def test_name_is_env_var(self) -> None:
        graph = _make_graph([])
        assert EnvVarValidator(graph).name == "env_var"
