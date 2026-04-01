"""Given: the "opensearch" "domain" configuration update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "opensearch" "domain" configuration update completes')
def domain_config_update_completed_given():
    pytest.skip("Cannot pre-set a completed domain configuration update state for sequence setup")
