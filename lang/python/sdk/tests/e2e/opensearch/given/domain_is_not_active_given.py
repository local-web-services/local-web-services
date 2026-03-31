"""Given: the "opensearch" "domain" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@given('the "opensearch" "domain" was not "ACTIVE"')
def domain_is_not_active_given(lws_session):
    try:
        OpensearchTestClient(lws_session).delete_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
    OpensearchTestClient(lws_session).create_domain()
