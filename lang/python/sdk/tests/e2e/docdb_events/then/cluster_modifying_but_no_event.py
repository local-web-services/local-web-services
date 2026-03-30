"""Then: the cluster is "MODIFYING" but no event is delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "MODIFYING" but no event is delivered')
def cluster_modifying_but_no_event():
    pytest.skip("Cannot observe internal DocumentDB cluster modification state in lws")
