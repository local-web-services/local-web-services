"""Given: the "glacier" "job" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" existed')
def job_exists():
    pytest.skip("Cannot create a job directly in this context; job creation is via initiation")
