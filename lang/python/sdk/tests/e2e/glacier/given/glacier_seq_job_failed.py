"""Given: a job has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a job has failed")
def glacier_seq_job_failed():
    pytest.skip("Cannot trigger internal job failure in lws")
