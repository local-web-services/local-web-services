"""Given: the "lambda" "rotation function" fails and the rotation is aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "rotation function" fails and the rotation is aborted')
def sm_lambda_rotation_function_failed():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
