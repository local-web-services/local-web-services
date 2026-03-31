"""Given: the "opensearch" "domain" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@given('the "opensearch" "domain" was "CREATING"')
def domain_is_creating_given(lws_session):
    try:
        OpensearchTestClient(lws_session).delete_domain(DomainName=TEST_DOMAIN)
    except Exception:
        pass
    lws_session.lifecycle("opensearch").create_dwell_ms(5000).apply()
    OpensearchTestClient(lws_session).create_domain()
