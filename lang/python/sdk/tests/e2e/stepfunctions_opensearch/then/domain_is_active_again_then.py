"""Then: the domain is "ACTIVE" again"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_DOMAIN


@then('the domain is "ACTIVE" again')
def domain_is_active_again_then(lws_session):
    resp = lws_session.client("opensearch").describe_domain(DomainName=TEST_DOMAIN)
    expected_processing = False
    actual_processing = resp["DomainStatus"]["Processing"]
    assert (
        actual_processing == expected_processing
    ), f"Expected domain Processing='{expected_processing}' but got '{actual_processing}'"
