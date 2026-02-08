"""IStateMachine interface for Step Functions-like state machine execution."""

from abc import abstractmethod

from ldk.interfaces.provider import Provider


class IStateMachine(Provider):
    """Abstract interface for state machine providers (Step Functions-like).

    Implementations execute state machine definitions against
    local provider implementations.
    """

    @abstractmethod
    async def start_execution(
        self,
        state_machine_name: str,
        input_data: dict | None = None,
        execution_name: str | None = None,
    ) -> dict:
        """Start a state machine execution.

        Returns a dict containing at minimum the execution ARN or ID.
        """
        ...
