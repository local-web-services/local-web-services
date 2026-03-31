"""Then: the "glacier" "JOB" will be "Failed" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "JOB" will be "Failed"')
def job_is_failed_then():
    pytest.skip("Cannot observe Failed job state in lws")
