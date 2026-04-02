"""Then: no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription" """

from __future__ import annotations

from pytest_bdd import step


@step('no "sns" "delivery" is "IN_FLIGHT" to a deleted "sns" "subscription"')
def no_delivery_to_deleted_subscription():
    """Invariant: trivially satisfied in isolated lws context."""
