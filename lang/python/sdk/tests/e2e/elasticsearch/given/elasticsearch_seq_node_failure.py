"""Given: a node failure occurs in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a node failure occurs in an active "elasticsearch" "domain"')
def elasticsearch_seq_node_failure():
    pytest.skip("Cannot simulate node failure in lws")
