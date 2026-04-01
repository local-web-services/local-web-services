"""Given: eid in exec_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("eid in exec_status")
def apigw_sfn_eid_in_exec_status():
    pytest.skip("Cannot represent a completed Step Functions execution as sequence setup in lws")
