"""Then: the domain is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import StepfunctionsElasticsearchTestClient
from ..constants import TEST_DOMAIN


@then('the domain is "AVAILABLE"')
def domain_is_available_then(lws_session):
    resp = StepfunctionsElasticsearchTestClient(lws_session)._es.describe_elasticsearch_domain(
        DomainName=TEST_DOMAIN
    )
    expected_processing = False
    actual_processing = resp["DomainStatus"]["Processing"]
    assert (
        actual_processing == expected_processing
    ), f"Expected domain Processing='{expected_processing}' but got '{actual_processing}'"
