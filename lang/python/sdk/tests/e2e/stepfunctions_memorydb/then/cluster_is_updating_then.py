"""Then: the cluster is "UPDATING" and connections may be refused"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "UPDATING" and connections may be refused')
def cluster_is_updating_then(lws_session):
    pytest.skip("Cannot observe MemoryDB cluster UPDATING state in lws")
