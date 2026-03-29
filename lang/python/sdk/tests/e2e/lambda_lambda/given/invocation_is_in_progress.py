"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

import uuid

from botocore.exceptions import ClientError
from pytest_bdd import given

from ..client import LambdaLambdaTestClient
from ..constants import TEST_CALLER


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session, world):
    try:
        LambdaLambdaTestClient(lws_session).create_function(TEST_CALLER)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "ResourceConflictException":
            raise
    invocation_id = str(uuid.uuid4())
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    world["invocation_id"] = invocation_id
