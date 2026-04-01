"""When: a "neptune" "cluster" start completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "neptune" "cluster" start completes')
def finish_start_cluster(client: TestClient, world: dict):
    pytest.skip("Cluster start completion cannot be triggered in stateless integration tests.")
