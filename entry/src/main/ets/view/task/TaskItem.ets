import TaskModel from '../../model/TaskModel'
import Farmland from '../../viewmodel/Farmland'


@Component
export default struct TaskItem {
  @ObjectLink item: Farmland
  onTaskChange: (item: Farmland) => void
  @State times: number = new Date().getTime()


  build() {
    Row(){
      Column({space:10}){
        // 任务状态样式

          Text(`编号：${this.item.id}`)
            .finishedTask()
          Text('名称'+this.item.name)
      }
      Column() {
        Text('开始时间：')
          .fontColor(Color.Black)
          .fontSize(20)

        TextInput({ text: `${parseInt(this.item.qiDong)}` })
          .width(80)
          .backgroundColor('#fff')
          .type(InputType.Number)
            //内容变换时触发
          .onChange(value => {
            //更新任务开始时间
            TaskModel.updateTaskStatus2(this.item.id,value)
            // 填充页面时间
            this.item.qiDong = value
          })
      }

        Toggle({ type: ToggleType.Switch, isOn: this.item.kaiGua })
          .onChange(async val => {
            AlertDialog.show(
              {
                title: `任务！`,
                message: `${this.item.id}任务完成`,
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 10, dy: -400 },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
            // 1.更新当前任务状态
            TaskModel.updateTaskStatus(this.item.id, val)
              .then(() => {
                this.item.kaiGua = val
                // 2.更新已完成任务数量
                this.onTaskChange(this.item)
              })
              .catch(error => console.log('testTag', '更新任务状态失败, id = ', this.item.id, JSON.stringify(error)))

          })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// 任务完成样式
@Extend(Text) function finishedTask(){
  .fontColor('#B1B2B1')
}

// 统一的卡片样式
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}