"""Then: the cluster is in "STARTING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is in "STARTING" state')
def cluster_is_starting_then():
    pytest.skip("Cannot observe internal cluster STARTING state in lws")
