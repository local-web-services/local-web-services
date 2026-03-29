"""Then: the domain is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_DOMAIN


@then('the domain is "AVAILABLE"')
def domain_is_available_then(lws_session):
    resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
    actual_name = resp["DomainStatus"].get("DomainName", "")
    expected_name = TEST_DOMAIN
    assert (
        actual_name == expected_name
    ), f"Expected domain name '{expected_name}' but got '{actual_name}'"
