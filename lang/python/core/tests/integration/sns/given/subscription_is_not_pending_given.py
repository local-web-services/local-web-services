"""Given: the subscription is not "PENDING_CONFIRMATION" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the subscription is not "PENDING_CONFIRMATION"')
def subscription_is_not_pending_given():
    pytest.skip(
        "Cannot set subscription to non-PENDING_CONFIRMATION state without confirmation flow"
    )
