"""Given: the local and remote domains are the same"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the local and remote domains are the same")
def local_and_remote_domains_are_the_same(world):
    pytest.skip("Same-domain connection validation not testable in stateless integration tests.")
