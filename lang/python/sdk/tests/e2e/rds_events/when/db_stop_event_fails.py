"""
When: the "RDS" instance stops but the state change event delivery fails because the bus is
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'the "rds" "instance" stops but the state change event delivery fails because the bus is deleted'
)  # noqa: E501
def db_stop_event_fails(lws_session, world):
    pytest.skip("Cannot trigger internal RDS event delivery failure in lws")
