"""Given: the "sns" "subscription" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "subscription" existed')
def pending_subscription_exists():
    pytest.skip("Cannot create pending subscription token in this context")
