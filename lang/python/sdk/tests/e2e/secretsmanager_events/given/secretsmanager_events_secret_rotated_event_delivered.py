"""
Given: a secret rotation has occurred and Secrets Manager has delivered a "ROTATED" event to the
bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a secret rotation has occurred and Secrets Manager has delivered a "ROTATED" event to the bus'
)
def secretsmanager_events_secret_rotated_event_delivered():
    pytest.skip("Cannot trigger secret rotation in lws")
