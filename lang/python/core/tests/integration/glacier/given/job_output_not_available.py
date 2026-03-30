"""Given: the job output is not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job output is not available")
def job_output_not_available(world):
    pytest.skip(
        "Lifecycle-dependent state (job output unavailable) is not supported "
        "in stateless integration tests."
    )
