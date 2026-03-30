"""Then: the invocation is "SUCCESS" and the secret is "ACTIVE" with a new version"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "SUCCESS" and the secret is "ACTIVE" with a new version')
def invocation_success_secret_rotated():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
