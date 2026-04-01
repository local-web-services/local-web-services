"""Then: the "elasticsearch" "domain" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_DOMAIN


@then('the "elasticsearch" "domain" will be "AVAILABLE"')
def domain_is_available_then(lws_session):
    resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    expected_processing = False
    actual_processing = resp["DomainStatus"]["Processing"]
    assert (
        actual_processing == expected_processing
    ), f"Expected domain Processing='{expected_processing}' but got '{actual_processing}'"
