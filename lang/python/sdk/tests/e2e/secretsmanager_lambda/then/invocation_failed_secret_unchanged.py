"""Then: the invocation will be "FAILED" and the "secretsmanager" "secret" remains "ACTIVE" with the old version"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the invocation will be "FAILED" and the "secretsmanager" "secret" remains "ACTIVE" with the old version'
)
def invocation_failed_secret_unchanged():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
