"""Application graph builder.

Builds a directed graph of infrastructure resources and their relationships
from a parsed application model. Supports topological sorting for determining
startup order and cycle detection for validating configuration.
"""

from __future__ import annotations

import logging
from collections import deque
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Protocol

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Enums
# ---------------------------------------------------------------------------


class EdgeType(Enum):
    """Types of relationships between infrastructure nodes."""

    TRIGGER = "trigger"  # e.g., API Gateway -> Lambda
    DATA_DEPENDENCY = "data"  # e.g., Lambda -> DynamoDB
    PERMISSION = "permission"  # e.g., Lambda granted access to Table
    EVENT_SOURCE = "event_source"  # e.g., SQS -> Lambda


class NodeType(Enum):
    """Types of infrastructure resources that can appear in the graph."""

    LAMBDA_FUNCTION = "lambda_function"
    DYNAMODB_TABLE = "dynamodb_table"
    API_GATEWAY = "api_gateway"
    SQS_QUEUE = "sqs_queue"
    S3_BUCKET = "s3_bucket"
    SNS_TOPIC = "sns_topic"
    EVENT_BUS = "event_bus"
    STATE_MACHINE = "state_machine"
    ECS_SERVICE = "ecs_service"


# ---------------------------------------------------------------------------
# Data structures
# ---------------------------------------------------------------------------


@dataclass
class GraphNode:
    """A single node in the application graph representing an infrastructure resource."""

    id: str
    node_type: NodeType
    config: dict[str, Any] = field(default_factory=dict)


@dataclass
class GraphEdge:
    """A directed edge between two nodes in the application graph."""

    source: str  # node id
    target: str  # node id
    edge_type: EdgeType
    metadata: dict[str, Any] = field(default_factory=dict)


# ---------------------------------------------------------------------------
# Protocol for the app model (duck-typed)
# ---------------------------------------------------------------------------


class _HasFunctions(Protocol):
    @property
    def functions(self) -> list[Any]: ...


class _HasTables(Protocol):
    @property
    def tables(self) -> list[Any]: ...


class _HasApis(Protocol):
    @property
    def apis(self) -> list[Any]: ...


class AppModelProtocol(_HasFunctions, _HasTables, _HasApis, Protocol):
    """Structural type for an application model with functions, tables, and APIs."""

    ...


# ---------------------------------------------------------------------------
# AppGraph
# ---------------------------------------------------------------------------


