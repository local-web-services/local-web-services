"""Given: the "glacier" "job" was "InProgress" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" was "InProgress"')
def job_is_in_progress_given():
    pytest.skip("Cannot observe InProgress job state in lws")
