"""Then: the "step functions" "execution" will be "SUCCEEDED" and the "SUCCEEDED" event will be "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "step functions" "execution" will be "SUCCEEDED" and the "SUCCEEDED" event will be "DELIVERED"'
)
def execution_succeeded_and_event_delivered(world):
    pytest.skip("Cannot observe EventBridge event delivery for execution completion in lws")
