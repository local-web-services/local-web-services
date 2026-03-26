"""When: a tag is removed from a function"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_TAG_KEY, _func_arn


@when("a tag is removed from a function")
def untag_function(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).untag_resource(
            Resource=_func_arn(), TagKeys=[TEST_TAG_KEY]
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
