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
from lws.graph.builder import (
    EdgeType,
    NodeType,
    build_graph,
)

from ._helpers import MockApi, MockAppModel, MockFunction, MockRoute, MockTable


class TestBuildGraph:
    def test_simple_app_model(self) -> None:
        """API with one route -> Lambda -> DynamoDB table."""
        # Arrange
        table_id = "UsersTable"
        function_id = "GetUserFn"
        api_id = "MyApi"
        handler_name = "get_user.handler"
        table_name = "users"
        expected_edge_count = 1

        model = MockAppModel(
            tables=[MockTable(logical_id=table_id, table_name=table_name)],
            functions=[
                MockFunction(
                    logical_id=function_id,
                    handler=handler_name,
                    environment={"TABLE_NAME": table_name},
                ),
            ],
            apis=[
                MockApi(
                    logical_id=api_id,
                    routes=[
                        MockRoute(
                            http_method="GET",
                            resource_path="/users/{id}",
                            handler_name=handler_name,
                        ),
                    ],
                ),
            ],
        )

        # Act
        graph = build_graph(model)

        # Assert -- Nodes
        assert table_id in graph.nodes
        assert graph.nodes[table_id].node_type == NodeType.DYNAMODB_TABLE
        assert function_id in graph.nodes
        assert graph.nodes[function_id].node_type == NodeType.LAMBDA_FUNCTION
        assert api_id in graph.nodes
        assert graph.nodes[api_id].node_type == NodeType.API_GATEWAY

        # Assert -- Edges -- data dependency: GetUserFn -> UsersTable
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == expected_edge_count
        assert data_edges[0].source == function_id
        assert data_edges[0].target == table_id

        # Assert -- Edges -- trigger: MyApi -> GetUserFn
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == expected_edge_count
        assert trigger_edges[0].source == api_id
        assert trigger_edges[0].target == function_id

    def test_topological_order_of_built_graph(self) -> None:
        """Startup order should be: table, function, api."""
        # Arrange
        table_id = "T"
        function_id = "F"
        api_id = "A"
        handler = "h"
        table_name = "t"

        model = MockAppModel(
            tables=[MockTable(logical_id=table_id, table_name=table_name)],
            functions=[
                MockFunction(
                    logical_id=function_id,
                    handler=handler,
                    environment={"TBL": table_name},
                ),
            ],
            apis=[
                MockApi(
                    logical_id=api_id,
                    routes=[MockRoute("GET", "/", handler)],
                ),
            ],
        )

        # Act
        graph = build_graph(model)
        actual_order = graph.topological_sort()

        # Assert
        assert actual_order.index(table_id) < actual_order.index(function_id)
        assert actual_order.index(function_id) < actual_order.index(api_id)

    def test_build_graph_empty_model(self) -> None:
        # Arrange
        expected_node_count = 0
        expected_edge_count = 0
        model = MockAppModel()

        # Act
        graph = build_graph(model)

        # Assert
        assert len(graph.nodes) == expected_node_count
        assert len(graph.edges) == expected_edge_count

    def test_function_without_table_reference(self) -> None:
        """A function whose env vars do not reference any table should have no data edges."""
        # Arrange
        expected_data_edge_count = 0
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

        # Act
        graph = build_graph(model)

        # Assert
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == expected_data_edge_count

    def test_multiple_functions_sharing_table(self) -> None:
        # Arrange
        table_id = "SharedTable"
        fn1_id = "Fn1"
        fn2_id = "Fn2"
        expected_data_edge_count = 2
        expected_sources = {fn1_id, fn2_id}
        table_name = "shared"

        model = MockAppModel(
            tables=[MockTable(logical_id=table_id, table_name=table_name)],
            functions=[
                MockFunction(
                    logical_id=fn1_id,
                    handler="fn1.handler",
                    environment={"TABLE": table_name},
                ),
                MockFunction(
                    logical_id=fn2_id,
                    handler="fn2.handler",
                    environment={"TABLE": table_name},
                ),
            ],
        )

        # Act
        graph = build_graph(model)

        # Assert
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == expected_data_edge_count
        actual_sources = {e.source for e in data_edges}
        assert actual_sources == expected_sources
        assert all(e.target == table_id for e in data_edges)

    def test_api_route_no_matching_handler(self) -> None:
        """An API route whose handler_name doesn't match any function creates no trigger edge."""
        # Arrange
        expected_trigger_edge_count = 0
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

        # Act
        graph = build_graph(model)

        # Assert
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == expected_trigger_edge_count
