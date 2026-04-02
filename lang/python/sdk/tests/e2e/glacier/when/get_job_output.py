"""When: the output of a succeeded "glacier" "job" is retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the output of a succeeded "glacier" "job" is retrieved')
def get_job_output(lws_session, world):
    pytest.skip("Cannot retrieve job output without a succeeded job in lws")
