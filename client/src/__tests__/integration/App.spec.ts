import { test, describe, expect } from "vitest";
import { shallowMount } from "@vue/test-utils";
import App from "@/App.vue";
import { assert } from "@/tests/utils";

describe("App", () => {
  describe("when shallow mounting", () => {
    test("can render", async () => {
      const wrapper = shallowMount(App);

      await assert(() => {
        expect(wrapper.html()).toBeTruthy();
        expect(wrapper.exists()).toBeTruthy();
      });
    });
  });
});
