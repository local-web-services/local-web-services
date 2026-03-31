"""Given: the "opensearch" "domain" was "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@given('the "opensearch" "domain" was "DELETING"')
def domain_is_deleting_given(lws_session):
    OpensearchTestClient(lws_session).create_domain()
    lws_session.lifecycle("opensearch").delete_dwell_ms(5000).apply()
    lws_session.client("opensearch").delete_domain(DomainName=TEST_DOMAIN)
