"""Then: the "eventbridge" "event" will be "DELIVERED" to the "eventbridge" "bus" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "eventbridge" "event" will be "DELIVERED" to the "eventbridge" "bus"')
def event_delivered_to_bus():
    pytest.skip("Cannot trigger internal Cognito event delivery in lws")
