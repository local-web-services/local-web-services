"""When: a "glacier" "job" completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "glacier" "job" completes successfully')
def job_completes_successfully(lws_session, world):
    pytest.skip("Cannot trigger internal job completion in lws")
