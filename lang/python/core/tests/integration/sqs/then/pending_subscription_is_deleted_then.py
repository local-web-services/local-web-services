"""Then: the pending "sns" "subscription" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the pending "sns" "subscription" will be "DELETED"')
def pending_subscription_is_deleted_then(world):
    """Not applicable to SQS — trivially satisfied."""
