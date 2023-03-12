import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import { configDefaults } from "vitest/config";

// https://vitejs.dev/config/
export default defineConfig(({ command, mode }) => {
  const processEnvViteValues = Object.keys(process.env).reduce(
    (accum: Record<string, any>, key: string) => {
      if (key.startsWith("VITE_APP")) {
        accum[key] = `'${process.env[key]}'`;
      }

      return accum;
    },
    {}
  );

  const isCI = process.env.IS_CI === "true";

  return {
    define: {
      ...processEnvViteValues,
    },
    test: {
      deps: {
        inline: ["moment"],
      },
      environment: "jsdom",
      exclude: [...configDefaults.exclude, "**/playwright/**"],
      mockReset: true,
      restoreMocks: true,
      testTimeout: isCI ? 30000 : 10000,
      hookTimeout: isCI ? 30000 : 10000,
      teardownTimeout: isCI ? 30000 : 10000,
      reporters: ["verbose"],
    },
    plugins: [vue()],
    server: {
      port: 3000,
    },
  };
});
