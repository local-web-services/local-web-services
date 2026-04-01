"""Given: the tag was associated with the "ssm" "parameter" """

from __future__ import annotations

from pytest_bdd import given

from ..client import SsmTestClient
from ..constants import TEST_PARAM, TEST_TAG_KEY, TEST_TAG_VALUE


@given('the tag was associated with the "ssm" "parameter"')
def tag_associated_with_parameter(lws_session):
    SsmTestClient(lws_session).add_tags_to_resource(
        ResourceType="Parameter",
        ResourceId=TEST_PARAM,
        Tags=[{"Key": TEST_TAG_KEY, "Value": TEST_TAG_VALUE}],
    )
