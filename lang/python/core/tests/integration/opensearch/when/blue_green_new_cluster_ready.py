"""When: the new "opensearch" "cluster" for a blue-green deployment becomes ready"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('the new "opensearch" "cluster" for a blue-green deployment becomes ready')
def blue_green_new_cluster_ready(client: TestClient, world: dict):
    pytest.skip(
        "Blue-green new cluster readiness cannot be triggered in stateless integration tests."
    )
