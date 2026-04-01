"""
Given: a running execution has succeeded but the "SUCCEEDED" event delivery has failed because
the bus is deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running execution has succeeded but the "SUCCEEDED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def running_execution_succeeded_event_failed_given():
    pytest.skip("Cannot pre-set a failed SUCCEEDED event delivery state for sequence setup")
