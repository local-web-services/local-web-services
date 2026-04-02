"""Given: the "eventbridge" "bus" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient
from ..constants import _sm_arn


@given('the "eventbridge" "rule" already existed')
def rule_already_exists(lws_session, world):
    world["state_machine_arn"] = _sm_arn()
    EventsStepfunctionsTestClient(lws_session).create_rule_targeting_sfn()
