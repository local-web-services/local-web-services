"""Given: tags are removed from a "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_TAG_KEY, TEST_TAG_VALUE


@given('tags are removed from a "ssm" "parameter"')
def ssm_tags_have_been_removed_from_a_parameter(lws_session):
    SsmTestClient(lws_session).create_param()
    try:
        SsmTestClient(lws_session).add_tags_to_resource(
            ResourceType="Parameter",
            ResourceId=TEST_PARAM,
            Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}],
        )
    except Exception:
        pass
    try:
        SsmTestClient(lws_session).remove_tags_from_resource(
            ResourceType="Parameter", ResourceId=TEST_PARAM, TagKeys=[TEST_TAG_KEY]
        )
    except Exception:
        pass
