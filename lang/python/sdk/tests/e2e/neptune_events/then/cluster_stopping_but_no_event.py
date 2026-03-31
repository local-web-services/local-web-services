"""Then: the "neptune" "cluster" will be "STOPPING" but no event will be delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" will be "STOPPING" but no event will be delivered')
def cluster_stopping_but_no_event():
    pytest.skip("Cannot observe internal Neptune cluster stopping state in lws")
