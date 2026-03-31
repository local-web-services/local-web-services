"""Given: the remote "opensearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient
from ..constants import INT_DOMAIN2


@given('the remote "opensearch" "domain" existed')
def remote_domain_exists(client: TestClient):
    OpensearchTestClient(client).create_domain(INT_DOMAIN2)
