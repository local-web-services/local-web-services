"""Then: the vault will publish job completion notifications to the topic"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the vault will publish job completion notifications to the topic")
def vault_will_publish_notifications(world):
    pytest.skip("Cannot configure Glacier vault notifications in lws")
