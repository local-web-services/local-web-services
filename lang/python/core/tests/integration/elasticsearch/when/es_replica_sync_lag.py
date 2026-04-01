"""When: a replica sync lag event occurs on an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('a replica sync lag event occurs on an active "elasticsearch" "domain"')
def es_replica_sync_lag(client: TestClient, world: dict):
    pytest.skip("Replica sync lag simulation cannot be triggered in stateless integration tests.")
