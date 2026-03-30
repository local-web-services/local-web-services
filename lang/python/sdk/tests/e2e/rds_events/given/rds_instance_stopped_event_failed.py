"""
Given: the "RDS" instance has stopped but the state change event delivery has failed because the
bus is deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'the "RDS" instance has stopped but the state change event delivery has failed because'
    " the bus is deleted"
)
def rds_instance_stopped_event_failed():
    pytest.skip("Cannot trigger internal RDS event delivery failure in lws")
