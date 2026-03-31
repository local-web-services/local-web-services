"""When: an "elasticsearch" "domain" is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('an "elasticsearch" "domain" is deleted')
def delete_elasticsearch_domain(lws_session, world):
    try:
        world["result"] = lws_session.client("es").delete_elasticsearch_domain(
            DomainName=TEST_DOMAIN
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
