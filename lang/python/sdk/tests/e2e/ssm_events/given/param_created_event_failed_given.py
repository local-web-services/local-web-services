"""
Given: a parameter has been created but the "CREATED" event delivery has failed because the bus
is deleted
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a parameter has been created but the "CREATED" event delivery has failed because the bus is deleted'  # noqa: E501
)
def param_created_event_failed_given():
    pytest.skip("Cannot pre-set failed event delivery state for sequence setup")
