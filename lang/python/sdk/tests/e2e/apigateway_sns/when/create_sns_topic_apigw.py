"""When: an "SNS" topic is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewaySnsTestClient
from ..constants import TEST_TOPIC_NAME


@when('an "SNS" topic is created')
def create_sns_topic_apigw(lws_session, world):
    try:
        resp = ApigatewaySnsTestClient(lws_session)._sns.create_topic(Name=TEST_TOPIC_NAME)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
