import TaskModel from '../../model/TaskModel';
import Farmland from '../../viewmodel/Farmland';

@Extend(Text) function textFont() {
  .fontSize(18)
  .fontWeight(700)
}


@Component
export default struct TdList {
  // 农田总数
  @Link tdCount: number
  // 受点击农田id
  @Link TdId: number
  // 农田数组
  @State tasks: Farmland[] = []
  //弹出添加任务框
  showPanel: () => void

  // 信息弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: LandInfoDialog({ onTaskConfirm: this.handleAddLand.bind(this) }),
  })

  aboutToAppear() {
    console.log('testTag', '初始化组件，查询任务列表')
    TaskModel.getTaskList()
      .then(tasks => {
        this.tasks = tasks
        //更新任务状态
        this.handleLandChange()
      })
  }


  //更新农田总数量
  handleLandChange() {
    this.tdCount = this.tasks.length
  }

  // 增加农田

  handleAddLand(name: string, temperature: number, airHumidity: number, soilMoisture: number, cO2: number, light: number) {
    TaskModel.addTask(name, temperature, airHumidity, soilMoisture, cO2, light)
      .then(id => {
        //回填到数组
        this.tasks.push(new Farmland(id, name, temperature, airHumidity, soilMoisture, cO2, light, false, false, false, null, false))
        this.handleLandChange()
        this.dialogController.close()
      })
      .catch(error => console.log('testTag', '新增任务失败'))
  }

  build() {
    List({ space: 10 }) {
      ListItem() {
        Row() {
          Button('增加')
            .width('100%')
            .onClick(() => {
              // 打开新增表单对话框
              this.dialogController.open()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }


      ForEach(this.tasks, (item: Farmland, index) => {
        ListItem() {
          Column() {
            Row({ space: 10 }) {
              Column({ space: 5 }) {
                Text(`编号：${item.id}`)
                  .textFont()
                Text(item.name)
                  .textFont()
              }

              Text(`湿度：${item.soilMoisture}%`)
              Text('开阀')
                .textFont()
              Toggle({ type: ToggleType.Switch, isOn: item.kaiGua })
                .onChange(async val => {
                  TaskModel.updateTaskStatus(item.id, val)
                    .then(() => {
                      item.kaiGua = val
                    })
                    .catch(error => console.log('testTag', '更新任务状态失败, id = ', item.id, JSON.stringify(error)))
                })
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .width('100%')
            .padding(10)
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(18)
          .padding(12)
        }
        .onClick(() => {
          this.TdId = item.id
          this.showPanel()
        })
        .swipeAction({ end: this.DeleteButton(index, item.id) })
      })
    }
    .width('94%')
    .margin({ top: 10 })
    .layoutWeight(1)
    .alignListItem(ListItemAlign.Center)
  }
  //自定义删除函数
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
    .onClick(() => {
      TaskModel.deleteTaskById(id)
        .then(() => {
          this.tasks.splice(index, 1)
          this.handleLandChange()
        })
        .catch(error => console.log('testTag', '删除农田失败'))
    })
  }
}

@CustomDialog
struct LandInfoDialog {
  name: string = ''
  temperature: number = 0
  airHumidity: number = 0
  soilMoisture: number = 0
  cO2: number = 0
  light: number = 0
  onTaskConfirm: (name: string, temperature: number,
                  airHumidity: number, soilMoisture: number,
                  cO2: number, light: number) => void
  controller: CustomDialogController

  build() {
    Column({ space: 20 }) {
      TextInput({ placeholder: '输入农田名' })
        .onChange(val => this.name = val)

      TextInput({ placeholder: '温度' })
        .type(InputType.Number)
        .onChange(val => this.temperature = parseInt(val))

      TextInput({ placeholder: '空气湿度' })
        .type(InputType.Number)
        .onChange(val => this.airHumidity = parseInt(val))
      TextInput({ placeholder: '土壤湿度' })
        .type(InputType.Number)
        .onChange(val => this.soilMoisture = parseInt(val))

      TextInput({ placeholder: '二氧化碳' })
        .type(InputType.Number)
        .onChange(val => this.cO2 = parseInt(val))

      TextInput({ placeholder: '光照' })
        .type(InputType.Number)
        .onChange(val => this.light = parseInt(val))
      Row() {
        Button('确定')
          .onClick(() => {
            this.onTaskConfirm(
              this.name, this.temperature,
              this.airHumidity, this.soilMoisture,
              this.cO2, this.light)
          })

        Button('取消')
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(20)
  }
}

