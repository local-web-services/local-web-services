"""Then: the cluster is in "FAILED" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is in "FAILED" state')
def cluster_is_failed_then():
    pytest.skip("Cannot observe internal cluster FAILED state in lws")
