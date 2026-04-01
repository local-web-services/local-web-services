"""pytest-bdd step definitions for the LWS example BDD suite."""

from __future__ import annotations

import pytest
from lws_testing import LwsSession

from .constants import ScenarioContext

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture(scope="module")
def shared_session():
    """One LwsSession server shared across all BDD scenarios in this module."""
    with LwsSession() as s:
        yield s


@pytest.fixture
def ctx(shared_session: LwsSession):
    """Per-scenario context. Resets the shared session before each scenario."""
    shared_session.reset()
    c = ScenarioContext(shared_session)
    yield c
    # Teardown: stop log capture and close any dedicated per-scenario session
    if c._log_capture_cm is not None:
        try:
            c._log_capture_cm.__exit__(None, None, None)
        except Exception:
            pass
    if c._dedicated_session_cm is not None:
        try:
            c._dedicated_session_cm.__exit__(None, None, None)
        except Exception:
            pass
