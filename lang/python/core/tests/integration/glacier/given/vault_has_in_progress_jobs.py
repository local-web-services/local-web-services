"""Given: the "glacier" "vault" had in-progress jobs"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "vault" had in-progress jobs')
def vault_has_in_progress_jobs(world):
    pytest.skip(
        "Lifecycle-dependent state (vault with in-progress jobs) is not supported "
        "in stateless integration tests."
    )
