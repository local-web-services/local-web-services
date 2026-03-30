"""Given: the tag is associated with the parameter"""

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_TAG_KEY, TEST_TAG_VALUE


@given("the tag is associated with the parameter")
def tag_associated_with_parameter(lws_session):
    SsmTestClient(lws_session).add_tags_to_resource(
        ResourceType="Parameter",
        ResourceId=TEST_PARAM,
        Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}],
    )
