"""Given: a rotation has been triggered for the secret"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a rotation has been triggered for the secret")
def sm_lambda_a_rotation_has_been_triggered():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
