import TaskModel from '../../model/TaskModel'
import Farmland from '../../viewmodel/Farmland'

@Extend(Text) function textFont() {
  .fontColor(Color.Black)
  .fontSize(18)
}

@Extend(Text) function TitleFont() {
  .fontColor(Color.Black)
  .fontSize(20)
}

@Component
export default struct CmdPage {

  // 当前农田
  @Prop TdId: number
  @State farmLand: Farmland = new Farmland(1, 't1', 23, 23, 20, 34, 888, false, false, false, '9:30', false)

  build() {
    Column({ space: 10 }) {
      Button('数据同步')
        .onClick(() => {
          console.log('testTag', '初始化组件，查询农田详细')
          TaskModel.getTaskById(this.TdId)
            .then(farmLand => {
              this.farmLand = farmLand
            })
        })
      Text(`农田名称：${this.farmLand.name}`)
        .TitleFont()
      Column({ space: 10 }) {
        Text('传感器数据')
          .TitleFont()
        Row({ space: 10 }) {
          Text(`温度：${this.farmLand.temperature}℃`)
            .textFont()
          Text(`空气湿度：${this.farmLand.airHumidity}℃`)
            .textFont()
          Text(`湿度：${this.farmLand.soilMoisture}℃`)
            .textFont()
        }

        Row({ space: 10 }) {
          Text(`CO2：${this.farmLand.cO2}ppm`)
            .textFont()
          Text(`光照：${this.farmLand.light}Lux`)
            .textFont()
        }
      }
      .padding({ top: 10, bottom: 10 })

      Text('定时灌溉')
        .TitleFont()
      Row() {
        Text('频率：')
          .TitleFont()
        Radio({ value: '1', group: 'frequency' })
          .checked(this.farmLand.mDay)
          .onChange(noe => {
            this.farmLand.mDay = noe
          })
        Text('每天')
        Radio({ value: '2', group: 'frequency' })
          .checked(this.farmLand.mWeek)
          .onChange(noe => {
            console.log('testTag',`noe=${noe}`)
            this.farmLand.mWeek = noe
          })
        Text('每周')
        Radio({ value: '3', group: 'frequency' })
          .checked(this.farmLand.mMonth)
          .onChange(noe => {
            this.farmLand.mMonth = noe
          })
        Text('每月')
      }

      Row() {
        Text('开始时间：')
          .TitleFont()
        TextInput({ text: `${this.farmLand.qiDong}` })
          .width(80)
          .backgroundColor('#fff')
            //内容变换时触发
          .onChange(value => {
            this.farmLand.qiDong = value
          })
      }
      .width('94%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        Text('持续时间：')
          .TitleFont()
        Text('10分钟')
      }
      .width('94%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        Text('设置定时灌溉')
          .TitleFont()
        Toggle({ type: ToggleType.Switch, isOn: this.farmLand.kaiGua })
          .onChange(val => {
            TaskModel.updateTaskStatus1(this.farmLand.id, this.farmLand.mDay, this.farmLand.mWeek, this.farmLand.mMonth, this.farmLand.qiDong, val)
          })
      }
    }
    .padding(10)
    .width('94%')
  }
}