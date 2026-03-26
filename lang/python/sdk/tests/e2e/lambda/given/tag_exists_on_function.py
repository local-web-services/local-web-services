"""Given: the tag exists on the function"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaTestClient
from ..constants import TEST_TAG_KEY, TEST_TAG_VALUE, _func_arn


@given("the tag exists on the function")
def tag_exists_on_function(lws_session):
    LambdaTestClient(lws_session).tag_resource(
        Resource=_func_arn(), Tags={TEST_TAG_KEY: TEST_TAG_VALUE}
    )
