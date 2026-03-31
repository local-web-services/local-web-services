"""Given: a pending "sns" "subscription" is confirmed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a pending "sns" "subscription" is confirmed')
def sns_a_pending_subscription_has_been_confirmed():
    pytest.skip("Cannot confirm subscription without token in this context")
