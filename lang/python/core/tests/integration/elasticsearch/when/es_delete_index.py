"""When: an index is deleted from an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when("an index is deleted from an active domain")
def es_delete_index(client: TestClient, world: dict):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
