"""Given: domain in domain_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient


@given("domain in domain_status")
def domain_in_domain_status(lws_session):
    OpensearchTestClient(lws_session).create_domain()
