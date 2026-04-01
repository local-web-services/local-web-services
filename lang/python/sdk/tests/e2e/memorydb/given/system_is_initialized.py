"""Given: the system is initialized"""

from __future__ import annotations

from pytest_bdd import given


@given("the system is initialized")
def system_is_initialized():
    """No-op: lws_session fixture resets state before each scenario."""
