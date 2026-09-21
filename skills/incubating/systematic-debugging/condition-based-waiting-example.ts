/**
 * Generic example: adapt this to the project's existing test utilities.
 * It performs no I/O, network access, or state-changing action.
 */
export async function waitFor<T>(
  condition: () => T | undefined | null | false,
  description: string,
  timeoutMs = 5000,
  pollMs = 10
): Promise<T> {
  const startedAt = Date.now();

  while (true) {
    const result = condition();
    if (result) return result;

    if (Date.now() - startedAt >= timeoutMs) {
      throw new Error(`Timeout waiting for ${description} after ${timeoutMs}ms`);
    }

    await new Promise<void>((resolve) => setTimeout(resolve, pollMs));
  }
}

// Example usage:
// const ready = await waitFor(() => state.ready ? state : undefined, 'ready state');
