export type SmartBuilder = (args?: ESObject) => ESObject

export function delay(ms?: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const keepSingleTag = `singleTag:${Date.now()}${Math.random()}`

export function randomTag(keepSingle?: boolean): string
{
  if (keepSingle === true) {
    return keepSingleTag
  } else {
    return `${Date.now()}${Math.random()}`
  }
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

export function onBlockClick(): void {
}