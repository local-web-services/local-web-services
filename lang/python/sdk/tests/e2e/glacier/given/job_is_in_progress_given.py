"""Given: the job is InProgress"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job is InProgress")
def job_is_in_progress_given():
    pytest.skip("Cannot observe InProgress job state in lws")
