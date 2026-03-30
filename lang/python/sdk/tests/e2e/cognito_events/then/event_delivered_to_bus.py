"""Then: the event is "DELIVERED" to the bus"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the event is "DELIVERED" to the bus')
def event_delivered_to_bus():
    pytest.skip("Cannot trigger internal Cognito event delivery in lws")
