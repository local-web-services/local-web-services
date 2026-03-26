"""When: a pending subscription is confirmed"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a pending subscription is confirmed")
def confirm_subscription(lws_session, world):
    pytest.skip("Cannot confirm subscription without token in this context")
