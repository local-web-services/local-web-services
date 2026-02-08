"""Tests for ldk.graph.builder."""

from __future__ import annotations

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# add_node / add_edge
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# get_dependencies / get_dependents
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# topological_sort
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# detect_cycles
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# build_graph
# ---------------------------------------------------------------------------
from ldk.graph.builder import (
    EdgeType,
    NodeType,
    build_graph,
)

from ._helpers import MockApi, MockAppModel, MockFunction, MockRoute, MockTable


class TestBuildGraph:
    def test_simple_app_model(self) -> None:
        """API with one route -> Lambda -> DynamoDB table."""
        model = MockAppModel(
            tables=[MockTable(logical_id="UsersTable", table_name="users")],
            functions=[
                MockFunction(
                    logical_id="GetUserFn",
                    handler="get_user.handler",
                    environment={"TABLE_NAME": "users"},
                ),
            ],
            apis=[
                MockApi(
                    logical_id="MyApi",
                    routes=[
                        MockRoute(
                            http_method="GET",
                            resource_path="/users/{id}",
                            handler_name="get_user.handler",
                        ),
                    ],
                ),
            ],
        )

        graph = build_graph(model)

        # Nodes
        assert "UsersTable" in graph.nodes
        assert graph.nodes["UsersTable"].node_type == NodeType.DYNAMODB_TABLE
        assert "GetUserFn" in graph.nodes
        assert graph.nodes["GetUserFn"].node_type == NodeType.LAMBDA_FUNCTION
        assert "MyApi" in graph.nodes
        assert graph.nodes["MyApi"].node_type == NodeType.API_GATEWAY

        # Edges -- data dependency: GetUserFn -> UsersTable
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == 1
        assert data_edges[0].source == "GetUserFn"
        assert data_edges[0].target == "UsersTable"

        # Edges -- trigger: MyApi -> GetUserFn
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == 1
        assert trigger_edges[0].source == "MyApi"
        assert trigger_edges[0].target == "GetUserFn"

    def test_topological_order_of_built_graph(self) -> None:
        """Startup order should be: table, function, api."""
        model = MockAppModel(
            tables=[MockTable(logical_id="T", table_name="t")],
            functions=[
                MockFunction(logical_id="F", handler="h", environment={"TBL": "t"}),
            ],
            apis=[
                MockApi(
                    logical_id="A",
                    routes=[MockRoute("GET", "/", "h")],
                ),
            ],
        )

        graph = build_graph(model)
        order = graph.topological_sort()

        assert order.index("T") < order.index("F")
        assert order.index("F") < order.index("A")

    def test_build_graph_empty_model(self) -> None:
        model = MockAppModel()
        graph = build_graph(model)
        assert len(graph.nodes) == 0
        assert len(graph.edges) == 0

    def test_function_without_table_reference(self) -> None:
        """A function whose env vars do not reference any table should have no data edges."""
        model = MockAppModel(
            tables=[MockTable(logical_id="T", table_name="mytable")],
            functions=[
                MockFunction(
                    logical_id="F",
                    handler="handler",
                    environment={"SOME_VAR": "unrelated_value"},
                ),
            ],
        )

        graph = build_graph(model)
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == 0

    def test_multiple_functions_sharing_table(self) -> None:
        model = MockAppModel(
            tables=[MockTable(logical_id="SharedTable", table_name="shared")],
            functions=[
                MockFunction(
                    logical_id="Fn1",
                    handler="fn1.handler",
                    environment={"TABLE": "shared"},
                ),
                MockFunction(
                    logical_id="Fn2",
                    handler="fn2.handler",
                    environment={"TABLE": "shared"},
                ),
            ],
        )

        graph = build_graph(model)
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == 2
        sources = {e.source for e in data_edges}
        assert sources == {"Fn1", "Fn2"}
        assert all(e.target == "SharedTable" for e in data_edges)

    def test_api_route_no_matching_handler(self) -> None:
        """An API route whose handler_name doesn't match any function creates no trigger edge."""
        model = MockAppModel(
            functions=[
                MockFunction(logical_id="F", handler="real.handler", environment={}),
            ],
            apis=[
                MockApi(
                    logical_id="A",
                    routes=[MockRoute("GET", "/", "nonexistent.handler")],
                ),
            ],
        )

        graph = build_graph(model)
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == 0
