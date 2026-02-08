"""Tests for ldk.graph.builder."""

from __future__ import annotations

from dataclasses import dataclass, field

from ldk.graph.builder import (
    AppGraph,
    EdgeType,
    GraphEdge,
    GraphNode,
    NodeType,
    build_graph,
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


@dataclass
class MockRoute:
    http_method: str
    resource_path: str
    handler_name: str


@dataclass
class MockFunction:
    logical_id: str
    handler: str
    environment: dict[str, str] = field(default_factory=dict)


@dataclass
class MockTable:
    logical_id: str
    table_name: str


@dataclass
class MockApi:
    logical_id: str
    routes: list[MockRoute] = field(default_factory=list)


@dataclass
class MockAppModel:
    functions: list[MockFunction] = field(default_factory=list)
    tables: list[MockTable] = field(default_factory=list)
    apis: list[MockApi] = field(default_factory=list)


# ---------------------------------------------------------------------------
# add_node / add_edge
# ---------------------------------------------------------------------------


class TestAddNodeAndEdge:
    def test_add_node(self) -> None:
        graph = AppGraph()
        node = GraphNode(id="my-table", node_type=NodeType.DYNAMODB_TABLE)
        graph.add_node(node)

        assert "my-table" in graph.nodes
        assert graph.nodes["my-table"] is node

    def test_add_node_overwrites_duplicate(self) -> None:
        graph = AppGraph()
        node1 = GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION, config={"v": 1})
        node2 = GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION, config={"v": 2})
        graph.add_node(node1)
        graph.add_node(node2)

        assert graph.nodes["fn"].config == {"v": 2}

    def test_add_edge(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        edge = GraphEdge(source="a", target="b", edge_type=EdgeType.TRIGGER)
        graph.add_edge(edge)

        assert len(graph.edges) == 1
        assert graph.edges[0] is edge


# ---------------------------------------------------------------------------
# get_dependencies / get_dependents
# ---------------------------------------------------------------------------


class TestDependencies:
    def _make_chain_graph(self) -> AppGraph:
        """API --TRIGGER--> Lambda --DATA_DEPENDENCY--> Table."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="api", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="table", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_edge(GraphEdge(source="api", target="fn", edge_type=EdgeType.TRIGGER))
        graph.add_edge(
            GraphEdge(
                source="fn",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        return graph

    def test_get_dependencies_returns_data_targets(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependencies("fn") == ["table"]

    def test_get_dependencies_ignores_trigger_edges(self) -> None:
        graph = self._make_chain_graph()
        # API has a TRIGGER edge, not DATA_DEPENDENCY, so no dependencies.
        assert graph.get_dependencies("api") == []

    def test_get_dependents_returns_data_sources(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependents("table") == ["fn"]

    def test_get_dependents_empty_for_leaf(self) -> None:
        graph = self._make_chain_graph()
        assert graph.get_dependents("api") == []


# ---------------------------------------------------------------------------
# topological_sort
# ---------------------------------------------------------------------------


class TestTopologicalSort:
    def test_linear_chain(self) -> None:
        """API -> Lambda -> Table should sort as: Table, Lambda, API."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="api", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="table", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_edge(GraphEdge(source="api", target="fn", edge_type=EdgeType.TRIGGER))
        graph.add_edge(
            GraphEdge(
                source="fn",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        order = graph.topological_sort()
        assert len(order) == 3
        # table must come before fn, fn must come before api
        assert order.index("table") < order.index("fn")
        assert order.index("fn") < order.index("api")

    def test_multiple_independent_routes(self) -> None:
        """Two independent API -> Lambda chains should both appear in full."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="api1", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="api2", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="fn2", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(GraphEdge(source="api1", target="fn1", edge_type=EdgeType.TRIGGER))
        graph.add_edge(GraphEdge(source="api2", target="fn2", edge_type=EdgeType.TRIGGER))

        order = graph.topological_sort()
        assert len(order) == 4
        assert order.index("fn1") < order.index("api1")
        assert order.index("fn2") < order.index("api2")

    def test_empty_graph(self) -> None:
        graph = AppGraph()
        assert graph.topological_sort() == []

    def test_single_node(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="solo", node_type=NodeType.S3_BUCKET))
        assert graph.topological_sort() == ["solo"]

    def test_shared_dependency(self) -> None:
        """Two functions sharing a table dependency."""
        graph = AppGraph()
        graph.add_node(GraphNode(id="table", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_node(GraphNode(id="fn1", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="fn2", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(
            GraphEdge(
                source="fn1",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="fn2",
                target="table",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        order = graph.topological_sort()
        assert len(order) == 3
        assert order.index("table") < order.index("fn1")
        assert order.index("table") < order.index("fn2")


# ---------------------------------------------------------------------------
# detect_cycles
# ---------------------------------------------------------------------------


class TestDetectCycles:
    def test_dag_has_no_cycles(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.API_GATEWAY))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="c", node_type=NodeType.DYNAMODB_TABLE))
        graph.add_edge(GraphEdge(source="a", target="b", edge_type=EdgeType.TRIGGER))
        graph.add_edge(
            GraphEdge(
                source="b",
                target="c",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        assert graph.detect_cycles() == []

    def test_simple_cycle_detected(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="a", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="b", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_edge(
            GraphEdge(
                source="a",
                target="b",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="b",
                target="a",
                edge_type=EdgeType.DATA_DEPENDENCY,
            )
        )

        cycles = graph.detect_cycles()
        assert len(cycles) >= 1
        # The cycle must include both a and b
        flat = [nid for cycle in cycles for nid in cycle]
        assert "a" in flat
        assert "b" in flat

    def test_three_node_cycle(self) -> None:
        graph = AppGraph()
        graph.add_node(GraphNode(id="x", node_type=NodeType.LAMBDA_FUNCTION))
        graph.add_node(GraphNode(id="y", node_type=NodeType.SQS_QUEUE))
        graph.add_node(GraphNode(id="z", node_type=NodeType.SNS_TOPIC))
        graph.add_edge(
            GraphEdge(
                source="x",
                target="y",
                edge_type=EdgeType.EVENT_SOURCE,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="y",
                target="z",
                edge_type=EdgeType.TRIGGER,
            )
        )
        graph.add_edge(
            GraphEdge(
                source="z",
                target="x",
                edge_type=EdgeType.TRIGGER,
            )
        )

        cycles = graph.detect_cycles()
        assert len(cycles) >= 1

    def test_empty_graph_no_cycles(self) -> None:
        graph = AppGraph()
        assert graph.detect_cycles() == []


# ---------------------------------------------------------------------------
# build_graph
# ---------------------------------------------------------------------------


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
