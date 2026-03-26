"""Given: the Lambda invocation has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has completed successfully")
def events_lambda_seq_invocation_completed():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
