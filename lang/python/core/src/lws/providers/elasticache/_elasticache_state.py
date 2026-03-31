"""In-memory state models for the ElastiCache provider."""

from __future__ import annotations

import time
from typing import Any

from lws.providers._shared.resource_container import ResourceContainerManager
from lws.providers._shared.response_helpers import parse_endpoint as _parse_endpoint

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


class _CacheCluster:
    """Represents an ElastiCache cache cluster."""

    def __init__(
        self,
        cache_cluster_id: str,
        engine: str = "redis",
        num_cache_nodes: int = 1,
        cache_node_type: str = "cache.t3.micro",
        tags: dict[str, str] | None = None,
        data_plane_endpoint: str | None = None,
    ) -> None:
        self.cache_cluster_id = cache_cluster_id
        self.engine = engine
        self.num_cache_nodes = num_cache_nodes
        self.cache_node_type = cache_node_type
        self.status = "available"
        self.arn = f"arn:aws:elasticache:{_REGION}:{_ACCOUNT_ID}:cluster:{cache_cluster_id}"
        if data_plane_endpoint:
            addr, pt = _parse_endpoint(data_plane_endpoint)
            self.endpoint: dict[str, Any] = {"Address": addr, "Port": pt}
        else:
            self.endpoint = {"Address": f"{cache_cluster_id}.cache.localhost", "Port": 6379}
        self.tags: dict[str, str] = tags or {}
        self.created_date: float = time.time()


class _ReplicationGroup:
    """Represents an ElastiCache replication group."""

    def __init__(
        self,
        replication_group_id: str,
        description: str = "",
        member_clusters: list[str] | None = None,
        tags: dict[str, str] | None = None,
    ) -> None:
        self.replication_group_id = replication_group_id
        self.description = description
        self.status = "available"
        self.member_clusters: list[str] = member_clusters or []
        self.arn = (
            f"arn:aws:elasticache:{_REGION}:{_ACCOUNT_ID}"
            f":replicationgroup:{replication_group_id}"
        )
        self.tags: dict[str, str] = tags or {}
        self.notification_topic_arn: str | None = None


class _ElastiCacheState:
    """In-memory store for ElastiCache resources."""

    def __init__(self, *, container_manager: ResourceContainerManager | None = None) -> None:
        self._clusters: dict[str, _CacheCluster] = {}
        self._replication_groups: dict[str, _ReplicationGroup] = {}
        self.container_manager = container_manager

    @property
    def clusters(self) -> dict[str, _CacheCluster]:
        """Return the clusters store."""
        return self._clusters

    @property
    def replication_groups(self) -> dict[str, _ReplicationGroup]:
        """Return the replication groups store."""
        return self._replication_groups
