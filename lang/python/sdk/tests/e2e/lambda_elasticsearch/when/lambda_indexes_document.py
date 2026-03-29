"""When: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('the Lambda function indexes a document into the "AVAILABLE" domain and succeeds')
def lambda_indexes_document(lws_session, world):
    # Arrange
    invocation_id = world.get("invocation_id")
    # Act
    if invocation_id is None:
        world["error"] = RuntimeError("No invocation is in progress")
        return
    try:
        resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
        processing = resp.get("DomainStatus", {}).get("Processing", False)
        if processing:
            world["error"] = RuntimeError('Domain is not "AVAILABLE"')
            return
    except ClientError:
        world["error"] = RuntimeError("Domain does not exist")
        return
    if lws_session.capacity("es").is_exhausted():
        world["error"] = RuntimeError("No document slot is available")
        return
    lws_session.inject_state("lambda", "invocation", invocation_id, "SUCCESS")
