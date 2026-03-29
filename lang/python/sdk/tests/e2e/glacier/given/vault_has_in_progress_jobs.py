"""Given: the vault has in-progress jobs"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the vault has in-progress jobs")
def vault_has_in_progress_jobs():
    pytest.skip("Cannot create in-progress jobs in this context")
