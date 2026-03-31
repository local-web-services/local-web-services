"""When: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds'
)
def execution_calls_vault_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls Glacier in lws")
