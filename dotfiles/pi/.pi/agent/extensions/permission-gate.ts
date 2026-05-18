import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";

const DANGEROUS_BASH_PATTERNS: RegExp[] = [
  /\brm\s+-rf\b/,
  /\bsudo\b/,
  /\bmkfs\b/,
  /\bdd\b\s+if=/,
  /\bcurl\b[^\n]*\|[^\n]*\b(sh|bash)\b/,
  /\bwget\b[^\n]*\|[^\n]*\b(sh|bash)\b/,
  /\bchmod\s+-R\b/,
  /\bchown\s+-R\b/,
];

const PROTECTED_PATH_SNIPPETS = [
  "/.env",
  ".pem",
  ".key",
  ".p12",
  "/.ssh/",
  "/.gnupg/",
  "/.aws/",
  "/secrets/",
];

function isProtectedPath(path: string): boolean {
  const normalized = path.toLowerCase();
  return PROTECTED_PATH_SNIPPETS.some((snippet) => normalized.includes(snippet));
}

export default function (pi: ExtensionAPI) {
  pi.on("tool_call", async (event, ctx) => {
    if (isToolCallEventType("bash", event)) {
      const command = event.input.command ?? "";
      const isDangerous = DANGEROUS_BASH_PATTERNS.some((pattern) => pattern.test(command));
      if (!isDangerous) return;

      if (!ctx.hasUI) {
        return { block: true, reason: "Blocked dangerous bash command (no interactive UI)." };
      }

      const ok = await ctx.ui.confirm(
        "Potentially destructive command",
        `Allow this command?\n\n${command}`,
      );
      if (!ok) {
        return { block: true, reason: "Blocked by permission-gate extension." };
      }
      return;
    }

    if (isToolCallEventType("write", event) || isToolCallEventType("edit", event)) {
      const targetPath = event.input.path ?? "";
      if (!targetPath || !isProtectedPath(targetPath)) return;

      if (!ctx.hasUI) {
        return { block: true, reason: `Blocked write to protected path: ${targetPath}` };
      }

      const ok = await ctx.ui.confirm(
        "Protected path",
        `Allow write/edit to protected path?\n\n${targetPath}`,
      );
      if (!ok) {
        return { block: true, reason: "Blocked by permission-gate extension." };
      }
    }
  });
}
