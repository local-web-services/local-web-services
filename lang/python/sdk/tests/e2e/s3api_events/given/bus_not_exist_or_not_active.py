"""Given: the "eventbridge" "bus" did not exist or was "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "bus" did not exist or was "ACTIVE"')
def bus_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate EventBridge bus existence when configuring bucket notifications"
    )
