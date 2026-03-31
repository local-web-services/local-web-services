"""Given: a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" calls a "glacier" "vault" that "EXISTS" and the task succeeds'
)
def running_execution_called_vault_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Glacier task state for sequence setup")
