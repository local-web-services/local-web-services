"""Given: a domain configuration update has been requested"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given("a domain configuration update has been requested")
def opensearch_domain_configuration_update_requested_seq(lws_session):
    OpensearchTestClient(lws_session).create_domain()
