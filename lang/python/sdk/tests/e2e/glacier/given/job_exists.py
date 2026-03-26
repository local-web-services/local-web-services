"""Given: the job exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job exists")
def job_exists():
    pytest.skip("Cannot create a job directly in this context; job creation is via initiation")
