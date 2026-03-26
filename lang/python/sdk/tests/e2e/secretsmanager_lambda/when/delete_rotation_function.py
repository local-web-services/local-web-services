"""When: the rotation function is deleted"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import SecretsmanagerLambdaTestClient
from ..constants import TEST_FUNC


@when("the rotation function is deleted")
def delete_rotation_function(lws_session, world):
    try:
        resp = SecretsmanagerLambdaTestClient(lws_session)._lambda.delete_function(
            FunctionName=TEST_FUNC
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
