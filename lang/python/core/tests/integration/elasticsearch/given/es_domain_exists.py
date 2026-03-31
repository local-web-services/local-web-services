"""Given: the "elasticsearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import ElasticsearchTestClient


@given('the "elasticsearch" "domain" existed')
def es_domain_exists(client: TestClient):
    ElasticsearchTestClient(client).create_domain()
