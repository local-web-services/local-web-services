"""
Given: an execution has started and Step Functions has delivered a "STARTED" event to the
EventBridge bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'an execution has started and Step Functions has delivered a "STARTED" event to the EventBridge bus'  # noqa: E501
)
def execution_started_event_delivered_given():
    pytest.skip("Cannot pre-set a delivered STARTED event state for sequence setup")
