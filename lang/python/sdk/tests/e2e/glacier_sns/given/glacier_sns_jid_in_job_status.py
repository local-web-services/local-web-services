"""Given: jid in job_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("jid in job_status")
def glacier_sns_jid_in_job_status():
    pytest.skip("Cannot trigger internal Glacier job in lws")
