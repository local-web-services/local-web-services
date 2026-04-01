"""Given: the local "opensearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given('the local "opensearch" "domain" existed')
def local_domain_exists(lws_session):
    OpensearchTestClient(lws_session).create_domain()
