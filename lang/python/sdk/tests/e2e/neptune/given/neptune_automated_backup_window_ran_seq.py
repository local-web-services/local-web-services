"""Given: an automated backup window runs on an available "neptune" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an automated backup window runs on an available "neptune" "cluster"')
def neptune_automated_backup_window_ran_seq():
    pytest.skip("Cannot trigger internal Neptune automated backup window in lws")
