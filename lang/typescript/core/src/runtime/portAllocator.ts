import * as net from "node:net";

/**
 * Find a free TCP port on localhost.
 *
 * Binds to port 0 (OS-assigned) and keeps the socket open until the caller
 * is ready to use the port, preventing another process from claiming it in the
 * window between discovery and binding.
 *
 * Returns both the port number and a `release` function.  Call `release()`
 * before passing the port to a server — the server will rebind it.
 *
 * Mirrors the Python `_bound_socket()` helper used by the inprocess transport.
 */
export async function findFreePort(): Promise<{ port: number; release: () => void }> {
  return new Promise((resolve, reject) => {
    const server = net.createServer();
    server.listen(0, "127.0.0.1", () => {
      const address = server.address();
      if (!address || typeof address === "string") {
        server.close();
        reject(new Error("Failed to obtain a free port"));
        return;
      }
      resolve({
        port: address.port,
        release: () => server.close(),
      });
    });
    server.on("error", reject);
  });
}
