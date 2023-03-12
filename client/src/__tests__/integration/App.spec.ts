import { test, describe, expect } from "vitest";
import { shallowMount } from "@vue/test-utils";
import App from "./../../App.vue";

describe("App", () => {
  describe("when shallow mounting", () => {
    test("can render", () => {
      const wrapper = shallowMount(App);

      expect(wrapper.html()).toBeTruthy();
      expect(wrapper.exists()).toBeTruthy();
    });
  });
});
