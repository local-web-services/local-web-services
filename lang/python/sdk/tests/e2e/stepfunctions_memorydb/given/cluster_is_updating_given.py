"""Given: the cluster is "UPDATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    pytest.skip("Cannot put a MemoryDB cluster into UPDATING state in lws")
