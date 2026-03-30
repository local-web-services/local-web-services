"""Given: a running execution has failed to read the secret because it is pending deletion"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed to read the secret because it is pending deletion")
def running_execution_failed_secret_pending_given():
    pytest.skip("Cannot pre-set a failed execution SecretsManager task state for sequence setup")
