"""Then: the "opensearch" "domain" will be in "CREATING" state"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_DOMAIN


@then('the "opensearch" "domain" will be in "CREATING" state')
def domain_is_creating_then(lws_session):
    resp = lws_session.client("opensearch").describe_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"
    actual_created = actual_domain.get("Created", False)
    expected_created = True
    assert actual_created == expected_created or not actual_domain.get(
        "Deleted", True
    ), f"Expected domain to be created but Created={actual_created}"
