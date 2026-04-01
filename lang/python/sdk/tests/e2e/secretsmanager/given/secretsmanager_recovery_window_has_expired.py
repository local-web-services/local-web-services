"""Given: the recovery window for a deleted "secrets manager" "secret" expires"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the recovery window for a deleted "secrets manager" "secret" expires')
def secretsmanager_recovery_window_has_expired():
    pytest.skip("Cannot simulate recovery window expiry in lws")
