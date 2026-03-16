from __future__ import annotations

from dataclasses import dataclass, field


@dataclass
class FakeRoute:
    http_method: str
    resource_path: str
    handler_name: str


@dataclass
class FakeFunction:
    logical_id: str
    handler: str
    environment: dict[str, str] = field(default_factory=dict)


@dataclass
class FakeTable:
    logical_id: str
    table_name: str


@dataclass
class FakeApi:
    logical_id: str
    routes: list[FakeRoute] = field(default_factory=list)


@dataclass
class FakeAppModel:
    functions: list[FakeFunction] = field(default_factory=list)
    tables: list[FakeTable] = field(default_factory=list)
    apis: list[FakeApi] = field(default_factory=list)
