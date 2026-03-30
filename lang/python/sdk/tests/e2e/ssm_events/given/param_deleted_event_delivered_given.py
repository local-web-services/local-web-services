"""
Given: a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge
bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a parameter has been deleted and "SSM" has delivered a "DELETED" event to the EventBridge bus'
)
def param_deleted_event_delivered_given():
    pytest.skip("Cannot pre-set deleted-parameter-with-event state for sequence setup")
