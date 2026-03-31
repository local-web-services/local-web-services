"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given('the "neptune" "snapshot" existed')
@given('the "documentdb" "snapshot" existed')
def neptune_snapshot_exists(client: TestClient):
    """Create a cluster (snapshots are not standalone in lws)."""
    NeptuneTestClient(client).create_cluster()
