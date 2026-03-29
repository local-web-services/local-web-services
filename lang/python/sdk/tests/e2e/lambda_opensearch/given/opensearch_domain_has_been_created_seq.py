"""Given: an OpenSearch domain has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient


@given("an OpenSearch domain has been created")
def opensearch_domain_has_been_created_seq(lws_session):
    LambdaOpensearchTestClient(lws_session).create_domain()
