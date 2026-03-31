"""Given: the "glacier" "job" output is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" output is available')
def job_output_is_available_given():
    pytest.skip("Cannot create a job with output in this context")
