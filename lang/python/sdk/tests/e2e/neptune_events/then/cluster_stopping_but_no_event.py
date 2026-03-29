"""Then: the cluster is "STOPPING" but no event is delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "STOPPING" but no event is delivered')
def cluster_stopping_but_no_event():
    pytest.skip("Cannot observe internal Neptune cluster stopping state in lws")
