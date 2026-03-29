"""Constants and shared helpers."""

from __future__ import annotations

INT_CLUSTER = "int-neptune-cluster-1"

INT_INSTANCE = "int-neptune-instance-1"

INT_SNAPSHOT = "int-neptune-snapshot-1"

INT_CLUSTER2 = "int-neptune-cluster-2"

_NEPTUNE_TARGET = "AmazonNeptune"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
