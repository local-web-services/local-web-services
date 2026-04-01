"""Then: the "elasticache" "cluster" will be "MODIFYING" and the notification will be "PUBLISHED" to the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "elasticache" "cluster" will be "MODIFYING" and the notification will be "PUBLISHED" to the "sns" "topic"'
)
def cluster_modifying_and_notification_published():
    pytest.skip(
        "Cannot trigger internal ElastiCache cluster modification notification delivery in lws"
    )
