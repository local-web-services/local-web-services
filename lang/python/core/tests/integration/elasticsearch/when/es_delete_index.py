"""When: an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient


@when('an "elasticsearch" "index" is deleted from an active "elasticsearch" "domain"')
def es_delete_index(client: TestClient, world: dict):
    pytest.skip("Index management is not available in the core Elasticsearch integration API.")
