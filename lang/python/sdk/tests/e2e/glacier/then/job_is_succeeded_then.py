"""Then: the "glacier" "JOB" will be "Succeeded" and its output will be available"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "JOB" will be "Succeeded" and its output will be available')
def job_is_succeeded_then():
    pytest.skip("Cannot observe Succeeded job state in lws")
