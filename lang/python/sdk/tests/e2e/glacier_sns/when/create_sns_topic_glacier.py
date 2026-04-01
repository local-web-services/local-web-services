"""When: a "sns" "topic" is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_TOPIC_NAME


@when('a "sns" "topic" is created')
def create_sns_topic_glacier(lws_session, world):
    try:
        resp = lws_session.client("sns").create_topic(Name=TEST_TOPIC_NAME)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
