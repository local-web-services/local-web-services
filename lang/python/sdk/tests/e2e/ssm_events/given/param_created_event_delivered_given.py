"""
Given: a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge
bus
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a parameter has been created and "SSM" has delivered a "CREATED" event to the EventBridge bus'
)
def param_created_event_delivered_given():
    pytest.skip("Cannot pre-set delivered SSM event state for sequence setup")
