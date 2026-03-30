"""Given: the domain already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient


@given("the domain already exists")
def es_domain_already_exists(client: TestClient):
    ElasticsearchTestClient(client).create_domain()
