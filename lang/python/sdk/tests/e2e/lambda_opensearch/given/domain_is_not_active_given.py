"""Given: the domain is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaOpensearchTestClient
from ..constants import TEST_DOMAIN


@given('the domain is not "ACTIVE"')
def domain_is_not_active_given(lws_session, world):
    try:
        LambdaOpensearchTestClient(lws_session)._opensearch.delete_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
    LambdaOpensearchTestClient(lws_session).create_domain()
    world["result"] = None
    world["error"] = None
