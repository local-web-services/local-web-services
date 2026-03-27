"""Given: iid in inv_status"""

from __future__ import annotations

import uuid

from pytest_bdd import given

from ..client import LambdaSnsTestClient
from ..constants import TEST_FUNC


@given("iid in inv_status")
def iid_in_inv_status(lws_session, world):
    # Arrange
    func_name = world.get("function_name", TEST_FUNC)
    LambdaSnsTestClient(lws_session).create_function(func_name)
    invocation_id = str(uuid.uuid4())
    # Act
    lws_session.inject_state("lambda", "invocation", invocation_id, "IN_PROGRESS")
    # Assert
    world["invocation_id"] = invocation_id
