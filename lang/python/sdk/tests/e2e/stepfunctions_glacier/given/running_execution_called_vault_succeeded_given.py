"""Given: a running execution has called a Glacier vault that "EXISTS" and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has called a Glacier vault that "EXISTS" and the task succeeded')
def running_execution_called_vault_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution Glacier task state for sequence setup")
