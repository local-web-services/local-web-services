"""Given: a job has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a job has completed successfully")
def glacier_seq_job_completed():
    pytest.skip("Cannot trigger internal job completion in lws")
