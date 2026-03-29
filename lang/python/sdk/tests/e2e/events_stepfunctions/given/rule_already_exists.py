"""Given: the rule already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import EventsStepfunctionsTestClient
from ..constants import _sm_arn


@given("the rule already exists")
def rule_already_exists(lws_session, world):
    world["state_machine_arn"] = _sm_arn()
    EventsStepfunctionsTestClient(lws_session).create_rule_targeting_sfn()
