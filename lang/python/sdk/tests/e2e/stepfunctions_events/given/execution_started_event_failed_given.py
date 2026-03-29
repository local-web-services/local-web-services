"""
Given: an execution has started but the "STARTED" event delivery has failed because the bus is
deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an execution has started but the "STARTED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def execution_started_event_failed_given():
    pytest.skip("Cannot pre-set a failed STARTED event delivery state for sequence setup")
