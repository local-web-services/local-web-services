"""Given: a search domain has finished deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a search domain has finished deleting")
def elasticsearch_seq_domain_finished_deleting():
    pytest.skip("Cannot simulate domain deletion completion in lws")
