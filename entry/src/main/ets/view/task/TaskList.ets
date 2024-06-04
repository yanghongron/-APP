import Farmland from '../../viewmodel/Farmland'
import TaskItem from './TaskItem'
import TaskModel from '../../model/TaskModel'

@Component
export default struct TaskList {
  // 总任务数量
  @Link totalTask: number
  @Link finishTask: number
  // 任务数组
  @State tasksF: Farmland[] = []

  aboutToAppear() {
    // 查询任务列表
    console.log('testTag', '初始化组件，查询任务列表')
    TaskModel.getTaskListF()
      .then(tasksF => {
        this.tasksF = tasksF
        // 更新任务状态
        this.handleTaskChange()
      })
  }

  handleTaskChange() {
    // 1.更新任务总数量
    this.totalTask = this.tasksF.length
    // 2.更新已完成任务数量
    this.finishTask = this.tasksF.filter(item => item.kaiGua).length
  }

  build() {
    Column() {

      // 2.任务列表
      List({ space: 10 }) {
        ListItem() {
          Row() {
            Button('数据同步')
              .width('100%')
              .onClick(() => {
                // 查询任务列表
                console.log('testTag', '初始化组件，查询任务列表')
                TaskModel.getTaskListF()
                  .then(tasksF => {
                    this.tasksF = tasksF
                    // 更新任务状态
                    this.handleTaskChange()
                  })
              })
          }
        }

        // 2.任务列表
        ForEach(
          this.tasksF,
          (item: Farmland, index) => {
            ListItem() {
              TaskItem({ item: item, onTaskChange: this.handleTaskChange.bind(this) })
            }
            .swipeAction({ end: this.DeleteButton(index, item.id) })
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }
  }

  // 任务删除
  @Builder DeleteButton(index: number, id: number) {
    Button() {
      Image($r('app.media.delete'))
        .fillColor(Color.White)
        .width(20)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(5)
    .onClick(() => {
      // 修改任务状态
      TaskModel.updateTaskStatus(id, false)
        .then(() => {
          this.tasksF.splice(index, 1)

          // 重新查询
          TaskModel.getTaskListF()
            .then(tasksF => {
              this.tasksF = tasksF
              // 更新任务状态
              this.handleTaskChange()
            })

          console.log('testTag', `尝试修改任务状态，index: ${index}`)
          this.handleTaskChange()
        })
        .catch(error => console.log('testTag', '修改任务状态失败，id = ', id, JSON.stringify(error)))

    })
  }
}
