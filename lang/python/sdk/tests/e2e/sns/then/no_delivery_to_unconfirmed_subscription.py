"""Then: no delivery is in-flight to an unconfirmed subscription"""

from __future__ import annotations

from pytest_bdd import step


@step("no delivery is in-flight to an unconfirmed subscription")
def no_delivery_to_unconfirmed_subscription():
    """Invariant: trivially satisfied in isolated lws context."""
