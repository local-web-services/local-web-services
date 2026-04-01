"""When: a "neptune" "cluster" stop completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" stop completes')
def finish_stop_cluster(client: TestClient, world: dict):
    pytest.skip("Cluster stop completion cannot be triggered in stateless integration tests.")
