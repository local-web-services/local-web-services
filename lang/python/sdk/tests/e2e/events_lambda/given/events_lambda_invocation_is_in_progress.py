"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

import uuid

from pytest_bdd import given

from ..client import EventsLambdaTestClient
from ..constants import TEST_FUNC


@given('an invocation is "IN_PROGRESS"')
def events_lambda_invocation_is_in_progress(lws_session, world):
    # Arrange
    func_name = world.get("function_name", TEST_FUNC)
    EventsLambdaTestClient(lws_session).create_function(func_name)
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
