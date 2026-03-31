"""Given: a "opensearch" "domain" configuration update begins"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "opensearch" "domain" configuration update begins')
def domain_config_update_begun_given():
    pytest.skip("Cannot pre-set a domain configuration update state for sequence setup")
