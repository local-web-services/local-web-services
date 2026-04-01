"""When: tags are removed from a "ssm" "parameter" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..constants import TEST_PARAM, TEST_TAG_KEY


@when('tags are removed from a "ssm" "parameter"')
def remove_tags_from_parameter(lws_session, world):
    try:
        tag_resp = lws_session.client("ssm").list_tags_for_resource(
            ResourceType="Parameter", ResourceId=TEST_PARAM
        )
        existing_keys = {t["Key"] for t in tag_resp.get("TagList", [])}
        if TEST_TAG_KEY not in existing_keys:
            raise ClientError(
                {
                    "Error": {
                        "Code": "InvalidResourceId",
                        "Message": f"Tag {TEST_TAG_KEY} is not associated with {TEST_PARAM}",
                    }
                },
                "RemoveTagsFromResource",
            )
        resp = lws_session.client("ssm").remove_tags_from_resource(
            ResourceType="Parameter", ResourceId=TEST_PARAM, TagKeys=[TEST_TAG_KEY]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
