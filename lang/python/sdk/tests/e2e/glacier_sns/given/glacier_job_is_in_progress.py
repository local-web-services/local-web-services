"""Given: a job is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a job is "IN_PROGRESS"')
def glacier_job_is_in_progress():
    pytest.skip("Cannot trigger internal Glacier job in lws")
