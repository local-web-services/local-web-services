"""Given: the "elasticsearch" "domain" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ElasticsearchTestClient


@given('the "elasticsearch" "domain" already existed')
def domain_already_exists(lws_session):
    ElasticsearchTestClient(lws_session).create_domain()
