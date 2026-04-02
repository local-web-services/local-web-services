"""Given: the "sns" "delivery" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sns" "delivery" did not exist')
def delivery_does_not_exist():
    """No-op: fresh state has no deliveries."""