class AppGraph:
    """Directed graph of infrastructure resources and their relationships.

    Nodes represent individual resources (Lambda functions, DynamoDB tables, etc.)
    and edges encode trigger, data-dependency, permission, and event-source
    relationships between them.
    """

    def __init__(self) -> None:
        self.nodes: dict[str, GraphNode] = {}
        self.edges: list[GraphEdge] = []

    def add_node(self, node: GraphNode) -> None:
        """Add a node to the graph.

        Parameters
        ----------
        node:
            The graph node to add. If a node with the same ``id`` already
            exists it will be overwritten.
        """
        self.nodes[node.id] = node

    def add_edge(self, edge: GraphEdge) -> None:
        """Add a directed edge to the graph.

        Parameters
        ----------
        edge:
            The graph edge to add. Both ``source`` and ``target`` node IDs
            should already be present in the graph, but this is not enforced
            to allow incremental construction.
        """
        self.edges.append(edge)

    # -----------------------------------------------------------------
    # Queries
    # -----------------------------------------------------------------

    def get_dependencies(self, node_id: str) -> list[str]:
        """Return the IDs of nodes that *node_id* depends on.

        A dependency is defined as an outgoing ``DATA_DEPENDENCY`` edge
        from *node_id* to another node.

        Parameters
        ----------
        node_id:
            The node whose dependencies to look up.

        Returns
        -------
        list[str]
            Node IDs that *node_id* depends on.
        """
        return [
            edge.target
            for edge in self.edges
            if edge.source == node_id and edge.edge_type == EdgeType.DATA_DEPENDENCY
        ]

    def get_dependents(self, node_id: str) -> list[str]:
        """Return the IDs of nodes that depend on *node_id*.

        A dependent is any node that has an outgoing ``DATA_DEPENDENCY``
        edge pointing to *node_id*.

        Parameters
        ----------
        node_id:
            The node whose dependents to look up.

        Returns
        -------
        list[str]
            Node IDs that depend on *node_id*.
        """
        return [
            edge.source
            for edge in self.edges
            if edge.target == node_id and edge.edge_type == EdgeType.DATA_DEPENDENCY
        ]

    # -----------------------------------------------------------------
    # Topological sort (Kahn's algorithm)
    # -----------------------------------------------------------------

    def _build_adjacency(self) -> tuple[dict[str, int], dict[str, list[str]]]:
        """Build in-degree and adjacency maps for topological sorting."""
        in_degree: dict[str, int] = {nid: 0 for nid in self.nodes}
        adjacency: dict[str, list[str]] = {nid: [] for nid in self.nodes}
        for edge in self.edges:
            if edge.source in self.nodes and edge.target in self.nodes:
                adjacency[edge.target].append(edge.source)
                in_degree[edge.source] += 1
        return in_degree, adjacency

    def topological_sort(self) -> list[str]:
        """Return node IDs in topological (startup) order using Kahn's algorithm.

        Dependencies come first so that every node's dependencies are
        already running when it starts.

        Returns
        -------
        list[str]
            Node IDs in startup order.  If the graph contains a cycle the
            returned list will be shorter than the total number of nodes.
        """
        in_degree, adjacency = self._build_adjacency()
        queue: deque[str] = deque(nid for nid, deg in in_degree.items() if deg == 0)

        result: list[str] = []
        while queue:
            node_id = queue.popleft()
            result.append(node_id)
            for neighbour in adjacency[node_id]:
                in_degree[neighbour] -= 1
                if in_degree[neighbour] == 0:
                    queue.append(neighbour)

        return result

    # -----------------------------------------------------------------
    # Cycle detection
    # -----------------------------------------------------------------

    def detect_cycles(self) -> list[list[str]]:
        """Detect all elementary cycles in the graph.

        Uses a DFS-based approach to find strongly-connected components and
        then extracts individual cycles.

        Returns
        -------
        list[list[str]]
            A list of cycles where each cycle is a list of node IDs.
            Returns an empty list if the graph is a DAG.
        """
        adjacency: dict[str, list[str]] = {nid: [] for nid in self.nodes}
        for edge in self.edges:
            if edge.source in self.nodes and edge.target in self.nodes:
                adjacency[edge.source].append(edge.target)

        WHITE, GRAY, BLACK = 0, 1, 2
        color: dict[str, int] = {nid: WHITE for nid in self.nodes}
        path: list[str] = []
        cycles: list[list[str]] = []

        def dfs(node_id: str) -> None:
            color[node_id] = GRAY
            path.append(node_id)

            for neighbour in adjacency[node_id]:
                if color[neighbour] == GRAY:
                    # Found a back-edge; extract the cycle.
                    cycle_start = path.index(neighbour)
                    cycles.append(path[cycle_start:] + [neighbour])
                elif color[neighbour] == WHITE:
                    dfs(neighbour)

            path.pop()
            color[node_id] = BLACK

        for node_id in self.nodes:
            if color[node_id] == WHITE:
                dfs(node_id)

        return cycles


# ---------------------------------------------------------------------------
# Graph builder
# ---------------------------------------------------------------------------


