"""Given: the job is Succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the job is Succeeded")
def job_is_succeeded_given():
    pytest.skip("Cannot observe Succeeded job state in lws")
