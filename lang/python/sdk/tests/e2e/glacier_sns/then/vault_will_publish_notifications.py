"""Then: the "glacier" "vault" will publish job completion notifications to the "sns" "topic" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "vault" will publish job completion notifications to the "sns" "topic"')
def vault_will_publish_notifications(world):
    pytest.skip("Cannot configure Glacier vault notifications in lws")
