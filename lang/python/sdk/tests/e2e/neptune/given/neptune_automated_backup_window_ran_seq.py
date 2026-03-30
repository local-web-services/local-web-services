"""Given: an automated backup window has run on an available cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an automated backup window has run on an available cluster")
def neptune_automated_backup_window_ran_seq():
    pytest.skip("Cannot trigger internal Neptune automated backup window in lws")
