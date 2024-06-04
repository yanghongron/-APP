
import BreakpointSystem from '../utils/BreakpointSystem'
import UserPage from '../view/loginUser/UserPage'
import HomeIndex from '../view/record/HomeIndex'
import TaskPage from '../view/task/TaskPage'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp('currentBreakpoint') currentBreakpoint: string = ''

  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number){
    Column({space: 8}){
      Image(image)
        .width(25)
        .backgroundColor(this.currentIndex === index ? Color.Green : Color.Gray)
      Text(title)
        .fontSize(14)
        .fontColor(this.currentIndex === index ? Color.Green : Color.Gray)
    }
  }

  //回调函数初始化
  aboutToAppear(){
    this.breakpointSystem.register()
  }
  //取消回调函数
  aboutToDisappear(){
    this.breakpointSystem.unregister()
  }

  // 判断设备大小
  chooseBarPosition(){
    return {
      sm: BarPosition.End,
      md: BarPosition.Start,
      lg: BarPosition.Start,
    }[this.currentBreakpoint]

  }

  build() {
    Tabs({barPosition: this.chooseBarPosition()}){
      TabContent(){
        HomeIndex()
      }
      .tabBar(this.TabBarBuilder('首页', $r('app.media.home'),0))

      TabContent(){
        TaskPage()
      }
      .tabBar(this.TabBarBuilder('任务', $r('app.media.swing'),1))

      TabContent(){
        UserPage()
      }
      .tabBar(this.TabBarBuilder('我的', $r("app.media.user"),2))
    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentIndex = index)
    .vertical({
      sm: false,
      md: true,
      lg: true
    }[this.currentBreakpoint])
  }
}