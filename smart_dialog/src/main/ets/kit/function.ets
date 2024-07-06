export type SmartBuilder = (args?: ESObject) => ESObject

export function delay(ms?: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export function randomTag() {
  return `${Date.now()}${Math.random()}`
}

export function safeReturn(fn: Function, defaultValue: ESObject = undefined): ESObject {
  try {
    return fn()
  } catch (error) {
    return defaultValue
  }
}

export function safeUse(fn: Function) {
  try {
    fn()
  } catch (error) {
  }
}