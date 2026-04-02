"""When: a "lambda" task is configured on the "step functions" "state machine" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" task is configured on the "step functions" "state machine"')
def configure_lambda_task(lws_session, world):
    pytest.skip("Cannot trigger Lambda task configuration on state machine in lws")
