"""When: an active function is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import LambdaTestClient
from ..constants import TEST_FUNC


@when("an active function is deleted")
def delete_function(lws_session, world):
    try:
        resp = LambdaTestClient(lws_session).delete_function(FunctionName=TEST_FUNC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
