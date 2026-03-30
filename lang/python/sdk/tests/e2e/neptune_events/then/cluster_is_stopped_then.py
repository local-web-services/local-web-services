"""Then: the cluster is "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "STOPPED"')
def cluster_is_stopped_then():
    pytest.skip("Cannot observe internal Neptune cluster stopped state in lws")
