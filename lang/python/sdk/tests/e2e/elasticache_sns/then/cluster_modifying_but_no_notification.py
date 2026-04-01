"""Then: the "elasticache" "cluster" will be "MODIFYING" but no notification will be published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "elasticache" "cluster" will be "MODIFYING" but no notification will be published')
def cluster_modifying_but_no_notification():
    pytest.skip("Cannot observe internal ElastiCache cluster modification state in lws")
