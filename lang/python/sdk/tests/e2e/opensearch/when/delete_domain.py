"""When: a search domain is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import OpensearchTestClient
from ..constants import TEST_DOMAIN


@when("a search domain is deleted")
def delete_domain(lws_session, world):
    try:
        world["result"] = OpensearchTestClient(lws_session).delete_domain(DomainName=TEST_DOMAIN)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
