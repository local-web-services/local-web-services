"""Given: the archive does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the archive does not exist")
def archive_does_not_exist(world):
    world["archive_id"] = "nonexistent-archive-id"
