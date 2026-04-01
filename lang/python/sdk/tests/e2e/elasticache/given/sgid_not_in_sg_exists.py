"""Given: sgid not in sg_exists"""

from __future__ import annotations

from pytest_bdd import given


@given("sgid not in sg_exists")
def sgid_not_in_sg_exists():
    """No-op: fresh state has no subnet groups."""
