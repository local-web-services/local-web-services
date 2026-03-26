"""Architecture test: given/when/then __init__.py must import every step file."""
from __future__ import annotations

from lws_arch_tests._root import project_root
from lws_arch_tests._step_dirs import STEP_DIR_NAMES, find_step_service_dirs


class TestInitImportsAllSteps:
    def test_init_imports_all_steps(self):
        # Arrange
        root = project_root()
        violations: list[str] = []

        # Act
        for service_dir in find_step_service_dirs(root):
            for step_dir_name in STEP_DIR_NAMES:
                step_dir = service_dir / step_dir_name
                if not step_dir.exists():
                    continue
                init_py = step_dir / "__init__.py"
                if not init_py.exists():
                    rel = step_dir.relative_to(root)
                    violations.append(f"{rel}/: missing __init__.py")
                    continue
                init_text = init_py.read_text(encoding="utf-8")
                for step_file in sorted(step_dir.glob("*.py")):
                    if step_file.name == "__init__.py":
                        continue
                    expected = f"from .{step_file.stem} import *"
                    if expected not in init_text:
                        rel = step_file.relative_to(root)
                        violations.append(
                            f"{rel}: not imported in {step_dir_name}/__init__.py"
                            " (step will be silently ignored by pytest-bdd)"
                        )

        # Assert
        assert violations == [], (
            "Step files missing from __init__.py will be silently skipped by pytest-bdd:\n"
            + "\n".join(f"  - {v}" for v in violations)
        )
