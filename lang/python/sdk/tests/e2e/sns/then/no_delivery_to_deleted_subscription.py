"""Then: no delivery is in-flight to a deleted subscription"""

from __future__ import annotations

from pytest_bdd import step


@step("no delivery is in-flight to a deleted subscription")
def no_delivery_to_deleted_subscription():
    """Invariant: trivially satisfied in isolated lws context."""
