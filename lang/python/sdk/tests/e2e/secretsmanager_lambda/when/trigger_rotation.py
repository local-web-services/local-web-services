"""When: a rotation is triggered for the "secretsmanager" "secret" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a rotation is triggered for the "secretsmanager" "secret"')
def trigger_rotation(world):
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
