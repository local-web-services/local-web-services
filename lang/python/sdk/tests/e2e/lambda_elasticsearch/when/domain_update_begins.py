"""When: a domain configuration update begins"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when("a domain configuration update begins")
def domain_update_begins(lws_session, world):
    try:
        resp = lws_session.client("es").update_elasticsearch_domain_config(DomainName=TEST_DOMAIN)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
