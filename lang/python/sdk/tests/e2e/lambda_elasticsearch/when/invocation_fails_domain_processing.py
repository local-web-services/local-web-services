"""When: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when(
    'the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update'
)
def invocation_fails_domain_processing(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
        processing = resp.get("DomainStatus", {}).get("Processing", False)
        if not processing:
            world["error"] = RuntimeError("Domain is not processing")
            return
    except ClientError:
        world["error"] = RuntimeError("Domain does not exist")
        return
    # Act
    lws_session.inject_state_unchecked("lambda", "invocation", invocation_id, "FAILED")
