"""Constants and shared helpers."""

from __future__ import annotations

INT_DB_INSTANCE = "int-rds-instance-1"

INT_DB_SNAPSHOT = "int-rds-snapshot-1"

INT_DB_CLUSTER = "int-rds-cluster-1"

INT_DB_INSTANCE2 = "int-rds-instance-2"

INT_TAG_KEY = "int-rds-tag-key-1"

INT_TAG_VALUE = "int-rds-tag-value-1"

_RDS_TARGET = "AmazonRDSv19"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
