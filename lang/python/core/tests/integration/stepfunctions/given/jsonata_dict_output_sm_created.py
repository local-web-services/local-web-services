"""Given: a JSONata dict-output "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import StepfunctionsTestClient
from ..constants import INT_JSONATA_DICT_OUTPUT_SM


@given('a JSONata dict-output "step functions" "state machine" is created')
def jsonata_dict_output_sm_created(client: TestClient, world):
    world["state_machine_name"] = INT_JSONATA_DICT_OUTPUT_SM
    StepfunctionsTestClient(client).create_jsonata_dict_output_sm(INT_JSONATA_DICT_OUTPUT_SM)
