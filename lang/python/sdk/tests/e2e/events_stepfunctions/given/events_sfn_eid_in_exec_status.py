"""Given: eid in exec_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("eid in exec_status")
def events_sfn_eid_in_exec_status():
    pytest.skip("Cannot trigger internal Step Functions execution in lws")
