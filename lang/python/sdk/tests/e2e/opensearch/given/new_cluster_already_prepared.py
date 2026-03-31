"""Given: the new "opensearch" "cluster" has already been prepared"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the new "opensearch" "cluster" has already been prepared')
def new_cluster_already_prepared():
    pytest.skip("Cannot configure blue-green deployment state in lws")
