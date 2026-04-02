"""Given: the "opensearch" "domain" blue-green traffic had already been swapped"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" blue-green traffic had already been swapped')
def traffic_already_swapped(world):
    pytest.skip("Blue-green traffic swap state is not available in stateless integration tests.")
