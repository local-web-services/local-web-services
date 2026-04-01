"""Given: a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running "step functions" "execution" reads an "ACTIVE" secret and the task succeeds')
def running_execution_read_secret_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution SecretsManager task state for sequence setup")
