"""When: an automated backup window runs on an available "neptune" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an automated backup window runs on an available "neptune" "cluster"')
def automated_backup_window(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune automated backup window in lws")
