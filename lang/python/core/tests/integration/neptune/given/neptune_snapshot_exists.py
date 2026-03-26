"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given("the snapshot exists")
def neptune_snapshot_exists(client: TestClient):
    """Create a cluster (snapshots are not standalone in lws)."""
    NeptuneTestClient(client).create_cluster()
