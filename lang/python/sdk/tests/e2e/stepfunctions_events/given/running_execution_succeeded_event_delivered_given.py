"""
Given: a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to
the bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running execution has succeeded and Step Functions has delivered a "SUCCEEDED" event to the bus'  # noqa: E501
)
def running_execution_succeeded_event_delivered_given():
    pytest.skip("Cannot pre-set a delivered SUCCEEDED event state for sequence setup")
