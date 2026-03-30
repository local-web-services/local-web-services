"""Given: a node failure has occurred in an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a node failure has occurred in an active domain")
def elasticsearch_seq_node_failure():
    pytest.skip("Cannot simulate node failure in lws")
