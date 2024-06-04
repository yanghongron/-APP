
@Component
export default struct StatsCard {

  @Prop tdCount: number

  build() {
    Column() {
        // 农田统计
        Row() {
          Column({ space: 6 }) {
            Text('农田总数')
              .fontColor(Color.Black)
              .fontWeight(600)
            Text(this.tdCount.toFixed())
              .fontSize(20)
              .fontWeight(700)
          }
        }
        .justifyContent(FlexAlign.Center)
        .height(90)
    }
    .width('95%')
    .borderRadius(40)
    .backgroundColor(Color.White)
  }
}