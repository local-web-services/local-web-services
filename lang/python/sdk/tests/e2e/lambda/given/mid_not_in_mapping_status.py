"""Given: mid not in mapping_status"""

from __future__ import annotations

from pytest_bdd import given


@given("mid not in mapping_status")
def mid_not_in_mapping_status():
    """No-op: fresh state has no event source mappings."""
