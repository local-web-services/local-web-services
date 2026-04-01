"""Then: the "secrets manager" "secret" will be "ACTIVE" with a new version and the "ROTATED" event will be "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "secrets manager" "secret" will be "ACTIVE" with a new version and the "ROTATED" event will be "DELIVERED"'
)
def secret_active_with_new_version_and_rotated_event():
    pytest.skip("Cannot verify secret rotation in lws")
