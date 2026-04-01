"""Then: the "neptune" "cluster" will be "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" will be "STOPPED"')
def cluster_is_stopped_then():
    pytest.skip("Cannot observe internal Neptune cluster stopped state in lws")