def _add_table_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add DynamoDB table nodes to the graph."""
    for table in getattr(app_model, "tables", []):
        logical_id = getattr(table, "logical_id", None) or str(id(table))
        table_name = getattr(table, "table_name", logical_id)
        graph.add_node(
            GraphNode(
                id=logical_id,
                node_type=NodeType.DYNAMODB_TABLE,
                config={"table_name": table_name},
            )
        )


def _add_function_data_edges(graph: AppGraph, logical_id: str, environment: dict[str, str]) -> None:
    """Create DATA_DEPENDENCY edges from a function to tables it references."""
    for env_key, env_value in environment.items():
        for table_node_id, table_node in graph.nodes.items():
            if table_node.node_type != NodeType.DYNAMODB_TABLE:
                continue
            table_name = table_node.config.get("table_name", "")
            if table_name and table_name == env_value:
                graph.add_edge(
                    GraphEdge(
                        source=logical_id,
                        target=table_node_id,
                        edge_type=EdgeType.DATA_DEPENDENCY,
                        metadata={"env_var": env_key},
                    )
                )


def _add_function_nodes(graph: AppGraph, app_model: Any) -> dict[str, str]:
    """Add Lambda function nodes and data-dependency edges. Returns handler map."""
    handler_to_function: dict[str, str] = {}
    for func in getattr(app_model, "functions", []):
        logical_id = getattr(func, "logical_id", None) or str(id(func))
        handler = getattr(func, "handler", None) or ""
        environment: dict[str, str] = getattr(func, "environment", {})

        graph.add_node(
            GraphNode(
                id=logical_id,
                node_type=NodeType.LAMBDA_FUNCTION,
                config={"handler": handler, "environment": environment},
            )
        )
        handler_to_function[handler] = logical_id
        handler_to_function[logical_id] = logical_id

        _add_function_data_edges(graph, logical_id, environment)

    return handler_to_function


def _add_api_nodes(graph: AppGraph, app_model: Any, handler_to_function: dict[str, str]) -> None:
    """Add API Gateway nodes and trigger edges."""
    for api in getattr(app_model, "apis", []):
        api_logical_id = getattr(api, "logical_id", None) or str(id(api))
        graph.add_node(
            GraphNode(
                id=api_logical_id,
                node_type=NodeType.API_GATEWAY,
                config={},
            )
        )
        for route in getattr(api, "routes", []):
            handler_name = getattr(route, "handler_name", None)
            if handler_name and handler_name in handler_to_function:
                target_func_id = handler_to_function[handler_name]
                graph.add_edge(
                    GraphEdge(
                        source=api_logical_id,
                        target=target_func_id,
                        edge_type=EdgeType.TRIGGER,
                        metadata={
                            "http_method": getattr(route, "http_method", None),
                            "resource_path": getattr(route, "resource_path", None),
                        },
                    )
                )


def _add_queue_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add SQS queue nodes to the graph."""
    for queue in getattr(app_model, "queues", []):
        name = getattr(queue, "name", str(id(queue)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.SQS_QUEUE,
                config={"queue_name": name},
            )
        )


def _add_bucket_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add S3 bucket nodes to the graph."""
    for bucket in getattr(app_model, "buckets", []):
        name = getattr(bucket, "name", str(id(bucket)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.S3_BUCKET,
                config={"bucket_name": name},
            )
        )


def _add_topic_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add SNS topic nodes to the graph."""
    for topic in getattr(app_model, "topics", []):
        name = getattr(topic, "name", str(id(topic)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.SNS_TOPIC,
                config={"topic_name": name},
            )
        )


def _add_event_bus_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add EventBridge event bus nodes to the graph."""
    for bus in getattr(app_model, "event_buses", []):
        name = getattr(bus, "name", str(id(bus)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.EVENT_BUS,
                config={"bus_name": name},
            )
        )


def _add_state_machine_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add Step Functions state machine nodes to the graph."""
    for sm in getattr(app_model, "state_machines", []):
        name = getattr(sm, "name", str(id(sm)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.STATE_MACHINE,
                config={"state_machine_name": name},
            )
        )


def _add_ecs_nodes(graph: AppGraph, app_model: Any) -> None:
    """Add ECS service nodes to the graph."""
    for svc in getattr(app_model, "ecs_services", []):
        name = getattr(svc, "service_name", str(id(svc)))
        graph.add_node(
            GraphNode(
                id=name,
                node_type=NodeType.ECS_SERVICE,
                config={"service_name": name},
            )
        )


def build_graph(app_model: Any) -> AppGraph:
    """Build an AppGraph from an application model.

    The *app_model* is expected to have ``functions``, ``tables``, and
    ``apis`` attributes, plus optional ``queues``, ``buckets``, ``topics``,
    ``event_buses``, ``state_machines``, and ``ecs_services``.

    Parameters
    ----------
    app_model:
        An object with infrastructure resource attributes.

    Returns
    -------
    AppGraph
        A fully populated application graph.
    """
    graph = AppGraph()
    _add_table_nodes(graph, app_model)
    _add_queue_nodes(graph, app_model)
    _add_bucket_nodes(graph, app_model)
    _add_topic_nodes(graph, app_model)
    _add_event_bus_nodes(graph, app_model)
    _add_state_machine_nodes(graph, app_model)
    _add_ecs_nodes(graph, app_model)
    handler_to_function = _add_function_nodes(graph, app_model)
    _add_api_nodes(graph, app_model, handler_to_function)
    return graph
