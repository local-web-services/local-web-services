"""Given: the parameter is already "DELETED" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsSsmTestClient
from ..constants import TEST_PARAM


@given('the parameter is already "DELETED"')
def param_is_already_deleted(lws_session, world):
    try:
        StepfunctionsSsmTestClient(lws_session).create_param()
    except Exception:
        pass
    lws_session.lifecycle("ssm").delete_dwell_ms(5000).apply()
    StepfunctionsSsmTestClient(lws_session)._ssm.delete_parameter(Name=TEST_PARAM)
    world["result"] = None
    world["error"] = None
