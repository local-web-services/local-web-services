"""When: traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('traffic is swapped to the new "opensearch" "cluster" during a blue-green deployment')
def blue_green_swap_traffic(client: TestClient, world: dict):
    pytest.skip("Blue-green traffic swap cannot be triggered in stateless integration tests.")
