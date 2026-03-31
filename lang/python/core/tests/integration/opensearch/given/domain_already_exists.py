"""Given: the "elasticsearch" "domain" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient


@given('the "opensearch" "domain" already existed')
@given('the "elasticsearch" "domain" already existed')
def domain_already_exists(client: TestClient):
    OpensearchTestClient(client).create_domain()
