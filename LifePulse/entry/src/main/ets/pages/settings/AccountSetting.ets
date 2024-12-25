import router from '@ohos.router'
import { NormalSection, StateSection } from '../components/Sections'
import { SubPageNav } from '../components/utilites'
import { UI_Config } from '../config'

@Entry
@Component
struct AccountSetting {
  @State message: string = 'Hello World'
  @State @Watch('onback') clicked: boolean = false
  @State account: string = 'cw061532'
  @State phone: string = '181****2263'

  onback() {
    router.back()
  }

  private blue = UI_Config.PrimaryColor

  @Styles nPadding() {
    .padding({ left: UI_Config.containerPadding, right: UI_Config.containerPadding })
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Row() {
          SubPageNav({ title: '个人资料设置', clicked: $clicked, bgColor: this.blue, fontColor: 'white' })
        }
        // About Account Info
        Column() {
          StateSection({ title: '账号', state: this.account })
          StateSection({ title: '手机号', state: this.phone })
        }

        // About Security
        Column() {
          NormalSection({ title: '登录密码', type: 'entry' })
            .onClick(() => {
              router.pushUrl(
                {
                  url: 'pages/settings/PassWordSetting'
                }
              )
            })
        }
      }
      .width('100%')
    }.alignItems(VerticalAlign.Top)
    .height('100%')
  }
}