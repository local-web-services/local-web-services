"""Then: the execution is "SUCCEEDED" and the "SUCCEEDED" event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "SUCCEEDED" and the "SUCCEEDED" event is "DELIVERED"')
def execution_succeeded_and_event_delivered(world):
    pytest.skip("Cannot observe EventBridge event delivery for execution completion in lws")
