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

from ._helpers import FakeApi, FakeAppModel, FakeFunction, FakeRoute, FakeTable


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

        model = FakeAppModel(
            tables=[FakeTable(logical_id=table_id, table_name=table_name)],
            functions=[
                FakeFunction(
                    logical_id=function_id,
                    handler=handler_name,
                    environment={"TABLE_NAME": table_name},
                ),
            ],
            apis=[
                FakeApi(
                    logical_id=api_id,
                    routes=[
                        FakeRoute(
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
        assert table_id in graph.nodes, f"Expected {table_id!r} to be in {graph.nodes!r}"
        assert graph.nodes[table_id].node_type == NodeType.DYNAMODB_TABLE, f"Expected {NodeType.DYNAMODB_TABLE!r} but got {graph.nodes[table_id].node_type!r}"
        assert function_id in graph.nodes, f"Expected {function_id!r} to be in {graph.nodes!r}"
        assert graph.nodes[function_id].node_type == NodeType.LAMBDA_FUNCTION, f"Expected {NodeType.LAMBDA_FUNCTION!r} but got {graph.nodes[function_id].node_type!r}"
        assert api_id in graph.nodes, f"Expected {api_id!r} to be in {graph.nodes!r}"
        assert graph.nodes[api_id].node_type == NodeType.API_GATEWAY, f"Expected {NodeType.API_GATEWAY!r} but got {graph.nodes[api_id].node_type!r}"

        # Assert -- Edges -- data dependency: GetUserFn -> UsersTable
        data_edges = [e for e in graph.edges if e.edge_type == EdgeType.DATA_DEPENDENCY]
        assert len(data_edges) == expected_edge_count, f"Expected {expected_edge_count!r} but got {len(data_edges)!r}"
        assert data_edges[0].source == function_id, f"Expected {function_id!r} but got {data_edges[0].source!r}"
        assert data_edges[0].target == table_id, f"Expected {table_id!r} but got {data_edges[0].target!r}"

        # Assert -- Edges -- trigger: MyApi -> GetUserFn
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == expected_edge_count, f"Expected {expected_edge_count!r} but got {len(trigger_edges)!r}"
        assert trigger_edges[0].source == api_id, f"Expected {api_id!r} but got {trigger_edges[0].source!r}"
        assert trigger_edges[0].target == function_id, f"Expected {function_id!r} but got {trigger_edges[0].target!r}"

    def test_topological_order_of_built_graph(self) -> None:
        """Startup order should be: table, function, api."""
        # Arrange
        table_id = "T"
        function_id = "F"
        api_id = "A"
        handler = "h"
        table_name = "t"

        model = FakeAppModel(
            tables=[FakeTable(logical_id=table_id, table_name=table_name)],
            functions=[
                FakeFunction(
                    logical_id=function_id,
                    handler=handler,
                    environment={"TBL": table_name},
                ),
            ],
            apis=[
                FakeApi(
                    logical_id=api_id,
                    routes=[FakeRoute("GET", "/", handler)],
                ),
            ],
        )

        # Act
        graph = build_graph(model)
        actual_order = graph.topological_sort()

        # Assert
        assert actual_order.index(table_id) < actual_order.index(function_id), f"Expected {actual_order.index(table_id)!r} < {actual_order.index(function_id)!r}"
        assert actual_order.index(function_id) < actual_order.index(api_id), f"Expected {actual_order.index(function_id)!r} < {actual_order.index(api_id)!r}"

    def test_build_graph_empty_model(self) -> None:
        # Arrange
        expected_node_count = 0
        expected_edge_count = 0
        model = FakeAppModel()

        # Act
        graph = build_graph(model)

        # Assert
        assert len(graph.nodes) == expected_node_count, f"Expected {expected_node_count!r} but got {len(graph.nodes)!r}"
        assert len(graph.edges) == expected_edge_count, f"Expected {expected_edge_count!r} but got {len(graph.edges)!r}"

    def test_function_without_table_reference(self) -> None:
        """A function whose env vars do not reference any table should have no data edges."""
        # Arrange
        expected_data_edge_count = 0
        model = FakeAppModel(
            tables=[FakeTable(logical_id="T", table_name="mytable")],
            functions=[
                FakeFunction(
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
        assert len(data_edges) == expected_data_edge_count, f"Expected {expected_data_edge_count!r} but got {len(data_edges)!r}"

    def test_multiple_functions_sharing_table(self) -> None:
        # Arrange
        table_id = "SharedTable"
        fn1_id = "Fn1"
        fn2_id = "Fn2"
        expected_data_edge_count = 2
        expected_sources = {fn1_id, fn2_id}
        table_name = "shared"

        model = FakeAppModel(
            tables=[FakeTable(logical_id=table_id, table_name=table_name)],
            functions=[
                FakeFunction(
                    logical_id=fn1_id,
                    handler="fn1.handler",
                    environment={"TABLE": table_name},
                ),
                FakeFunction(
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
        assert len(data_edges) == expected_data_edge_count, f"Expected {expected_data_edge_count!r} but got {len(data_edges)!r}"
        actual_sources = {e.source for e in data_edges}
        assert actual_sources == expected_sources, f"Expected {expected_sources!r} but got {actual_sources!r}"
        assert all(e.target == table_id for e in data_edges), "Expected value to be truthy"

    def test_api_route_no_matching_handler(self) -> None:
        """An API route whose handler_name doesn't match any function creates no trigger edge."""
        # Arrange
        expected_trigger_edge_count = 0
        model = FakeAppModel(
            functions=[
                FakeFunction(logical_id="F", handler="real.handler", environment={}),
            ],
            apis=[
                FakeApi(
                    logical_id="A",
                    routes=[FakeRoute("GET", "/", "nonexistent.handler")],
                ),
            ],
        )

        # Act
        graph = build_graph(model)

        # Assert
        trigger_edges = [e for e in graph.edges if e.edge_type == EdgeType.TRIGGER]
        assert len(trigger_edges) == expected_trigger_edge_count, f"Expected {expected_trigger_edge_count!r} but got {len(trigger_edges)!r}"
