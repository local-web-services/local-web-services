"""Then: the domain is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import LambdaOpensearchTestClient
from ..constants import TEST_DOMAIN


@then('the domain is "ACTIVE"')
def domain_is_active_then(lws_session):
    resp = LambdaOpensearchTestClient(lws_session)._opensearch.describe_domain(
        DomainName=TEST_DOMAIN
    )
    actual_name = resp["DomainStatus"].get("DomainName", "")
    expected_name = TEST_DOMAIN
    assert (
        actual_name == expected_name
    ), f"Expected domain name '{expected_name}' but got '{actual_name}'"
