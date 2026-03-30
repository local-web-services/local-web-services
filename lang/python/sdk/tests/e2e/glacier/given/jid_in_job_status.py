"""Given: jid in job_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("jid in job_status")
def jid_in_job_status():
    pytest.skip("Cannot create a job as a FizzBee precondition in this context")
