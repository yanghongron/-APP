import CmdPage from './CmdPage'
import StatsCard from './StatsCard'
import TdList from './TdList'

@Component
export default struct HomeIndex {
  @State showPanel: boolean = false
  @State tdCount: number = 10
  @State TdId: number = 0
  onPanelShow() {
    this.showPanel = true
  }

  build() {
    Column() {
      //搜索
      // SearchHeader()
      //统计卡片
      StatsCard({ tdCount: this.tdCount })
        .margin({top:10})

      //农田列表
      TdList({ showPanel: this.onPanelShow.bind(this), tdCount: $tdCount ,TdId: $TdId})
      //控制面板
      Panel(this.showPanel) {
        CmdPage({TdId: this.TdId })
        Row({ space: 50 }) {
          Button('取消').onClick(() => this.showPanel = false)
            .backgroundColor(Color.Gray)
          Button('确定')
            .backgroundColor('#4ECB2A')
            .onClick(() => {
              this.showPanel = false
            })
        }

      }
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask(Color.Gray)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f1f2f3')
  }
}