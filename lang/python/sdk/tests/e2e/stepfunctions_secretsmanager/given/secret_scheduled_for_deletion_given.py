"""Given: a "secretsmanager" "secret" is scheduled for deletion"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "secretsmanager" "secret" is scheduled for deletion')
def secret_scheduled_for_deletion_given():
    pytest.skip("Cannot pre-set a secret pending deletion state for sequence setup")
