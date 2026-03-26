"""Then: the domain is "ACTIVE" and ready for use"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ElasticsearchTestClient
from ..constants import TEST_DOMAIN


@then('the domain is "ACTIVE" and ready for use')
def domain_is_active_then(lws_session):
    resp = ElasticsearchTestClient(lws_session).describe_elasticsearch_domain(
        DomainName=TEST_DOMAIN
    )
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"
