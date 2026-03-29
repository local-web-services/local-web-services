"""Then: the cluster is "MODIFYING" and the notification is "PUBLISHED" to the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "MODIFYING" and the notification is "PUBLISHED" to the topic')
def cluster_modifying_and_notification_published():
    pytest.skip(
        "Cannot trigger internal ElastiCache cluster modification notification delivery in lws"
    )
