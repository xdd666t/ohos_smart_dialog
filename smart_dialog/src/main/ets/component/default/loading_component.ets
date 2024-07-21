@Builder
export function defaultLoadingBuilder(empty: ESObject) {
  DefaultLoading()
}

@Component
struct DefaultLoading {
  build() {
    Stack() {
      LoadingProgress().width(80).height(80).color(Color.White)
    }
    .backgroundColor("#FF606060")
    .padding(15)
    .borderRadius(12)
  }
}