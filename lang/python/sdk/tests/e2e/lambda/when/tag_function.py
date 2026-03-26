"""When: a tag is added to a function"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_TAG_KEY, TEST_TAG_VALUE, _func_arn


@when("a tag is added to a function")
def tag_function(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).tag_resource(
            Resource=_func_arn(), Tags={TEST_TAG_KEY: TEST_TAG_VALUE}
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
