"""Then: the invocation will be "SUCCESS" and the "secrets manager" "secret" will be "ACTIVE" with a new version"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the invocation will be "SUCCESS" and the "secrets manager" "secret" will be "ACTIVE" with a new version'
)
def invocation_success_secret_rotated():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
