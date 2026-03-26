"""When: a Lambda task is configured on the state machine"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a Lambda task is configured on the state machine")
def configure_lambda_task(lws_session, world):
    pytest.skip("Cannot trigger Lambda task configuration on state machine in lws")
