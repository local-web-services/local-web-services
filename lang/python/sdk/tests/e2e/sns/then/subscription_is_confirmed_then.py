"""Then: the "sns" "subscription" will be "CONFIRMED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "subscription" will be "CONFIRMED"')
def subscription_is_confirmed_then(world):
    pytest.skip("Cannot verify CONFIRMED state without confirmation flow")
