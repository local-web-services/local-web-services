"""Given: a JSONata dict-output "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import JSONATA_DICT_OUTPUT_SM


@given('a JSONata dict-output "step functions" "state machine" is created')
def jsonata_dict_output_sm_created(lws_session, world):
    world["state_machine_name"] = JSONATA_DICT_OUTPUT_SM
    StepfunctionsTestClient(lws_session).create_jsonata_dict_output_sm()
