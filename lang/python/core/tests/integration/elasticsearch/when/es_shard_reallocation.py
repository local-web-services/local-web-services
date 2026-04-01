"""When: shards are reallocated across nodes in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('shards are reallocated across nodes in an active "elasticsearch" "domain"')
def es_shard_reallocation(client: TestClient, world: dict):
    pytest.skip("Shard reallocation simulation cannot be triggered in stateless integration tests.")
