"""Given: the system is initialized"""

from __future__ import annotations

from pytest_bdd import given


@given("the system is initialized")
def system_initialized():
    """No-op: the client fixture has already set up the in-process app."""
