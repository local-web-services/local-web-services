"""When: an index is created in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an index is created in an active domain")
def es_create_index(client: TestClient, world: dict):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
