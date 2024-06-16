export function alignmentAnimation(alignment?: Alignment, option?: AlignmentOption) {
  if (alignment === Alignment.Start) {
    option?.onStart?.()
  } else if (alignment === Alignment.TopStart || alignment === Alignment.Top || alignment === Alignment.TopEnd) {
    option?.onTop?.()
  } else if (alignment === Alignment.End) {
    option?.onEnd?.()
  } else if (alignment === Alignment.BottomStart || alignment === Alignment.Bottom ||
    alignment === Alignment.BottomEnd) {
    option?.onBottom?.()
  } else {
    option?.onCenter?.()
  }
}

class AlignmentOption {
  onStart?: VoidCallback
  onTop?: VoidCallback
  onEnd?: VoidCallback
  onBottom?: VoidCallback
  onCenter?: VoidCallback
}