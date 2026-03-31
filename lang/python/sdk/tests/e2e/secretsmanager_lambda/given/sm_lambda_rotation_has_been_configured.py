"""Given: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"'
)
def sm_lambda_rotation_has_been_configured():
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
