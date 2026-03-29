"""
Given: the Lambda rotation function has succeeded and the secret has been rotated to a new
version
"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    "the Lambda rotation function has succeeded and the secret has been rotated to a new version"
)
def sm_lambda_rotation_function_succeeded():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
