"""Given: an automated backup has run on an available instance"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an automated backup has run on an available instance")
def an_automated_backup_has_run():
    pytest.skip("Cannot trigger internal RDS automated backup in lws")
