"""When: the "rds" "instance" stops and delivers the state change event to the EventBridge bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "rds" "instance" stops and delivers the state change event to the EventBridge bus')
def db_stop_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal RDS DB instance stop event routing in lws")
