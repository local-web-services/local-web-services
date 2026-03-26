"""When: a user action occurs but event delivery fails because the bus has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a user action occurs but event delivery fails because the bus has been deleted")
def user_action_event_delivery_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Cognito event delivery failure in lws")
