"""Given: the vault is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the vault is not "ACTIVE"')
def vault_is_not_active(world):
    pytest.skip(
        "Lifecycle-dependent state (non-ACTIVE vault) is not supported "
        "in stateless integration tests."
    )
