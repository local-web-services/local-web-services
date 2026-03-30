"""Given: a running execution has read an "ACTIVE" secret and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has read an "ACTIVE" secret and the task succeeded')
def running_execution_read_secret_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution SecretsManager task state for sequence setup")
