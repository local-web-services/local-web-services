"""
Given: an EventBridge rule has been created to start a Step Functions execution on matching
events
"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient
from ..constants import _sm_arn


@given(
    "an EventBridge rule has been created to start a Step Functions execution on matching events"
)
def events_sfn_seq_rule_created(lws_session, world):
    world["state_machine_arn"] = _sm_arn()
    EventsStepfunctionsTestClient(lws_session).create_rule_targeting_sfn()
