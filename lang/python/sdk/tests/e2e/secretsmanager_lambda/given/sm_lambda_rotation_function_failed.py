"""Given: the Lambda rotation function has failed and the rotation has been aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda rotation function has failed and the rotation has been aborted")
def sm_lambda_rotation_function_failed():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
