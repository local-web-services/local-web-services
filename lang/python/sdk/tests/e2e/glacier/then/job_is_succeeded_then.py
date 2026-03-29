"""Then: the job is Succeeded and its output is available"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the job is Succeeded and its output is available")
def job_is_succeeded_then():
    pytest.skip("Cannot observe Succeeded job state in lws")
