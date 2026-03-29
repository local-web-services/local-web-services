"""Given: the cluster is "STOPPED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the cluster is "STOPPED"')
def cluster_is_stopped_given():
    pytest.skip("Cannot observe STOPPED cluster state in lws")
