"""Then: the secret is "ACTIVE" with a new version and the "ROTATED" event is "DELIVERED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the secret is "ACTIVE" with a new version and the "ROTATED" event is "DELIVERED"')
def secret_active_with_new_version_and_rotated_event():
    pytest.skip("Cannot verify secret rotation in lws")
