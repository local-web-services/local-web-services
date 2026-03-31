"""Given: no confirmed subscription existed for the topic"""

from __future__ import annotations

from pytest_bdd import given


@given("no confirmed subscription existed for the topic")
def no_confirmed_subscription_exists(world):
    world["result"] = None
    world["error"] = None
