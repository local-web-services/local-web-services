"""Then: the secret is "ROTATING" and Secrets Manager invokes the Lambda rotation function"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the secret is "ROTATING" and Secrets Manager invokes the Lambda rotation function')
def secret_is_rotating():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
