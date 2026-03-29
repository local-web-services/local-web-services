"""Then: the job is Failed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the job is Failed")
def job_is_failed_then():
    pytest.skip("Cannot observe Failed job state in lws")
