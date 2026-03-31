"""Given: the "glacier" "job" was "Succeeded" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "glacier" "job" was "Succeeded"')
def job_is_succeeded_given():
    pytest.skip("Cannot observe Succeeded job state in lws")
