@Styles function but() {
  .width(60)
  .height(60)
  .borderRadius(30)
  .backgroundColor('#F4F3FF')
}

@Extend(Text) function textFont(){
  .textAlign(TextAlign.Center)
  .fontColor(20)
  .fontWeight(700)
}
@Component
export default struct TdStats {
  @Prop tdCount: number

  build() {
    Row({ space: 6 }) {
      Column(){
        Text('增加')
          .but()
          .textFont()
      }
      Column({space: 6}){
        Text('农田统计')
          .fontColor(Color.Gray)
          .fontWeight(600)
        Text(this.tdCount.toString())
          .fontSize(20)
          .fontWeight(700)
      }
      Column(){
        Text('修改')
          .but()
          .textFont()
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor(Color.White)
    .padding({top: 45, bottom: 35})
  }
}