"""When: rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'rotation is configured on the "secretsmanager" "secret" linking it to the "lambda" "rotation function"'
)
def configure_rotation(world):
    pytest.skip("Cannot configure secret rotation Lambda trigger in lws")
