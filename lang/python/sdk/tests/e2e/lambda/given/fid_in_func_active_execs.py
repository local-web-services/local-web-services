"""Given: fid in func_active_execs"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("fid in func_active_execs")
def fid_in_func_active_execs():
    pytest.skip("Cannot observe Lambda active execution state in lws")
