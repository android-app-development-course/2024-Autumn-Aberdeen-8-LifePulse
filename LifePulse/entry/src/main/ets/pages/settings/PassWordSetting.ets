import router from '@ohos.router'
import { NormalSection, TextInputSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'

@Entry
@Component
struct PassWordSetting {
  @State @Watch('onback') clicked: boolean = false
  blue = UI_Config.PrimaryColor
  @State old_password: string = ''
  @State new_password: string = ''
  @State confirm_password: string = ''
  @State err_code: number = 0 // 0: no error, 1: new password and confirm password are not the same
  @State err: string = ''

  onback() {
    router.back()
  }

  build() {
    Row() {
      Column({ space: UI_Config.columnSpace }) {
        Stack() {
          SubPageNav({ title: '更改密码', clicked: $clicked, bgColor: this.blue, fontColor: 'white' })
          Button('保存')
            .type(ButtonType.Normal)
            .fontSize(UI_Config.normalFontSize)
            .fontWeight(FontWeight.Bold)
            .height(UI_Config.buttonHeight)
            .margin({right: UI_Config.containerMargin})
            .backgroundColor(UI_Config.SuccessColor)
            .borderRadius(UI_Config.buttonBorderRadius)
            .onClick(() => {
              if (this.new_password !== this.confirm_password) {
                this.err_code = 1
                this.err = '两次输入的密码不一致，请重新输入'
                return
              }
              router.back({
                url: 'pages/settings/AccountSetting'
              })
            })
        }.alignContent(Alignment.End)
        // About account
        TextInputSection({ value: $old_password, placeholder: '请输入旧密码', title: '旧密码', type: 'password' })
        TextInputSection({ value: $new_password, placeholder: '请输入新密码', title: '新密码', type: 'password' })
        TextInputSection({ value: $confirm_password, placeholder: '请再次输入新密码', title: '确认密码', type: 'password' })
        if (this.err_code !== 0) {
          Text(this.err)
            .fontColor(UI_Config.DangerColor)
            .fontSize(UI_Config.normalFontSize)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width('100%')
    }.alignItems(VerticalAlign.Top)
    .height('100%')
  }
}