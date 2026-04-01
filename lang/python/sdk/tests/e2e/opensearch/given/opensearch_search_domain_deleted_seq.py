"""Given: the "opensearch" "domain" is being deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@given('the "opensearch" "domain" is being deleted')
def opensearch_search_domain_deleted_seq(lws_session):
    try:
        OpensearchTestClient(lws_session).create_domain()
    except Exception:
        pass
    OpensearchTestClient(lws_session).delete_domain(DomainName=TEST_DOMAIN)
