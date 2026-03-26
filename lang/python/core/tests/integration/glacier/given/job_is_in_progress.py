"""Given: the job is InProgress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job is InProgress")
def job_is_in_progress(world):
    pytest.skip(
        "Lifecycle-dependent state (InProgress job) is not supported "
        "in stateless integration tests — jobs complete synchronously."
    )
