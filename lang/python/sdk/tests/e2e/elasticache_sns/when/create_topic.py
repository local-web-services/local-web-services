"""When: an "SNS" topic is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ElasticacheSnsTestClient
from ..constants import TEST_TOPIC


@when('an "SNS" topic is created')
def create_topic(lws_session, world):
    try:
        resp = ElasticacheSnsTestClient(lws_session)._sns.create_topic(Name=TEST_TOPIC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
