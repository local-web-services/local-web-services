"""Then: the "cognito" "user pool" will send user events to the bus"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "cognito" "user pool" will send user events to the bus')
def pool_will_send_events_to_bus():
    pytest.skip("Cannot observe internal EventBridge publishing configuration in lws")
