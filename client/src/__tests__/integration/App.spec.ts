import { test, describe, expect } from "vitest";
import { mount } from "@vue/test-utils";
import App from "./../../App.vue";

describe("App", () => {
  describe("when mounting", () => {
    test("can renderq", () => {
      const wrapper = mount(App);

      expect(wrapper.html()).toBeTruthy();
      expect(wrapper.exists()).toBeTruthy();
    });
  });
});
