"""Given: sk in stage_exists"""

from __future__ import annotations

from pytest_bdd import given


@given("sk in stage_exists")
def sk_in_stage_exists():
    """No-op: stage existence is established during API setup in the test."""
