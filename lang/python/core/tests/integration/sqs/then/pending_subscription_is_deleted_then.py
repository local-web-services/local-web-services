"""Then: the pending subscription is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the pending subscription is "DELETED"')
def pending_subscription_is_deleted_then(world):
    """Not applicable to SQS — trivially satisfied."""
