"""
When: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted'
)
def execution_succeeds_event_fails(world):
    pytest.skip("Cannot trigger internal execution completion in lws")
