"""Load all CloudTrail informal spec scenarios."""

from __future__ import annotations

import glob
import os

from pytest_bdd import scenarios

_INFORMAL = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "../../../../../specification/core/informal")
)


def _has_runnable_scenarios(filepath: str) -> bool:
    with open(filepath) as f:
        content = f.read()
    tags = ("@minimal", "@standard", "@sequence", "@guard")
    return any(tag in content for tag in tags)


for _f in glob.glob(os.path.join(_INFORMAL, "cloudtrail", "*.feature")):
    if _has_runnable_scenarios(_f):
        scenarios(_f)
