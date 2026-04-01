"""Given: the "glacier" "vault" already existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "vault" already existed')
def vault_already_exists(world):
    pytest.skip(
        "CreateVault is idempotent in lws (no uniqueness enforcement); "
        "duplicate vault creation cannot be tested in stateless integration tests."
    )
