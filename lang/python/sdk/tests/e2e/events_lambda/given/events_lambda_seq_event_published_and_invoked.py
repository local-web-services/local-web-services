"""
Given: an event has been published to the bus and has triggered an asynchronous Lambda invocation
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an event has been published to the bus and has triggered an asynchronous Lambda invocation")
def events_lambda_seq_event_published_and_invoked():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
