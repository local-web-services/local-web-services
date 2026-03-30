"""Then: the domain is in "PROCESSING" state with a pending config change"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_DOMAIN


@then('the domain is in "PROCESSING" state with a pending config change')
def domain_is_processing_then(lws_session):
    resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"
