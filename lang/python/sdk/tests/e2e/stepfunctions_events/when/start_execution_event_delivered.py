"""When: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus')
def start_execution_event_delivered(lws_session, world):
    pytest.skip("Cannot configure EventBridge event delivery for execution start in lws")
