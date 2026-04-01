"""When: shards are rebalanced across nodes in an active "opensearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('shards are rebalanced across nodes in an active "opensearch" "domain"')
def rebalance_shards(client: TestClient, world: dict):
    pytest.skip("UpdateDomainConfig is not yet implemented in lws.")
