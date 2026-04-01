"""Given: the "elasticsearch" "domain" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given('the "elasticsearch" "domain" existed')
def domain_exists(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
