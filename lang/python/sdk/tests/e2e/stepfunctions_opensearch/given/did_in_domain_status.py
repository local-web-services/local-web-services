"""Given: did in domain_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given("did in domain_status")
def did_in_domain_status(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_domain()
