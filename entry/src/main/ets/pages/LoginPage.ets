import router from '@ohos.router'
import UserModel from '../model/UserModel'
import PreferencesUtil from '../utils/PreferencesUtil'
import User from '../viewmodel/User'

@Entry
@Component
struct LoginPage {
  @State username: string = '' //账号
  @State password: string = '' //密码
  @State user: User = new User(null, null, null)


  //弹框
  dialogController: CustomDialogController = new CustomDialogController({
    builder: LandInfoDialog({ onTaskConfirm: this.handleAddLand.bind(this) }),
  })

  handleAddLand(username: string, password: string) {
    UserModel.addUser(username, username)
      .then(id => {
        AlertDialog.show(
          {
            title: '正确',
            message: '注册用户成功 请登录！',
            autoCancel: true,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 10, dy: -600 },
            cancel: () => {
              console.info('Closed callbacks')
            }
          }
        )
        this.dialogController.close()
      })
      .catch(error => console.log('testTag', '新增用户失败'))
  }

  build() {
    Column() {
      Stack() {
        Image($r('app.media.login'))
          .width('100%')
          .height('100%')
          .interpolation(ImageInterpolation.High)

        Column({ space: 10 }) {
          Text('智能灌溉')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          TextInput({ placeholder: '账号' })
            .backgroundColor('#fff')
            .width('80%')
            .onChange(value => {
              this.username = value
            })

          TextInput({ placeholder: '密码' })
            .backgroundColor('#fff')
            .width('80%')
            .type(InputType.Password)
            .onChange(value => {
              this.password = value
            })

          Row() {
            Button('登录')
              .width('30%')
              .backgroundColor(Color.Green)
              .margin({ right: 10 })
              .onClick(() => {
                // 查询用户名密码
                UserModel.getUser(this.username)
                  .then(user => {
                    this.user = user

                  })

                if (this.username == ' ' || this.password == ' ' || this.username == '' || this.password == '' || this.username == null || this.password == null) {
                  AlertDialog.show(
                    {
                      title: '错误',
                      message: '用户名或密码不能位空',
                      autoCancel: true,
                      alignment: DialogAlignment.Bottom,
                      offset: { dx: 10, dy: -600 },
                      cancel: () => {
                        console.info('Closed callbacks')
                      }
                    }
                  )
                } else if (this.username == this.user.username && this.password == this.user.password) {
                  //写入 Preferences
                  PreferencesUtil.putPreferencesValue('MyPreferences', 'LoginUserName', this.user.username)
                  //跳转页面
                  router.replaceUrl({
                    url: 'pages/Index'
                  })
                }
              })

            Button('注册')
              .width('30%')
              .backgroundColor(Color.Green)
              .margin({ left: 10 })
              .onClick(() => {
                // 打开新增表单对话框
                this.dialogController.open()
              })
          }
        }
        .width('90%')

      }

    }
    .width('100%')
    .height('100%')
  }
}


@CustomDialog
struct LandInfoDialog {
  username: string = ''
  password: string = ''
  onTaskConfirm: (username: string, password: string) => void
  controller: CustomDialogController

  build() {
    Column({ space: 20 }) {
      Text('用户注册')
      TextInput({ placeholder: '输入用户名' })
        .onChange(val => {
          if (val == ' ' ||  val == '' ||  val == null ) {
            AlertDialog.show(
              {
                title: '错误',
                message: '用户名或密码不能位空',
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 10, dy: -600 },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
          }else {
            this.username = val
          }

        })

      TextInput({ placeholder: '密码' })
        .onChange(val => {
          if (val == ' ' ||  val == '' ||  val == null ) {
            AlertDialog.show(
              {
                title: '错误',
                message: '用户名或密码不能位空',
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 10, dy: -600 },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
          }else{
            this.password = val
          }


        })

      Row() {
        Button('注册')
          .onClick(() => {
            if(this.username == '' || this.password == ''){
              AlertDialog.show(
                {
                  title: '错误',
                  message: '用户名或密码不能位空',
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  offset: { dx: 10, dy: -600 },
                  cancel: () => {
                    console.info('Closed callbacks')
                  }
                }
              )
            }else {
              this.onTaskConfirm(this.username, this.password)
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
