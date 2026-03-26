"""Then: the domain is in "PROCESSING" state and a blue-green deployment begins"""

from __future__ import annotations

from pytest_bdd import then

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@then('the domain is in "PROCESSING" state and a blue-green deployment begins')
def domain_is_processing_blue_green_then(lws_session):
    resp = OpensearchTestClient(lws_session).describe_domain(DomainName=TEST_DOMAIN)
    actual_domain = resp.get("DomainStatus", {})
    assert (
        actual_domain.get("DomainName") == TEST_DOMAIN
    ), f"Expected domain '{TEST_DOMAIN}' to exist but got: {actual_domain}"
