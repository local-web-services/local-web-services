"""Given: the "glacier" "vault" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "vault" was not "ACTIVE"')
def vault_is_not_active_given():
    pytest.skip("Cannot control vault activity state in lws")
