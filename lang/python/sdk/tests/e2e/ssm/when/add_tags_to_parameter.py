"""When: tags are added to a parameter"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, TEST_TAG_KEY, TEST_TAG_VALUE


@when("tags are added to a parameter")
def add_tags_to_parameter(lws_session, world):
    try:
        resp = lws_session.client("ssm").add_tags_to_resource(
            ResourceType="Parameter",
            ResourceId=TEST_PARAM,
            Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}],
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
