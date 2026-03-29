"""Then: the execution is "RUNNING" and the "STARTED" event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "RUNNING" and the "STARTED" event is "DELIVERED"')
def execution_running_and_started_event_delivered(world):
    pytest.skip("Cannot observe EventBridge event delivery for execution start in lws")
