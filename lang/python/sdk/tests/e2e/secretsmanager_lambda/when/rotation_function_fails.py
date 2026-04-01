"""When: the "lambda" "rotation function" fails and the rotation is aborted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "rotation function" fails and the rotation is aborted')
def rotation_function_fails(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
