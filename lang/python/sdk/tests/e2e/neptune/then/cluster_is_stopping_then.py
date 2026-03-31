"""Then: the "neptune" "cluster" will be in "STOPPING" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "neptune" "cluster" will be in "STOPPING" state')
def cluster_is_stopping_then():
    pytest.skip("Cannot observe internal cluster STOPPING state in lws")
