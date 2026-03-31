"""Then: the "documentdb" "cluster" will be "MODIFYING" but no event will be delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "documentdb" "cluster" will be "MODIFYING" but no event will be delivered')
def cluster_modifying_but_no_event():
    pytest.skip("Cannot observe internal DocumentDB cluster modification state in lws")
