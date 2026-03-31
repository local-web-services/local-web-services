"""Given: the new "opensearch" "cluster" has not been prepared yet"""

from __future__ import annotations

from pytest_bdd import given


@given('the new "opensearch" "cluster" has not been prepared yet')
def new_cluster_not_prepared_yet():
    """No-op: no blue-green deployment by default."""
