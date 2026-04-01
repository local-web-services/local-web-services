"""Given: the "elasticsearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient


@given('the "opensearch" "domain" existed')
@given('the "elasticsearch" "domain" existed')
def domain_exists(client: TestClient):
    OpensearchTestClient(client).create_domain()
