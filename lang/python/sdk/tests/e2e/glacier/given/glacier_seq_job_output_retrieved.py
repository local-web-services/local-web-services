"""Given: the output of a succeeded job has been retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the output of a succeeded job has been retrieved")
def glacier_seq_job_output_retrieved():
    pytest.skip("Cannot retrieve job output without a succeeded job in lws")
