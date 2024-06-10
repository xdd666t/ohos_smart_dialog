export function delay(ms?: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export function randomTag(){
  return `${Date.now()}${Math.random()}`
}