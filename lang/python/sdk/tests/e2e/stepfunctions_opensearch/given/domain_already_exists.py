"""Given: the "opensearch" "domain" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsOpensearchTestClient


@given('the "opensearch" "domain" already existed')
def domain_already_exists(lws_session):
    StepfunctionsOpensearchTestClient(lws_session).create_domain()
