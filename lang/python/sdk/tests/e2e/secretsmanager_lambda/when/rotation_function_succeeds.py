"""When: the Lambda rotation function succeeds and the secret is rotated to a new version"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda rotation function succeeds and the secret is rotated to a new version")
def rotation_function_succeeds(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
