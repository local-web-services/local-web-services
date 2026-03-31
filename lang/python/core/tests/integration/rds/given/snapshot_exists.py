"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import RdsTestClient


@given('the "rds" "snapshot" existed')
@given('the "documentdb" "snapshot" existed')
def snapshot_exists(client: TestClient):
    """Create an instance (snapshots are not standalone in lws)."""
    RdsTestClient(client).create_instance()
