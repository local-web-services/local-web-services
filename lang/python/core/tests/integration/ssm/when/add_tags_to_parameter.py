"""When: tags are added to a "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import _SSM_TARGET, INT_PARAM, INT_TAG_KEY, INT_TAG_VALUE


@when('tags are added to a "ssm" "parameter"')
def add_tags_to_parameter(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_SSM_TARGET}.AddTagsToResource"},
        json={
            "ResourceType": "Parameter",
            "ResourceId": INT_PARAM,
            "Tags": [{"Key": INT_TAG_KEY, "Value": INT_TAG_VALUE}],
        },
    )
    if r.status_code == 200:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
