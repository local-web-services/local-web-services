"""Given: fid in fake_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("fid in fake_status")
def aws_fake_fid_in_fake_status():
    pytest.skip("AWS fake service is not yet available in LwsSession")
