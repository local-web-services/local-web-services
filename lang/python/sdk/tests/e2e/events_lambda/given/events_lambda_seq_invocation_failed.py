"""Given: the Lambda invocation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed")
def events_lambda_seq_invocation_failed():
    pytest.skip("Cannot trigger internal EventBridge->Lambda routing in lws")
