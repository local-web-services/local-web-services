"""When: a job fails"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a job fails")
def job_fails(lws_session, world):
    pytest.skip("Cannot trigger internal job failure in lws")
