"""Then: the "secrets manager" "secret" will be "ROTATING" and Secrets Manager will invoke the "lambda" "rotation function" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "secrets manager" "secret" will be "ROTATING" and Secrets Manager will invoke the "lambda" "rotation function"'
)
def secret_is_rotating():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
