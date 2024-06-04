import UserModel from '../../model/UserModel'
import PreferencesUtil from '../../utils/PreferencesUtil'
import User from '../../viewmodel/User'
import app from '@system.app'
@Styles function bG() {
  .backgroundColor(Color.White)
  .borderRadius(20)
  .padding(20)
  .width('95%')
}

@Extend(Text) function tX() {
  .width(100)
  .textAlign(TextAlign.Center)
  .fontSize(20)
  .backgroundColor('#FF19FC')
  .padding(5)
  .borderRadius(10)
}

@Component
export default struct UserPage {
  @State user: User = new User(null,'','')
  @Provide username: string = ''

  async aboutToAppear() {
    this.username  = await PreferencesUtil.getPreferencesValue('MyPreferences', 'LoginUserName', null) as string
    //查询登录用户
    UserModel.getUser(this.username)
      .then(user=>{
        this.user = user
        console.log('testTag', '查询登录用户信息成功')
      })
  }

  //弹框
  dialogController: CustomDialogController = new CustomDialogController({
    builder: LandInfoDialog({ onTaskConfirm: this.handleAddLand.bind(this) }),
  })

  handleAddLand(password: string) {
    UserModel.updateUser(this.user.id, password)
      .then(id => {
        AlertDialog.show(
          {
            title: '正确',
            message: '用户密码修改成功 请重新登录！',
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 10, dy: -400 },
            cancel: () => {
            }
          }
        )
        this.dialogController.close()
        app.terminate();
      })
      .catch(error => console.log('testTag', '修改用户密码失败'))
  }

  build() {
    Column() {
      Row({ space: 10 }) {
        Image($r("app.media.logUser"))
          .width(50)
          .backgroundColor('#F41E21')
          .borderRadius(10)
        Blank()
        Text(`用户：${this.user.username}`)
          .tX()
      }
      .bG()
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)

      Row() {
        Text('修改用户名密码')
        Blank()
        Image($r('app.media.dow'))
          .width(20)
      }
      .bG()
      .margin({ top: 5 })
      .onClick(() => {
        this.dialogController.open()
      })

      Row() {
        Text('注销用户')
        Blank()
        Image($r('app.media.dow'))
          .width(20)
      }
      .bG()
      .margin({ top: 5 })
      .onClick(() => {
        AlertDialog.show(
          {
            title: '注销用户？？', // 标题
            message: '是否需要注销当前用户？？?', // 内容
            autoCancel: false, // 点击遮障层时，是否关闭弹窗。
            alignment: DialogAlignment.Bottom, // 弹窗在竖直方向的对齐方式
            offset: { dx: 0, dy: -400 }, // 弹窗相对alignment位置的偏移量
            primaryButton: {
              value: '取消',
              action: () => {
                console.info('Callback when the first button is clicked');
              }
            },
            secondaryButton: {
              value: '注销',
              fontColor: '#D94838',
              action: () => {
                UserModel.deleteUserById(this.user.id)
                app.terminate()
                console.info('Callback when the second button is clicked');
              }
            },
            cancel: () => { // 点击遮障层关闭dialog时的回调
              console.info('Closed callbacks');
            }
          }
        )

      })

      Row() {
        Text('三峡大学科技学院')
        Blank()
        Image($r('app.media.dow'))
          .width(20)
      }
      .bG()
      .margin({ top: 5 })
      .onClick(() => {
        AlertDialog.show(
          {
            title: '联系我们？？',
            message: '邮箱：2897280721@qq.com',
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 10, dy: -400 },
            cancel: () => {
              console.info('Closed callbacks')
            }
          }
        )
        UserModel.deleteUserById(1)
      })
    }
    .backgroundColor('#F1F2F4')
    .width('100%')
    .height('100%')
  }
}

@CustomDialog
struct LandInfoDialog {
  password: string = ''
  onTaskConfirm: (password: string) => void
  controller: CustomDialogController

  build() {
    Column({ space: 20 }) {

      TextInput({ placeholder: '密码' })
        .onChange(val => {
          if (val == ' ' || val == '' || val == null) {
            AlertDialog.show(
              {
                title: '错误',
                message: '密码不能为空',
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 10, dy: -600 },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
          } else {
            this.password = val
          }


        })

      Row() {
        Button('修改')
          .onClick(() => {
            if (this.password == '') {
              AlertDialog.show(
                {
                  title: '错误',
                  message: '密码不能为空',
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  offset: { dx: 10, dy: -600 },
                  cancel: () => {
                    console.info('Closed callbacks')
                  }
                }
              )
            } else {
              this.onTaskConfirm(this.password)
            }
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