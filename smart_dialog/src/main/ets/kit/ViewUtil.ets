import { componentUtils } from "@kit.ArkUI";

export class ViewUtil {
  static getRectangleById(id?: string): componentUtils.ComponentInfo | undefined {
    try {
      return componentUtils.getRectangleById(id ?? "")
    } catch (_) {
      return undefined
    }
  }
}