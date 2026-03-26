"""When: tags are removed from a domain"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@when("tags are removed from a domain")
def remove_tags(lws_session, world):
    try:
        resp = OpensearchTestClient(lws_session).describe_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = OpensearchTestClient(lws_session).remove_tags(
            ARN=actual_arn, TagKeys=["e2e-test-key-1"]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
