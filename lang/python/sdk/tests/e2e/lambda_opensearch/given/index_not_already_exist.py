"""Given: the "opensearch" "index" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "index" did not already exist')
def index_not_already_exist():
    """No-op: fresh state has no indices."""
