"""When: tags are added to an "elasticsearch" "domain" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_DOMAIN


@when('tags are added to an "elasticsearch" "domain"')
def add_tags(lws_session, world):
    try:
        resp = lws_session.client("es").describe_elasticsearch_domain(DomainName=TEST_DOMAIN)
        actual_arn = resp["DomainStatus"]["ARN"]
        world["result"] = lws_session.client("es").add_tags(
            ARN=actual_arn, TagList=[{"Key": "e2e-test-key-1", "Value": "e2e-test-value-1"}]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
