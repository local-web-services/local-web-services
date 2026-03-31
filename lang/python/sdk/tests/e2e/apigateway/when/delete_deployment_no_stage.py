"""When: a "api gateway" "deployment" is deleted when no stage references it"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "api gateway" "deployment" is deleted when no stage references it')
def delete_deployment_no_stage(lws_session, world):
    pytest.skip("lws does not implement the DeleteDeployment route")
