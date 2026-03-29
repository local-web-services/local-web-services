"""Given: tags have been added to a parameter"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_TAG_KEY, TEST_TAG_VALUE


@given("tags have been added to a parameter")
def ssm_tags_have_been_added_to_a_parameter(lws_session):
    SsmTestClient(lws_session).create_param()
    try:
        SsmTestClient(lws_session).add_tags_to_resource(
            ResourceType="Parameter",
            ResourceId=TEST_PARAM,
            Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}],
        )
    except Exception:
        pass
