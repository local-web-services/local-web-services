"""Given: the queue does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the queue does not exist")
def queue_does_not_exist(world):
    world["result"] = None
    world["error"] = None
