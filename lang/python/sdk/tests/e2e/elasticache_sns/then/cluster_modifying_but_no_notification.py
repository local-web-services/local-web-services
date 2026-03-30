"""Then: the cluster is "MODIFYING" but no notification is published"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "MODIFYING" but no notification is published')
def cluster_modifying_but_no_notification():
    pytest.skip("Cannot observe internal ElastiCache cluster modification state in lws")
