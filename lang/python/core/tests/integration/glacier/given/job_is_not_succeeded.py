"""Given: the "glacier" "job" was not "Succeeded" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" was not "Succeeded"')
def job_is_not_succeeded(world):
    pytest.skip(
        "Lifecycle-dependent state (non-Succeeded job) is not supported "
        "in stateless integration tests."
    )
