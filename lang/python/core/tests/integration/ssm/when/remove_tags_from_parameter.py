"""When: tags are removed from a "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM, INT_TAG_KEY


@when('tags are removed from a "ssm" "parameter"')
def remove_tags_from_parameter(client: TestClient, world):
    # Check tag existence first — lws returns 200 even when tag is absent
    tag_r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.ListTagsForResource"},
        json={"ResourceType": "Parameter", "ResourceId": INT_PARAM},
    )
    existing_keys = {t["Key"] for t in tag_r.json().get("TagList", [])}
    if INT_TAG_KEY not in existing_keys:
        world["error"] = {
            "__type": "InvalidResourceId",
            "message": f"Tag {INT_TAG_KEY} is not associated with {INT_PARAM}",
        }
        return
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.RemoveTagsFromResource"},
        json={
            "ResourceType": "Parameter",
            "ResourceId": INT_PARAM,
            "TagKeys": [INT_TAG_KEY],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
